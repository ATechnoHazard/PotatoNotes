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

  static m1(method, minLength) =>
      "${method} length can\'t be less than ${minLength}";

  static m4(noteSelected) => "${noteSelected} note selected";

  static m5(noteSelected) => "${noteSelected} notes selected";

  static m6(currentPage, totalPages) => "Page ${currentPage} of ${totalPages}";

  static m2(path) => "Backup located at: ${path}";

  static m3(username) => "Logged in as: ${username}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "archive": MessageLookupByLibrary.simpleMessage("Archive"),
        "black": MessageLookupByLibrary.simpleMessage("Black"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "chooseAction": MessageLookupByLibrary.simpleMessage("Choose action"),
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "dark": MessageLookupByLibrary.simpleMessage("Dark"),
        "done": MessageLookupByLibrary.simpleMessage("Done"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "light": MessageLookupByLibrary.simpleMessage("Light"),
        "modifyNotesRoute_color_change":
            MessageLookupByLibrary.simpleMessage("Change note color"),
        "modifyNotesRoute_color_dialogTitle":
            MessageLookupByLibrary.simpleMessage("Note color selector"),
        "modifyNotesRoute_content":
            MessageLookupByLibrary.simpleMessage("Content"),
        "modifyNotesRoute_image": MessageLookupByLibrary.simpleMessage("Image"),
        "modifyNotesRoute_image_add":
            MessageLookupByLibrary.simpleMessage("Add image"),
        "modifyNotesRoute_image_remove":
            MessageLookupByLibrary.simpleMessage("Remove image"),
        "modifyNotesRoute_image_update":
            MessageLookupByLibrary.simpleMessage("Update image"),
        "modifyNotesRoute_list": MessageLookupByLibrary.simpleMessage("List"),
        "modifyNotesRoute_list_entry":
            MessageLookupByLibrary.simpleMessage("Entry"),
        "modifyNotesRoute_list_selectedEntries":
            MessageLookupByLibrary.simpleMessage(" checked entries"),
        "modifyNotesRoute_reminder":
            MessageLookupByLibrary.simpleMessage("Reminder"),
        "modifyNotesRoute_reminder_add":
            MessageLookupByLibrary.simpleMessage("Add a new reminder"),
        "modifyNotesRoute_reminder_date":
            MessageLookupByLibrary.simpleMessage("Date"),
        "modifyNotesRoute_reminder_time":
            MessageLookupByLibrary.simpleMessage("Time"),
        "modifyNotesRoute_reminder_update":
            MessageLookupByLibrary.simpleMessage("Update reminder"),
        "modifyNotesRoute_security_dialog_lengthExceed": m0,
        "modifyNotesRoute_security_dialog_lengthShort": m1,
        "modifyNotesRoute_security_dialog_titlePassword":
            MessageLookupByLibrary.simpleMessage("Set or update password"),
        "modifyNotesRoute_security_dialog_titlePin":
            MessageLookupByLibrary.simpleMessage("Set or update PIN"),
        "modifyNotesRoute_security_dialog_valid":
            MessageLookupByLibrary.simpleMessage(" valid"),
        "modifyNotesRoute_security_hideContent":
            MessageLookupByLibrary.simpleMessage(
                "Hide note content on main page"),
        "modifyNotesRoute_security_password":
            MessageLookupByLibrary.simpleMessage("Password"),
        "modifyNotesRoute_security_pin":
            MessageLookupByLibrary.simpleMessage("PIN"),
        "modifyNotesRoute_security_protectionText":
            MessageLookupByLibrary.simpleMessage("Use a protection for hiding"),
        "modifyNotesRoute_title": MessageLookupByLibrary.simpleMessage("Title"),
        "note_archive_snackbar":
            MessageLookupByLibrary.simpleMessage("Note archived"),
        "note_delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "note_delete_snackbar":
            MessageLookupByLibrary.simpleMessage("Note deleted"),
        "note_edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "note_emptyTrash": MessageLookupByLibrary.simpleMessage("Empty trash"),
        "note_export": MessageLookupByLibrary.simpleMessage("Export"),
        "note_exportLocation":
            MessageLookupByLibrary.simpleMessage("Note exported at"),
        "note_lockedOptions": MessageLookupByLibrary.simpleMessage(
            "Note is locked, use the options on the note screen"),
        "note_pinToNotifs":
            MessageLookupByLibrary.simpleMessage("Pin to notifications"),
        "note_removeFromArchive_snackbar":
            MessageLookupByLibrary.simpleMessage("Note removed from archived"),
        "note_restore_snackbar":
            MessageLookupByLibrary.simpleMessage("Note restored"),
        "note_select": MessageLookupByLibrary.simpleMessage("Select"),
        "note_share": MessageLookupByLibrary.simpleMessage("Share"),
        "note_star": MessageLookupByLibrary.simpleMessage("Star"),
        "note_unstar": MessageLookupByLibrary.simpleMessage("Unstar"),
        "notesMainPageRoute_emptyArchive": MessageLookupByLibrary.simpleMessage(
            "You don\'t have any notes in the archive"),
        "notesMainPageRoute_emptyTrash":
            MessageLookupByLibrary.simpleMessage("Your trash is empty"),
        "notesMainPageRoute_noNotes":
            MessageLookupByLibrary.simpleMessage("No notes added... yet"),
        "notesMainPageRoute_note_deleteDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Once the notes are deleted from here you can\'t restore them.\nAre you sure you want to continue?"),
        "notesMainPageRoute_note_deleteDialog_title":
            MessageLookupByLibrary.simpleMessage("Delete selected notes?"),
        "notesMainPageRoute_note_emptyTrash_content":
            MessageLookupByLibrary.simpleMessage(
                "Once the notes are deleted from here you can\'t restore them.\nAre you sure you want to continue?"),
        "notesMainPageRoute_note_emptyTrash_title":
            MessageLookupByLibrary.simpleMessage("Empty trash?"),
        "notesMainPageRoute_note_hiddenContent":
            MessageLookupByLibrary.simpleMessage("Content hidden"),
        "notesMainPageRoute_note_list_selectedEntries":
            MessageLookupByLibrary.simpleMessage(" entries selected"),
        "notesMainPageRoute_note_remindersSet":
            MessageLookupByLibrary.simpleMessage("Reminders set for note"),
        "notesMainPageRoute_other":
            MessageLookupByLibrary.simpleMessage("Other notes"),
        "notesMainPageRoute_pinnedNote":
            MessageLookupByLibrary.simpleMessage("Pinned note"),
        "notesMainPageRoute_starred":
            MessageLookupByLibrary.simpleMessage("Starred notes"),
        "notesMainPageRoute_writeNote":
            MessageLookupByLibrary.simpleMessage("Write a note"),
        "notes_archive_snackbar":
            MessageLookupByLibrary.simpleMessage("Notes archived"),
        "notes_delete_snackbar":
            MessageLookupByLibrary.simpleMessage("Notes deleted"),
        "notes_removeFromArchive_snackbar":
            MessageLookupByLibrary.simpleMessage("Notes removed from archived"),
        "notes_restore_snackbar":
            MessageLookupByLibrary.simpleMessage("Notes restored"),
        "remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "reset": MessageLookupByLibrary.simpleMessage("Reset"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "searchNotesRoute_filters_case":
            MessageLookupByLibrary.simpleMessage("Case sensitive"),
        "searchNotesRoute_filters_color":
            MessageLookupByLibrary.simpleMessage("Color filter"),
        "searchNotesRoute_filters_date":
            MessageLookupByLibrary.simpleMessage("Date filter"),
        "searchNotesRoute_filters_title":
            MessageLookupByLibrary.simpleMessage("Search filters"),
        "searchNotesRoute_noQuery": MessageLookupByLibrary.simpleMessage(
            "Input something to start the search"),
        "searchNotesRoute_nothingFound": MessageLookupByLibrary.simpleMessage(
            "No notes found that match your search terms"),
        "searchNotesRoute_searchbar":
            MessageLookupByLibrary.simpleMessage("Search..."),
        "securityNoteRoute_request_password":
            MessageLookupByLibrary.simpleMessage(
                "A password is requested to open the note"),
        "securityNoteRoute_request_pin": MessageLookupByLibrary.simpleMessage(
            "A PIN is requested to open the note"),
        "securityNoteRoute_wrong_password":
            MessageLookupByLibrary.simpleMessage("Wrong password"),
        "securityNoteRoute_wrong_pin":
            MessageLookupByLibrary.simpleMessage("Wrong PIN"),
        "semantics_back": MessageLookupByLibrary.simpleMessage("Back"),
        "semantics_color_beige": MessageLookupByLibrary.simpleMessage("Beige"),
        "semantics_color_blue": MessageLookupByLibrary.simpleMessage("Blue"),
        "semantics_color_green": MessageLookupByLibrary.simpleMessage("Green"),
        "semantics_color_none": MessageLookupByLibrary.simpleMessage("None"),
        "semantics_color_orange":
            MessageLookupByLibrary.simpleMessage("Orange"),
        "semantics_color_pink": MessageLookupByLibrary.simpleMessage("Pink"),
        "semantics_color_purple":
            MessageLookupByLibrary.simpleMessage("Purple"),
        "semantics_color_yellow":
            MessageLookupByLibrary.simpleMessage("Yellow"),
        "semantics_hideText": MessageLookupByLibrary.simpleMessage("Hide text"),
        "semantics_modifyNotes_addElement":
            MessageLookupByLibrary.simpleMessage("Add element"),
        "semantics_modifyNotes_image":
            MessageLookupByLibrary.simpleMessage("Note image"),
        "semantics_modifyNotes_security":
            MessageLookupByLibrary.simpleMessage("Security options"),
        "semantics_modifyNotes_star":
            MessageLookupByLibrary.simpleMessage("Star note"),
        "semantics_modifyNotes_unstar":
            MessageLookupByLibrary.simpleMessage("Unstar note"),
        "semantics_notesMainPage_addNote":
            MessageLookupByLibrary.simpleMessage("Add new note"),
        "semantics_notesMainPage_archive":
            MessageLookupByLibrary.simpleMessage("Archive selected notes"),
        "semantics_notesMainPage_changeColor":
            MessageLookupByLibrary.simpleMessage("Change notes color"),
        "semantics_notesMainPage_closeSelector":
            MessageLookupByLibrary.simpleMessage("Close selector"),
        "semantics_notesMainPage_delete":
            MessageLookupByLibrary.simpleMessage("Delete selected notes"),
        "semantics_notesMainPage_favouritesAdd":
            MessageLookupByLibrary.simpleMessage("Add notes to favourites"),
        "semantics_notesMainPage_favouritesRemove":
            MessageLookupByLibrary.simpleMessage("Remove notes to favourites"),
        "semantics_notesMainPage_grid":
            MessageLookupByLibrary.simpleMessage("Switch to grid view"),
        "semantics_notesMainPage_list":
            MessageLookupByLibrary.simpleMessage("Switch to list view"),
        "semantics_notesMainPage_noteSelected": m4,
        "semantics_notesMainPage_notesSelected": m5,
        "semantics_notesMainPage_openMenu":
            MessageLookupByLibrary.simpleMessage("Open menu"),
        "semantics_notesMainPage_restore":
            MessageLookupByLibrary.simpleMessage("Restore selected notes"),
        "semantics_notesMainPage_search":
            MessageLookupByLibrary.simpleMessage("Search notes"),
        "semantics_showText": MessageLookupByLibrary.simpleMessage("Show text"),
        "semantics_welcome_exit":
            MessageLookupByLibrary.simpleMessage("Exit setup"),
        "semantics_welcome_next":
            MessageLookupByLibrary.simpleMessage("Next page"),
        "semantics_welcome_pageIndicator": m6,
        "semantics_welcome_previous":
            MessageLookupByLibrary.simpleMessage("Previous page"),
        "settingsRoute_about": MessageLookupByLibrary.simpleMessage("About"),
        "settingsRoute_about_potatonotes":
            MessageLookupByLibrary.simpleMessage("About PotatoNotes"),
        "settingsRoute_about_potatonotes_design":
            MessageLookupByLibrary.simpleMessage(
                "Design, app branding and app logo by RshBfn"),
        "settingsRoute_about_potatonotes_development":
            MessageLookupByLibrary.simpleMessage(
                "Developed and mantained by HrX03"),
        "settingsRoute_about_sourceCode":
            MessageLookupByLibrary.simpleMessage("PotatoNotes source code"),
        "settingsRoute_backupAndRestore":
            MessageLookupByLibrary.simpleMessage("Backup & restore"),
        "settingsRoute_backupAndRestore_backup":
            MessageLookupByLibrary.simpleMessage("Backup (Experimental)"),
        "settingsRoute_backupAndRestore_backup_done": m2,
        "settingsRoute_backupAndRestore_regenDbEntries":
            MessageLookupByLibrary.simpleMessage("Regenerate database entries"),
        "settingsRoute_backupAndRestore_restore":
            MessageLookupByLibrary.simpleMessage("Restore (Experimental)"),
        "settingsRoute_backupAndRestore_restore_fail":
            MessageLookupByLibrary.simpleMessage("Corrupted or invalid DB!"),
        "settingsRoute_backupAndRestore_restore_success":
            MessageLookupByLibrary.simpleMessage("Done!"),
        "settingsRoute_dev":
            MessageLookupByLibrary.simpleMessage("Developer options"),
        "settingsRoute_dev_idLabels":
            MessageLookupByLibrary.simpleMessage("Show id labels"),
        "settingsRoute_dev_welcomeScreen": MessageLookupByLibrary.simpleMessage(
            "Show welcome screen on next startup"),
        "settingsRoute_gestures":
            MessageLookupByLibrary.simpleMessage("Gestures"),
        "settingsRoute_gestures_quickStar":
            MessageLookupByLibrary.simpleMessage("Double tap note to star"),
        "settingsRoute_themes": MessageLookupByLibrary.simpleMessage("Themes"),
        "settingsRoute_themes_appLanguage":
            MessageLookupByLibrary.simpleMessage("App language"),
        "settingsRoute_themes_appTheme":
            MessageLookupByLibrary.simpleMessage("App theme"),
        "settingsRoute_themes_customAccentColor":
            MessageLookupByLibrary.simpleMessage("Custom color"),
        "settingsRoute_themes_followSystem":
            MessageLookupByLibrary.simpleMessage("Follow system theme"),
        "settingsRoute_themes_systemDarkMode":
            MessageLookupByLibrary.simpleMessage("Auto dark theme mode"),
        "settingsRoute_themes_systemDefault":
            MessageLookupByLibrary.simpleMessage("System"),
        "settingsRoute_themes_useCustomAccent":
            MessageLookupByLibrary.simpleMessage("Use custom accent color"),
        "settingsRoute_title": MessageLookupByLibrary.simpleMessage("Settings"),
        "syncLoginRoute_emailOrUsername":
            MessageLookupByLibrary.simpleMessage("Email or username"),
        "syncLoginRoute_emptyField":
            MessageLookupByLibrary.simpleMessage("This field can\'t be empty!"),
        "syncLoginRoute_login": MessageLookupByLibrary.simpleMessage("Login"),
        "syncLoginRoute_noteConflictDialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Saved notes and synced notes conflict.\nWhat do you want to do?"),
        "syncLoginRoute_noteConflictDialog_keep":
            MessageLookupByLibrary.simpleMessage(
                "Keep current and upload them"),
        "syncLoginRoute_noteConflictDialog_replace":
            MessageLookupByLibrary.simpleMessage("Replace saved with cloud"),
        "syncLoginRoute_noteConflictDialog_title":
            MessageLookupByLibrary.simpleMessage("Notes found on your account"),
        "syncLoginRoute_password":
            MessageLookupByLibrary.simpleMessage("Password"),
        "syncLoginRoute_register":
            MessageLookupByLibrary.simpleMessage("Register"),
        "syncLoginRoute_successfulRegistration":
            MessageLookupByLibrary.simpleMessage("Registered with success"),
        "syncManageRoute_account":
            MessageLookupByLibrary.simpleMessage("Account"),
        "syncManageRoute_account_changeImage":
            MessageLookupByLibrary.simpleMessage("Change image"),
        "syncManageRoute_account_changeUsername":
            MessageLookupByLibrary.simpleMessage("Change username"),
        "syncManageRoute_account_guest":
            MessageLookupByLibrary.simpleMessage("Guest"),
        "syncManageRoute_account_loggedInAs": m3,
        "syncManageRoute_account_logout":
            MessageLookupByLibrary.simpleMessage("Logout"),
        "syncManageRoute_sync": MessageLookupByLibrary.simpleMessage("Sync"),
        "syncManageRoute_sync_autoSyncInterval":
            MessageLookupByLibrary.simpleMessage(
                "Auto-sync time interval (seconds)"),
        "syncManageRoute_sync_enableAutoSync":
            MessageLookupByLibrary.simpleMessage("Enable auto sync"),
        "syncRegisterRoute_confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "syncRegisterRoute_confirmPassword_noMatch":
            MessageLookupByLibrary.simpleMessage("Password don\'t match"),
        "syncRegisterRoute_email":
            MessageLookupByLibrary.simpleMessage("Email"),
        "syncRegisterRoute_email_empty":
            MessageLookupByLibrary.simpleMessage("Email can\'t be empty"),
        "syncRegisterRoute_email_invalidFormat":
            MessageLookupByLibrary.simpleMessage("Invalid email format"),
        "syncRegisterRoute_password":
            MessageLookupByLibrary.simpleMessage("Password"),
        "syncRegisterRoute_password_empty":
            MessageLookupByLibrary.simpleMessage("Password can\'t be empty"),
        "syncRegisterRoute_register":
            MessageLookupByLibrary.simpleMessage("Register"),
        "syncRegisterRoute_username":
            MessageLookupByLibrary.simpleMessage("Username"),
        "syncRegisterRoute_username_empty":
            MessageLookupByLibrary.simpleMessage("Username can\'t be empty"),
        "sync_accNotFoundError":
            MessageLookupByLibrary.simpleMessage("The account was not found"),
        "sync_dbConnectionError": MessageLookupByLibrary.simpleMessage(
            "There was a problem connecting to the database, retry later"),
        "sync_emailAlreadyExistsError": MessageLookupByLibrary.simpleMessage(
            "The email you entered seems to be already registered"),
        "sync_invalidCredentialsError": MessageLookupByLibrary.simpleMessage(
            "Bad username/email and password combination"),
        "sync_malformedEmailError":
            MessageLookupByLibrary.simpleMessage("Malformed or missing email"),
        "sync_missingNoteIdError": MessageLookupByLibrary.simpleMessage(
            "You can\'t create a note without an id"),
        "sync_notFoundError":
            MessageLookupByLibrary.simpleMessage("The account was not found"),
        "sync_outOfBoundsError": MessageLookupByLibrary.simpleMessage(
            "The input you entered is too long or too short"),
        "sync_passOutOfBoundsError": MessageLookupByLibrary.simpleMessage(
            "The password you entered is too long or too short"),
        "sync_userNotFoundError":
            MessageLookupByLibrary.simpleMessage("The user was not found"),
        "sync_usernameAlreadyExistsError": MessageLookupByLibrary.simpleMessage(
            "The username you entered seems to be already registered"),
        "sync_usernameNotFoundError": MessageLookupByLibrary.simpleMessage(
            "This username isn\'t registered"),
        "sync_usernameOutOfBoundsError": MessageLookupByLibrary.simpleMessage(
            "The username you entered is too long or too short"),
        "trash": MessageLookupByLibrary.simpleMessage("Trash"),
        "undo": MessageLookupByLibrary.simpleMessage("Undo"),
        "userInfoRoute_avatar_change":
            MessageLookupByLibrary.simpleMessage("Change avatar"),
        "userInfoRoute_avatar_remove":
            MessageLookupByLibrary.simpleMessage("Remove avatar"),
        "userInfoRoute_sortByDate":
            MessageLookupByLibrary.simpleMessage("Sort notes by date"),
        "welcomeRoute_firstPage_catchPhrase":
            MessageLookupByLibrary.simpleMessage(
                "Your new favourite notes app"),
        "welcomeRoute_fourthPage_description": MessageLookupByLibrary.simpleMessage(
            "And with this you’re finally done. Now you can finally have fun! Hooray!"),
        "welcomeRoute_fourthPage_thankyou":
            MessageLookupByLibrary.simpleMessage(
                "Thanks for choosing PotatoNotes"),
        "welcomeRoute_fourthPage_title":
            MessageLookupByLibrary.simpleMessage("Setup complete"),
        "welcomeRoute_secondPage_title":
            MessageLookupByLibrary.simpleMessage("Basic customization"),
        "welcomeRoute_thirdPage_description": MessageLookupByLibrary.simpleMessage(
            "With a free PotatoSync account, you can sync your notes between multiple devices. And it’s super easy to get one!"),
        "welcomeRoute_thirdPage_getStarted":
            MessageLookupByLibrary.simpleMessage("Get started"),
        "welcomeRoute_thirdPage_success": MessageLookupByLibrary.simpleMessage(
            "PotatoSync has been configured successfully. Well done!")
      };
}
