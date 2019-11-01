// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(method, maxLength) => "${method} length can\'t exceed ${maxLength}";

  static m1(method, minLength) => "${method} length can\'t be less than ${minLength}";

  static m2(path) => "Backup located at: ${path}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "archive" : MessageLookupByLibrary.simpleMessage("Archive"),
    "black" : MessageLookupByLibrary.simpleMessage("Black"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "chooseAction" : MessageLookupByLibrary.simpleMessage("Choose action"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Confirm"),
    "dark" : MessageLookupByLibrary.simpleMessage("Dark"),
    "done" : MessageLookupByLibrary.simpleMessage("Done"),
    "light" : MessageLookupByLibrary.simpleMessage("Light"),
    "modifyNotesRoute_color_change" : MessageLookupByLibrary.simpleMessage("Change note color"),
    "modifyNotesRoute_color_dialogTitle" : MessageLookupByLibrary.simpleMessage("Note color selector"),
    "modifyNotesRoute_content" : MessageLookupByLibrary.simpleMessage("Content"),
    "modifyNotesRoute_image" : MessageLookupByLibrary.simpleMessage("Image"),
    "modifyNotesRoute_image_add" : MessageLookupByLibrary.simpleMessage("Add image"),
    "modifyNotesRoute_image_remove" : MessageLookupByLibrary.simpleMessage("Remove image"),
    "modifyNotesRoute_image_update" : MessageLookupByLibrary.simpleMessage("Update image"),
    "modifyNotesRoute_list" : MessageLookupByLibrary.simpleMessage("List"),
    "modifyNotesRoute_list_entry" : MessageLookupByLibrary.simpleMessage("Entry"),
    "modifyNotesRoute_list_selectedEntries" : MessageLookupByLibrary.simpleMessage(" checked entries"),
    "modifyNotesRoute_reminder" : MessageLookupByLibrary.simpleMessage("Reminder"),
    "modifyNotesRoute_reminder_add" : MessageLookupByLibrary.simpleMessage("Add a new reminder"),
    "modifyNotesRoute_reminder_date" : MessageLookupByLibrary.simpleMessage("Date"),
    "modifyNotesRoute_reminder_time" : MessageLookupByLibrary.simpleMessage("Time"),
    "modifyNotesRoute_reminder_update" : MessageLookupByLibrary.simpleMessage("Update reminder"),
    "modifyNotesRoute_security_dialog_lengthExceed" : m0,
    "modifyNotesRoute_security_dialog_lengthShort" : m1,
    "modifyNotesRoute_security_dialog_titlePassword" : MessageLookupByLibrary.simpleMessage("Set or update password"),
    "modifyNotesRoute_security_dialog_titlePin" : MessageLookupByLibrary.simpleMessage("Set or update PIN"),
    "modifyNotesRoute_security_dialog_valid" : MessageLookupByLibrary.simpleMessage(" valid"),
    "modifyNotesRoute_security_hideContent" : MessageLookupByLibrary.simpleMessage("Hide note content on main page"),
    "modifyNotesRoute_security_password" : MessageLookupByLibrary.simpleMessage("Password"),
    "modifyNotesRoute_security_pin" : MessageLookupByLibrary.simpleMessage("PIN"),
    "modifyNotesRoute_security_protectionText" : MessageLookupByLibrary.simpleMessage("Use a protection for hiding"),
    "modifyNotesRoute_title" : MessageLookupByLibrary.simpleMessage("Title"),
    "note_archive_snackbar" : MessageLookupByLibrary.simpleMessage("Note archived"),
    "note_delete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "note_delete_snackbar" : MessageLookupByLibrary.simpleMessage("Note deleted"),
    "note_edit" : MessageLookupByLibrary.simpleMessage("Edit"),
    "note_emptryTrash" : MessageLookupByLibrary.simpleMessage("Empty trash"),
    "note_export" : MessageLookupByLibrary.simpleMessage("Export"),
    "note_exportLocation" : MessageLookupByLibrary.simpleMessage("Note exported at"),
    "note_lockedOptions" : MessageLookupByLibrary.simpleMessage("Note is locked, use the options on the note screen"),
    "note_pinToNotifs" : MessageLookupByLibrary.simpleMessage("Pin to notifications"),
    "note_removeFromArchive_snackbar" : MessageLookupByLibrary.simpleMessage("Note removed from archived"),
    "note_restore_snackbar" : MessageLookupByLibrary.simpleMessage("Note restored"),
    "note_select" : MessageLookupByLibrary.simpleMessage("Select"),
    "note_share" : MessageLookupByLibrary.simpleMessage("Share"),
    "note_star" : MessageLookupByLibrary.simpleMessage("Star"),
    "note_unstar" : MessageLookupByLibrary.simpleMessage("Unstar"),
    "notes" : MessageLookupByLibrary.simpleMessage("Notes"),
    "notesMainPageRoute_emptyArchive" : MessageLookupByLibrary.simpleMessage("You don\'t have any notes in the archive"),
    "notesMainPageRoute_emptyTrash" : MessageLookupByLibrary.simpleMessage("Your trash is empty"),
    "notesMainPageRoute_noNotes" : MessageLookupByLibrary.simpleMessage("No notes added... yet"),
    "notesMainPageRoute_note_deleteDialog_content" : MessageLookupByLibrary.simpleMessage("Once the notes are deleted from here you can\'t restore them.\nAre you sure you want to continue?"),
    "notesMainPageRoute_note_deleteDialog_title" : MessageLookupByLibrary.simpleMessage("Delete selected notes?"),
    "notesMainPageRoute_note_emptyTrash_content" : MessageLookupByLibrary.simpleMessage("Once the notes are deleted from here you can\'t restore them.\nAre you sure you want to continue?"),
    "notesMainPageRoute_note_emptyTrash_title" : MessageLookupByLibrary.simpleMessage("Empty trash?"),
    "notesMainPageRoute_note_hiddenContent" : MessageLookupByLibrary.simpleMessage("Content hidden"),
    "notesMainPageRoute_note_list_selectedEntries" : MessageLookupByLibrary.simpleMessage(" entries selected"),
    "notesMainPageRoute_note_remindersSet" : MessageLookupByLibrary.simpleMessage("Reminders set for note"),
    "notesMainPageRoute_other" : MessageLookupByLibrary.simpleMessage("Other notes"),
    "notesMainPageRoute_pinnedNote" : MessageLookupByLibrary.simpleMessage("Pinned note"),
    "notesMainPageRoute_starred" : MessageLookupByLibrary.simpleMessage("Starred notes"),
    "notesMainPageRoute_writeNote" : MessageLookupByLibrary.simpleMessage("Write a note"),
    "notes_archive_snackbar" : MessageLookupByLibrary.simpleMessage("Notes archived"),
    "notes_delete_snackbar" : MessageLookupByLibrary.simpleMessage("Notes deleted"),
    "notes_removeFromArchive_snackbar" : MessageLookupByLibrary.simpleMessage("Notes removed from archived"),
    "notes_restore_snackbar" : MessageLookupByLibrary.simpleMessage("Notes restored"),
    "remove" : MessageLookupByLibrary.simpleMessage("Remove"),
    "reset" : MessageLookupByLibrary.simpleMessage("Reset"),
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "searchNotesRoute_filters_case" : MessageLookupByLibrary.simpleMessage("Case sensitive"),
    "searchNotesRoute_filters_color" : MessageLookupByLibrary.simpleMessage("Color filter"),
    "searchNotesRoute_filters_date" : MessageLookupByLibrary.simpleMessage("Date filter"),
    "searchNotesRoute_filters_title" : MessageLookupByLibrary.simpleMessage("Search filters"),
    "searchNotesRoute_noQuery" : MessageLookupByLibrary.simpleMessage("Input something to start the search"),
    "searchNotesRoute_nothingFound" : MessageLookupByLibrary.simpleMessage("No notes found that match your search terms"),
    "searchNotesRoute_searchbar" : MessageLookupByLibrary.simpleMessage("Search..."),
    "securityNoteRoute_request_password" : MessageLookupByLibrary.simpleMessage("A password is requested to open the note"),
    "securityNoteRoute_request_pin" : MessageLookupByLibrary.simpleMessage("A PIN is requested to open the note"),
    "securityNoteRoute_wrong_password" : MessageLookupByLibrary.simpleMessage("Wrong password"),
    "securityNoteRoute_wrong_pin" : MessageLookupByLibrary.simpleMessage("Wrong PIN"),
    "settingsRoute_about" : MessageLookupByLibrary.simpleMessage("About"),
    "settingsRoute_about_potatonotes" : MessageLookupByLibrary.simpleMessage("About PotatoNotes"),
    "settingsRoute_about_potatonotes_design" : MessageLookupByLibrary.simpleMessage("Design, app branding and app logo by RshBfn"),
    "settingsRoute_about_potatonotes_development" : MessageLookupByLibrary.simpleMessage("Developed and mantained by HrX03"),
    "settingsRoute_about_sourceCode" : MessageLookupByLibrary.simpleMessage("PotatoNotes source code"),
    "settingsRoute_backupAndRestore" : MessageLookupByLibrary.simpleMessage("Backup & restore"),
    "settingsRoute_backupAndRestore_backup" : MessageLookupByLibrary.simpleMessage("Backup (Experimental)"),
    "settingsRoute_backupAndRestore_backup_done" : m2,
    "settingsRoute_backupAndRestore_regenDbEntries" : MessageLookupByLibrary.simpleMessage("Regenerate database entries"),
    "settingsRoute_backupAndRestore_restore" : MessageLookupByLibrary.simpleMessage("Restore (Experimental)"),
    "settingsRoute_backupAndRestore_restore_fail" : MessageLookupByLibrary.simpleMessage("Corrupted or invalid DB!"),
    "settingsRoute_backupAndRestore_restore_success" : MessageLookupByLibrary.simpleMessage("Done!"),
    "settingsRoute_dev" : MessageLookupByLibrary.simpleMessage("Developer options"),
    "settingsRoute_dev_idLabels" : MessageLookupByLibrary.simpleMessage("Show id labels"),
    "settingsRoute_gestures" : MessageLookupByLibrary.simpleMessage("Gestures"),
    "settingsRoute_gestures_quickStar" : MessageLookupByLibrary.simpleMessage("Double tap note to star"),
    "settingsRoute_themes" : MessageLookupByLibrary.simpleMessage("Themes"),
    "settingsRoute_themes_appTheme" : MessageLookupByLibrary.simpleMessage("App theme"),
    "settingsRoute_themes_customAccentColor" : MessageLookupByLibrary.simpleMessage("Custom color"),
    "settingsRoute_themes_followSystem" : MessageLookupByLibrary.simpleMessage("Follow system theme"),
    "settingsRoute_themes_systemDarkMode" : MessageLookupByLibrary.simpleMessage("Auto dark theme mode"),
    "settingsRoute_themes_useCustomAccent" : MessageLookupByLibrary.simpleMessage("Use custom accent color"),
    "settingsRoute_title" : MessageLookupByLibrary.simpleMessage("Settings"),
    "trash" : MessageLookupByLibrary.simpleMessage("Trash"),
    "undo" : MessageLookupByLibrary.simpleMessage("Undo"),
    "userInfoRoute_avatar_change" : MessageLookupByLibrary.simpleMessage("Change avatar"),
    "userInfoRoute_avatar_remove" : MessageLookupByLibrary.simpleMessage("Remove avatar"),
    "userInfoRoute_sortByDate" : MessageLookupByLibrary.simpleMessage("Sort notes by date")
  };
}
