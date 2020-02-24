// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  static m0(method, maxLength) => "${method} 長度請勿超過 ${maxLength} 個字元";

  static m1(method, minLength) => "${method} 長度請勿短於 ${minLength} 個字元";

  static m2(noteSelected) => "已選取 ${noteSelected} 則筆記";

  static m3(noteSelected) => "已選取 ${noteSelected} 則筆記";

  static m4(currentPage, totalPages) => "${totalPages} 中的第 ${currentPage} 頁";

  static m5(path) => "已備份於：${path}";

  static m6(username) => "登入為：${username}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "archive": MessageLookupByLibrary.simpleMessage("封存"),
        "black": MessageLookupByLibrary.simpleMessage("黑色"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "chooseAction": MessageLookupByLibrary.simpleMessage("選擇動作"),
        "close": MessageLookupByLibrary.simpleMessage("關閉"),
        "confirm": MessageLookupByLibrary.simpleMessage("確認"),
        "dark": MessageLookupByLibrary.simpleMessage("深色"),
        "done": MessageLookupByLibrary.simpleMessage("完成"),
        "home": MessageLookupByLibrary.simpleMessage("首頁"),
        "light": MessageLookupByLibrary.simpleMessage("亮色"),
        "modifyNotesRoute_color_change":
            MessageLookupByLibrary.simpleMessage("變更記事顏色"),
        "modifyNotesRoute_color_dialogTitle":
            MessageLookupByLibrary.simpleMessage("記事顏色選取工具"),
        "modifyNotesRoute_content": MessageLookupByLibrary.simpleMessage("内容"),
        "modifyNotesRoute_image": MessageLookupByLibrary.simpleMessage("圖片"),
        "modifyNotesRoute_image_add":
            MessageLookupByLibrary.simpleMessage("新增圖片"),
        "modifyNotesRoute_image_remove":
            MessageLookupByLibrary.simpleMessage("移除圖片"),
        "modifyNotesRoute_image_update":
            MessageLookupByLibrary.simpleMessage("更新圖片"),
        "modifyNotesRoute_list": MessageLookupByLibrary.simpleMessage("清單"),
        "modifyNotesRoute_list_entry":
            MessageLookupByLibrary.simpleMessage("項目"),
        "modifyNotesRoute_list_selectedEntries":
            MessageLookupByLibrary.simpleMessage(" 個選取的項目"),
        "modifyNotesRoute_reminder": MessageLookupByLibrary.simpleMessage("提醒"),
        "modifyNotesRoute_reminder_add":
            MessageLookupByLibrary.simpleMessage("建立新提醒"),
        "modifyNotesRoute_reminder_date":
            MessageLookupByLibrary.simpleMessage("日期"),
        "modifyNotesRoute_reminder_time":
            MessageLookupByLibrary.simpleMessage("時間"),
        "modifyNotesRoute_reminder_update":
            MessageLookupByLibrary.simpleMessage("更新提醒"),
        "modifyNotesRoute_security_dialog_lengthExceed": m0,
        "modifyNotesRoute_security_dialog_lengthShort": m1,
        "modifyNotesRoute_security_dialog_titlePassword":
            MessageLookupByLibrary.simpleMessage("設定或變更密碼"),
        "modifyNotesRoute_security_dialog_titlePin":
            MessageLookupByLibrary.simpleMessage("設定或變更 PIN 碼"),
        "modifyNotesRoute_security_dialog_valid":
            MessageLookupByLibrary.simpleMessage(" 有效"),
        "modifyNotesRoute_security_hideContent":
            MessageLookupByLibrary.simpleMessage("於主頁面隱藏記事內容"),
        "modifyNotesRoute_security_password":
            MessageLookupByLibrary.simpleMessage("密碼"),
        "modifyNotesRoute_security_pin":
            MessageLookupByLibrary.simpleMessage("PIN 碼"),
        "modifyNotesRoute_security_protectionText":
            MessageLookupByLibrary.simpleMessage("選擇保護方式"),
        "modifyNotesRoute_title": MessageLookupByLibrary.simpleMessage("標題"),
        "note_archive_snackbar": MessageLookupByLibrary.simpleMessage("筆記已封存"),
        "note_delete": MessageLookupByLibrary.simpleMessage("刪除"),
        "note_delete_snackbar": MessageLookupByLibrary.simpleMessage("筆記已刪除"),
        "note_edit": MessageLookupByLibrary.simpleMessage("編輯"),
        "note_emptyTrash": MessageLookupByLibrary.simpleMessage("清空垃圾桶"),
        "note_export": MessageLookupByLibrary.simpleMessage("匯出"),
        "note_exportLocation": MessageLookupByLibrary.simpleMessage("已將記事匯出於"),
        "note_lockedOptions":
            MessageLookupByLibrary.simpleMessage("記事已鎖定，請於記事頁面變更選項"),
        "note_pinToNotifs": MessageLookupByLibrary.simpleMessage("固定至通知區域"),
        "note_removeFromArchive_snackbar":
            MessageLookupByLibrary.simpleMessage("已從封存中還原筆記"),
        "note_restore_snackbar": MessageLookupByLibrary.simpleMessage("筆記已還原"),
        "note_select": MessageLookupByLibrary.simpleMessage("選取"),
        "note_share": MessageLookupByLibrary.simpleMessage("分享"),
        "note_star": MessageLookupByLibrary.simpleMessage("加上星號"),
        "note_unstar": MessageLookupByLibrary.simpleMessage("移除星號"),
        "notesMainPageRoute_emptyArchive":
            MessageLookupByLibrary.simpleMessage("你封存的記事會顯示在這裡"),
        "notesMainPageRoute_emptyTrash":
            MessageLookupByLibrary.simpleMessage("垃圾桶內沒有任何記事"),
        "notesMainPageRoute_noNotes":
            MessageLookupByLibrary.simpleMessage("你新增的記事會顯示在這裡"),
        "notesMainPageRoute_note_deleteDialog_content":
            MessageLookupByLibrary.simpleMessage("垃圾桶中的所有記事將永久刪除。"),
        "notesMainPageRoute_note_deleteDialog_title":
            MessageLookupByLibrary.simpleMessage("確認移除選取的記事？"),
        "notesMainPageRoute_note_emptyTrash_content":
            MessageLookupByLibrary.simpleMessage("垃圾桶中的所有記事將永久刪除。"),
        "notesMainPageRoute_note_emptyTrash_title":
            MessageLookupByLibrary.simpleMessage("要清空垃圾桶嗎？"),
        "notesMainPageRoute_note_hiddenContent":
            MessageLookupByLibrary.simpleMessage("內容已隱藏"),
        "notesMainPageRoute_note_list_selectedEntries":
            MessageLookupByLibrary.simpleMessage(" 則選取的記事"),
        "notesMainPageRoute_note_remindersSet":
            MessageLookupByLibrary.simpleMessage("已設定提醒"),
        "notesMainPageRoute_other":
            MessageLookupByLibrary.simpleMessage("其他記事"),
        "notesMainPageRoute_pinnedNote":
            MessageLookupByLibrary.simpleMessage("已固定的記事"),
        "notesMainPageRoute_starred":
            MessageLookupByLibrary.simpleMessage("已加星號的筆記"),
        "notesMainPageRoute_writeNote":
            MessageLookupByLibrary.simpleMessage("新增記事…"),
        "notes_archive_snackbar": MessageLookupByLibrary.simpleMessage("筆記已封存"),
        "notes_delete_snackbar": MessageLookupByLibrary.simpleMessage("筆記已刪除"),
        "notes_removeFromArchive_snackbar":
            MessageLookupByLibrary.simpleMessage("已從封存中還原筆記"),
        "notes_restore_snackbar": MessageLookupByLibrary.simpleMessage("筆記已還原"),
        "remove": MessageLookupByLibrary.simpleMessage("移除"),
        "reset": MessageLookupByLibrary.simpleMessage("重設"),
        "save": MessageLookupByLibrary.simpleMessage("儲存"),
        "searchNotesRoute_filters_case":
            MessageLookupByLibrary.simpleMessage("區分大小寫"),
        "searchNotesRoute_filters_color":
            MessageLookupByLibrary.simpleMessage("以顏色篩選"),
        "searchNotesRoute_filters_date":
            MessageLookupByLibrary.simpleMessage("以日期篩選"),
        "searchNotesRoute_filters_title":
            MessageLookupByLibrary.simpleMessage("搜尋工具"),
        "searchNotesRoute_noQuery":
            MessageLookupByLibrary.simpleMessage("請輸入搜尋關鍵字"),
        "searchNotesRoute_nothingFound":
            MessageLookupByLibrary.simpleMessage("找不到相符的搜尋結果"),
        "searchNotesRoute_searchbar":
            MessageLookupByLibrary.simpleMessage("搜尋…"),
        "securityNoteRoute_request_password":
            MessageLookupByLibrary.simpleMessage("需要密碼以開啟記事"),
        "securityNoteRoute_request_pin":
            MessageLookupByLibrary.simpleMessage("需要 PIN 碼以開啟記事"),
        "securityNoteRoute_wrong_password":
            MessageLookupByLibrary.simpleMessage("密碼錯誤"),
        "securityNoteRoute_wrong_pin":
            MessageLookupByLibrary.simpleMessage("PIN 碼錯誤"),
        "semantics_back": MessageLookupByLibrary.simpleMessage("返回"),
        "semantics_color_beige": MessageLookupByLibrary.simpleMessage("米白色"),
        "semantics_color_blue": MessageLookupByLibrary.simpleMessage("藍色"),
        "semantics_color_green": MessageLookupByLibrary.simpleMessage("綠色"),
        "semantics_color_none": MessageLookupByLibrary.simpleMessage("無"),
        "semantics_color_orange": MessageLookupByLibrary.simpleMessage("橘色"),
        "semantics_color_pink": MessageLookupByLibrary.simpleMessage("粉色"),
        "semantics_color_purple": MessageLookupByLibrary.simpleMessage("紫色"),
        "semantics_color_yellow": MessageLookupByLibrary.simpleMessage("黃色"),
        "semantics_hideText": MessageLookupByLibrary.simpleMessage("隱藏文字"),
        "semantics_modifyNotes_addElement":
            MessageLookupByLibrary.simpleMessage("新增元件"),
        "semantics_modifyNotes_image":
            MessageLookupByLibrary.simpleMessage("筆記圖片"),
        "semantics_modifyNotes_security":
            MessageLookupByLibrary.simpleMessage("安全性選項"),
        "semantics_modifyNotes_star":
            MessageLookupByLibrary.simpleMessage("為筆記加上星號"),
        "semantics_modifyNotes_unstar":
            MessageLookupByLibrary.simpleMessage("取消筆記星號"),
        "semantics_notesMainPage_addNote":
            MessageLookupByLibrary.simpleMessage("新增筆記"),
        "semantics_notesMainPage_archive":
            MessageLookupByLibrary.simpleMessage("封存選取的筆記"),
        "semantics_notesMainPage_changeColor":
            MessageLookupByLibrary.simpleMessage("變更筆記色彩"),
        "semantics_notesMainPage_closeSelector":
            MessageLookupByLibrary.simpleMessage("關閉選取工具"),
        "semantics_notesMainPage_delete":
            MessageLookupByLibrary.simpleMessage("刪除選取的筆記"),
        "semantics_notesMainPage_favouritesAdd":
            MessageLookupByLibrary.simpleMessage("新增筆記至最愛"),
        "semantics_notesMainPage_favouritesRemove":
            MessageLookupByLibrary.simpleMessage("從最愛移除筆記"),
        "semantics_notesMainPage_grid":
            MessageLookupByLibrary.simpleMessage("切換至格狀檢視"),
        "semantics_notesMainPage_list":
            MessageLookupByLibrary.simpleMessage("切換至列表檢視"),
        "semantics_notesMainPage_noteSelected": m2,
        "semantics_notesMainPage_notesSelected": m3,
        "semantics_notesMainPage_openMenu":
            MessageLookupByLibrary.simpleMessage("開啟選單"),
        "semantics_notesMainPage_restore":
            MessageLookupByLibrary.simpleMessage("還原選取的筆記"),
        "semantics_notesMainPage_search":
            MessageLookupByLibrary.simpleMessage("搜尋筆記"),
        "semantics_showText": MessageLookupByLibrary.simpleMessage("顯示文字"),
        "semantics_welcome_exit":
            MessageLookupByLibrary.simpleMessage("離開快速設定"),
        "semantics_welcome_next": MessageLookupByLibrary.simpleMessage("下一頁"),
        "semantics_welcome_pageIndicator": m4,
        "semantics_welcome_previous":
            MessageLookupByLibrary.simpleMessage("上一頁"),
        "settingsRoute_about": MessageLookupByLibrary.simpleMessage("關於"),
        "settingsRoute_about_potatonotes":
            MessageLookupByLibrary.simpleMessage("關於 PotatoNotes"),
        "settingsRoute_about_potatonotes_design":
            MessageLookupByLibrary.simpleMessage("設計、應用程式識別及圖示：RshBfn"),
        "settingsRoute_about_potatonotes_development":
            MessageLookupByLibrary.simpleMessage("開發及維護：HrX03"),
        "settingsRoute_about_sourceCode":
            MessageLookupByLibrary.simpleMessage("PotatoNotes 原始程式碼"),
        "settingsRoute_backupAndRestore":
            MessageLookupByLibrary.simpleMessage("備份與還原"),
        "settingsRoute_backupAndRestore_backup":
            MessageLookupByLibrary.simpleMessage("備份 (實驗性)"),
        "settingsRoute_backupAndRestore_backup_done": m5,
        "settingsRoute_backupAndRestore_regenDbEntries":
            MessageLookupByLibrary.simpleMessage("重新產生資料庫項目"),
        "settingsRoute_backupAndRestore_restore":
            MessageLookupByLibrary.simpleMessage("還原 (實驗性)"),
        "settingsRoute_backupAndRestore_restore_fail":
            MessageLookupByLibrary.simpleMessage("資料庫錯誤或無效！"),
        "settingsRoute_backupAndRestore_restore_success":
            MessageLookupByLibrary.simpleMessage("已完成！"),
        "settingsRoute_dev": MessageLookupByLibrary.simpleMessage("開發人員選項"),
        "settingsRoute_dev_idLabels":
            MessageLookupByLibrary.simpleMessage("顯示編號標籤"),
        "settingsRoute_dev_welcomeScreen":
            MessageLookupByLibrary.simpleMessage("下次開啟時顯示歡迎頁面"),
        "settingsRoute_gestures": MessageLookupByLibrary.simpleMessage("手勢"),
        "settingsRoute_gestures_quickStar":
            MessageLookupByLibrary.simpleMessage("輕觸兩下記事來加上星號"),
        "settingsRoute_themes": MessageLookupByLibrary.simpleMessage("主題"),
        "settingsRoute_themes_appLanguage":
            MessageLookupByLibrary.simpleMessage("應用程式語言"),
        "settingsRoute_themes_appTheme":
            MessageLookupByLibrary.simpleMessage("應用程式主題"),
        "settingsRoute_themes_customAccentColor":
            MessageLookupByLibrary.simpleMessage("自訂顏色"),
        "settingsRoute_themes_followSystem":
            MessageLookupByLibrary.simpleMessage("根據裝置主題進行設定"),
        "settingsRoute_themes_systemDarkMode":
            MessageLookupByLibrary.simpleMessage("自動深色模式"),
        "settingsRoute_themes_systemDefault":
            MessageLookupByLibrary.simpleMessage("系統"),
        "settingsRoute_themes_useCustomAccent":
            MessageLookupByLibrary.simpleMessage("使用自訂強調色"),
        "settingsRoute_title": MessageLookupByLibrary.simpleMessage("設定"),
        "syncLoginRoute_emailOrUsername":
            MessageLookupByLibrary.simpleMessage("電子郵件或使用者名稱"),
        "syncLoginRoute_emptyField":
            MessageLookupByLibrary.simpleMessage("此欄位不得為空！"),
        "syncLoginRoute_login": MessageLookupByLibrary.simpleMessage("登入"),
        "syncLoginRoute_noteConflictDialog_content":
            MessageLookupByLibrary.simpleMessage("現有筆記與同步中的筆記發生衝突。\n請選擇下一步："),
        "syncLoginRoute_noteConflictDialog_keep":
            MessageLookupByLibrary.simpleMessage("保留現有筆記並上傳至雲端"),
        "syncLoginRoute_noteConflictDialog_replace":
            MessageLookupByLibrary.simpleMessage("將現有筆記替換為同步中的版本"),
        "syncLoginRoute_noteConflictDialog_title":
            MessageLookupByLibrary.simpleMessage("帳戶中尚無筆記"),
        "syncLoginRoute_password": MessageLookupByLibrary.simpleMessage("密碼"),
        "syncLoginRoute_register": MessageLookupByLibrary.simpleMessage("註冊"),
        "syncLoginRoute_successfulRegistration":
            MessageLookupByLibrary.simpleMessage("註冊成功"),
        "syncManageRoute_account": MessageLookupByLibrary.simpleMessage("帳戶"),
        "syncManageRoute_account_changeImage":
            MessageLookupByLibrary.simpleMessage("變更圖片"),
        "syncManageRoute_account_changeUsername":
            MessageLookupByLibrary.simpleMessage("變更使用者名稱"),
        "syncManageRoute_account_guest":
            MessageLookupByLibrary.simpleMessage("訪客"),
        "syncManageRoute_account_loggedInAs": m6,
        "syncManageRoute_account_logout":
            MessageLookupByLibrary.simpleMessage("登出"),
        "syncManageRoute_sync": MessageLookupByLibrary.simpleMessage("同步"),
        "syncManageRoute_sync_autoSyncInterval":
            MessageLookupByLibrary.simpleMessage("自動同步間隔（秒）"),
        "syncManageRoute_sync_enableAutoSync":
            MessageLookupByLibrary.simpleMessage("開啟自動同步"),
        "syncRegisterRoute_confirmPassword":
            MessageLookupByLibrary.simpleMessage("確認密碼"),
        "syncRegisterRoute_confirmPassword_noMatch":
            MessageLookupByLibrary.simpleMessage("密碼不相符"),
        "syncRegisterRoute_email": MessageLookupByLibrary.simpleMessage("電子郵件"),
        "syncRegisterRoute_email_empty":
            MessageLookupByLibrary.simpleMessage("電子郵件不得為空"),
        "syncRegisterRoute_email_invalidFormat":
            MessageLookupByLibrary.simpleMessage("電子郵件格式無效"),
        "syncRegisterRoute_password":
            MessageLookupByLibrary.simpleMessage("密碼"),
        "syncRegisterRoute_password_empty":
            MessageLookupByLibrary.simpleMessage("密碼不得為空"),
        "syncRegisterRoute_register":
            MessageLookupByLibrary.simpleMessage("註冊"),
        "syncRegisterRoute_username":
            MessageLookupByLibrary.simpleMessage("使用者名稱"),
        "syncRegisterRoute_username_empty":
            MessageLookupByLibrary.simpleMessage("使用者名稱不得為空"),
        "sync_accNotFoundError": MessageLookupByLibrary.simpleMessage("找不到此帳戶"),
        "sync_dbConnectionError":
            MessageLookupByLibrary.simpleMessage("與資料庫連線時發生錯誤，請稍後再試"),
        "sync_emailAlreadyExistsError":
            MessageLookupByLibrary.simpleMessage("該電子郵件已註冊"),
        "sync_invalidCredentialsError":
            MessageLookupByLibrary.simpleMessage("使用者名稱或電子郵件與密碼不相符"),
        "sync_malformedEmailError":
            MessageLookupByLibrary.simpleMessage("格式錯誤或無電子郵件"),
        "sync_missingNoteIdError":
            MessageLookupByLibrary.simpleMessage("無法建立無 ID 的筆記"),
        "sync_notFoundError": MessageLookupByLibrary.simpleMessage("找不到此帳戶"),
        "sync_outOfBoundsError":
            MessageLookupByLibrary.simpleMessage("輸入內容過長或過短"),
        "sync_passOutOfBoundsError":
            MessageLookupByLibrary.simpleMessage("密碼過長或過短"),
        "sync_userNotFoundError":
            MessageLookupByLibrary.simpleMessage("找不到使用者"),
        "sync_usernameAlreadyExistsError":
            MessageLookupByLibrary.simpleMessage("該使用者名稱已註冊"),
        "sync_usernameNotFoundError":
            MessageLookupByLibrary.simpleMessage("使用者名稱尚未註冊"),
        "sync_usernameOutOfBoundsError":
            MessageLookupByLibrary.simpleMessage("使用者名稱過長或過短"),
        "trash": MessageLookupByLibrary.simpleMessage("垃圾桶"),
        "undo": MessageLookupByLibrary.simpleMessage("復原"),
        "userInfoRoute_avatar_change":
            MessageLookupByLibrary.simpleMessage("變更個人資料相片"),
        "userInfoRoute_avatar_remove":
            MessageLookupByLibrary.simpleMessage("移除個人資料相片"),
        "userInfoRoute_sortByDate":
            MessageLookupByLibrary.simpleMessage("以日期排序"),
        "welcomeRoute_firstPage_catchPhrase":
            MessageLookupByLibrary.simpleMessage("讓您愛不釋手的筆記"),
        "welcomeRoute_fourthPage_description":
            MessageLookupByLibrary.simpleMessage("再幾步即可完成設定！"),
        "welcomeRoute_fourthPage_thankyou":
            MessageLookupByLibrary.simpleMessage("感謝您使用 PotatoNotes"),
        "welcomeRoute_fourthPage_title":
            MessageLookupByLibrary.simpleMessage("設定完成"),
        "welcomeRoute_secondPage_title":
            MessageLookupByLibrary.simpleMessage("基本設定"),
        "welcomeRoute_thirdPage_description":
            MessageLookupByLibrary.simpleMessage(
                "有了 PotatoSync 帳號，您將可在多個裝置間同步筆，且輕鬆即可取得！"),
        "welcomeRoute_thirdPage_getStarted":
            MessageLookupByLibrary.simpleMessage("立即開始"),
        "welcomeRoute_thirdPage_success":
            MessageLookupByLibrary.simpleMessage("PotatoSync 設定成功！")
      };
}
