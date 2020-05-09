import 'package:moor/moor.dart';
import 'package:potato_notes/data/database.dart';

part 'note_helper.g.dart';

@UseDao(tables: [Notes])
class NoteHelper extends DatabaseAccessor<AppDatabase> with _$NoteHelperMixin {
  final AppDatabase db;

  NoteHelper(this.db) : super(db);

  Future<List<Note>> listNotes(ReturnMode mode) async {
    switch (mode) {
      case ReturnMode.NORMAL:
        return (select(notes)
              ..where((table) => table.archived.not() & table.deleted.not()))
            .get();
      case ReturnMode.ARCHIVE:
        return (select(notes)
              ..where((table) => table.archived & table.deleted.not()))
            .get();
      case ReturnMode.TRASH:
        return (select(notes)
              ..where((table) => table.archived.not() & table.deleted))
            .get();
      case ReturnMode.ALL:
      default:
        return select(notes).get();
    }
  }

  Stream<List<Note>> noteStream(ReturnMode mode) {
    SimpleSelectStatement<$NotesTable, Note> selectQuery;

    switch (mode) {
      case ReturnMode.ALL:
        selectQuery = select(notes);
        break;
      case ReturnMode.NORMAL:
        selectQuery = select(notes)
          ..where((table) => table.archived.not() & table.deleted.not());
        break;
      case ReturnMode.ARCHIVE:
        selectQuery = select(notes)
          ..where((table) => table.archived & table.deleted.not());
        break;
      case ReturnMode.TRASH:
        selectQuery = select(notes)
          ..where((table) => table.archived.not() & table.deleted);
        break;
    }

    return (selectQuery
          ..orderBy([
            (table) => OrderingTerm(
                expression: (table).creationDate, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  Future<List<Note>> getNotesMatchingQuery(SearchQuery query) async {
    List<Note> noteList = await select(notes).get();
    List<Note> queryNotes = [];

    String textQuery = query.caseSensitive
        ? query.input
        : query.input.toLowerCase();

    if(textQuery.trim() != "") {
      for(Note note in noteList) {
        List<String> splittedTitle = query.caseSensitive
            ? note.title.split(new RegExp("[ ]{1,}"))
            : note.title.toLowerCase().split(new RegExp("[ ]{1,}"));
        List<String> splittedContent = query.caseSensitive
            ? note.content.split(new RegExp("[ ]{1,}"))
            : note.content.toLowerCase().split(new RegExp("[ ]{1,}"));

        if(splittedTitle.any((element) => element.startsWith(textQuery)) ||
            splittedContent.any((element) => element.startsWith(textQuery))) {
          queryNotes.add(note);
        }
      }
    }

    return queryNotes;
  }

  Future saveNote(Note note) =>
      into(notes).insert(note, mode: InsertMode.replace);

  Future deleteNote(Note note) => delete(notes).delete(note);
}

class SearchQuery {
  String input;
  bool caseSensitive;
  int color;
  DateTime date;

  SearchQuery({
    this.input = "",
    this.caseSensitive = true,
    this.color,
    this.date,
  });
}

enum ReturnMode {
  ALL,
  NORMAL,
  ARCHIVE,
  TRASH,
}
