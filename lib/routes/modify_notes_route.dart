import 'package:flutter/material.dart';

import 'package:potato_notes/internal/note_helper.dart';

class ModifyNotesRoute extends StatefulWidget {
  Note note = Note();
  ModifyNotesRoute(Note note) {
    this.note = note;
  }

  @override
  _ModifyNotesState createState() => new _ModifyNotesState(note);
}

class _ModifyNotesState extends State<ModifyNotesRoute> {
  int noteId;
  String noteTitle = "";
  String noteContent = "";

  _ModifyNotesState(Note note) {
    this.noteId = note.id;
    this.noteTitle = note.title;
    this.noteContent = note.content;
  }

  NoteHelper noteHelper = new NoteHelper();
  static GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: noteTitle);
    TextEditingController contentController = TextEditingController(text: noteContent);

    titleController.selection = TextSelection.collapsed(offset: noteTitle.length);
    contentController.selection = TextSelection.collapsed(offset: noteContent.length);

    Color cardColor = Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).dividerColor
          : Theme.of(context).scaffoldBackgroundColor;

    double cardBrightness = Theme.of(context).brightness == Brightness.dark
          ? 0.5
          : 0.96;

    Color borderCardColor = HSLColor.fromColor(Theme.of(context).textTheme.title.color)
        .withAlpha(0.2)
        .toColor();

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Container(
              height: 70,
              child: Center(
                child: Text(
                  noteId == null ? "Add new note" : "Update note",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 90.0),
            child: ListView(
              children: <Widget>[
                Card(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
                        child: Text(
                          "Title",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        color: HSLColor.fromColor(cardColor)
                            .withLightness(cardBrightness)
                            .toColor(),
                        child: Padding(
                          padding: EdgeInsets.only(top: 6.0, bottom: 6.0, left: 10.0, right: 10.0),
                          child: TextField(
                            controller: titleController,
                            decoration: InputDecoration(hintText: 'Note title', border: InputBorder.none),
                            onChanged: (text) {
                              noteTitle = text;
                            },
                            maxLength: 60,
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                Card(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
                        child: Text(
                          "Content",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        color: HSLColor.fromColor(cardColor)
                            .withLightness(cardBrightness)
                            .toColor(),
                        child: Padding(
                          padding: EdgeInsets.only(top: 6.0, bottom: 6.0, left: 10.0, right: 10.0),
                          child: TextField(
                            controller: contentController,
                            decoration: InputDecoration(hintText: 'Note content', border: InputBorder.none),
                            onChanged: (text) {
                              noteContent = text;
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: 9,
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () async {
          if (noteContent != "") {
            List<Note> noteList = await noteHelper.getNotes();
            int id = noteId == null ? noteList.length : noteId;
            await noteHelper.insert(Note(
                id: id, title: noteTitle, content: noteContent));
            noteList = await noteHelper.getNotes();
            Navigator.pop(context, noteList);
          } else {
            scaffoldKey.currentState.showSnackBar(new SnackBar(
              content: new Text(noteId == null ?
                  "Can't add a note with empty content" :
                  "Can't update a note with empty content"),
            ));
          }
        },
        icon: Icon(Icons.done),
        label: Text("Done"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(0.0),
        child: Builder(
          builder: (context) {
            return BottomAppBar(
              color: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              child: Row(
                children: <Widget>[
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Spacer(flex: 5),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}