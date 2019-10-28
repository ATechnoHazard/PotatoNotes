import 'dart:async';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:potato_notes/internal/app_info.dart';
import 'package:potato_notes/internal/localizations.dart';
import 'package:potato_notes/internal/methods.dart';
import 'package:potato_notes/internal/note_helper.dart';
import 'package:potato_notes/internal/search_filters.dart';
import 'package:potato_notes/routes/modify_notes_route.dart';
import 'package:potato_notes/routes/search_notes_route.dart';
import 'package:potato_notes/routes/security_note_route.dart';
import 'package:potato_notes/routes/settings_route.dart';
import 'package:potato_notes/routes/user_info_route.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class NotesMainPageRoute extends StatefulWidget {
  final List<Note> noteList;

  NotesMainPageRoute({@required this.noteList});

  @override
  _NotesMainPageState createState() => new _NotesMainPageState(noteList);
}

class _NotesMainPageState extends State<NotesMainPageRoute> with SingleTickerProviderStateMixin{
  List<Note> noteList = List<Note>();

  _NotesMainPageState(List<Note> list) {
    this.noteList = list;
  }

  AnimationController controller;

  static GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Note> selectionList = List<Note>();
  bool isSelectorVisible = false;

  AppInfoProvider appInfo;
  AppLocalizations locales;

  NotesReturnMode currentView = NotesReturnMode.NORMAL;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(value: 1.0, duration: Duration(milliseconds: 150), vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher_fg');
      IOSInitializationSettings initializationSettingsIOS =
          IOSInitializationSettings();
      InitializationSettings initializationSettings =
          new InitializationSettings(
              initializationSettingsAndroid, initializationSettingsIOS);

      Future onNotificationClicked(String payload) async {
        List<String> payloadSplitted = payload.split(":");
        bool executeAlt = true;
        try {
          String _ = payloadSplitted[1];
        } on RangeError {
          executeAlt = false;
        }

        if (executeAlt) {
          appInfo.remindersNotifIdList.remove(payloadSplitted[0]);
          List<int> noteListId = List<int>();
          noteList.forEach((item) {
            noteListId.add(item.id);
          });
          Note note =
              noteList[noteListId.indexOf(int.parse(payloadSplitted[0]))];
          List<String> remindersString = note.reminders.split(":");
          remindersString.remove(payloadSplitted[1]);
          _editNoteCaller(
              context,
              Note(
                  id: int.parse(payloadSplitted[0]),
                  title: note.title,
                  content: note.content,
                  isStarred: note.isStarred,
                  date: note.date,
                  color: note.color,
                  imagePath: note.imagePath,
                  isList: note.isList,
                  listParseString: note.listParseString,
                  reminders: remindersString.join(":")), "");
        } else {
          appInfo.notificationsIdList.remove(payloadSplitted[0]);
        }
      }

      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: onNotificationClicked);

      initializeNotifications();
    });
  }

  void initializeNotifications() async {
    final appInfo = Provider.of<AppInfoProvider>(context);

    for (int i = 0; i < appInfo.notificationsIdList.length; i++) {
      int index = int.parse(appInfo.notificationsIdList[i]);
      await FlutterLocalNotificationsPlugin().show(
          index,
          noteList[index].title != ""
              ? noteList[index].title
              : locales.notesMainPageRoute_pinnedNote,
          noteList[index].content,
          NotificationDetails(
              AndroidNotificationDetails(
                '0',
                'note_pinned_notifications',
                'idk',
                priority: Priority.High,
                playSound: true,
                importance: Importance.High,
                ongoing: true,
              ),
              IOSNotificationDetails()),
          payload: index.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    appInfo = Provider.of<AppInfoProvider>(context);
    locales = AppLocalizations.of(context);

    Widget normalHeader = SliverPersistentHeader(
      pinned: isSelectorVisible,
      floating: !isSelectorVisible,
      delegate: HeaderDelegate(
        child: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).padding.top + 60),
          child: Center(
            child: isSelectorVisible ?
                Card(
                  elevation: 1.5,
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 60,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: appInfo.mainColor,
                          ),
                          onPressed: () async {
                            selectionList.clear();
                            noteList.forEach((item) {
                              item.isSelected = false;
                            });
                            setState(() => isSelectorVisible = false);
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            selectionList.length.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            selectionList.where(
                              (note) => note.isStarred == 0
                            ).toList().length != 0 ?
                              Icons.star :
                              Icons.star_border,
                          ),
                          onPressed: () async {
                            if(selectionList.where((note) => note.isStarred == 0
                                  ).toList().length != 0) {
                              for(int i = 0; i < selectionList.length; i++) {
                                await NoteHelper().update(
                                  noteList.firstWhere((note) => note == selectionList[i])
                                      .copyWith(isStarred: 1),
                                );
                              }

                              List<Note> list = await NoteHelper().getNotes(appInfo.sortMode, currentView);
                              setState(() => noteList = list);
                            } else {
                              for(int i = 0; i < selectionList.length; i++) {
                                await NoteHelper().update(
                                  noteList.firstWhere((note) => note == selectionList[i])
                                      .copyWith(isStarred: 0),
                                );
                              }

                              List<Note> list = await NoteHelper().getNotes(appInfo.sortMode, currentView);
                              setState(() => noteList = list);
                            }

                            noteList.forEach((item) {
                              item.isSelected = false;
                            });

                            setState(() {
                              selectionList.clear();
                              isSelectorVisible = false;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.color_lens,
                          ),
                          onPressed: () async {
                            var result = await showDialog(
                              context: context,
                              builder: (context) {
                                return NoteColorDialog(
                                  noteColor: null,
                                );
                              }
                            );

                            if(result != null) {
                              for(int i = 0; i < selectionList.length; i++) {
                                await NoteHelper().update(
                                  noteList.firstWhere((note) => note == selectionList[i])
                                      .copyWith(color: result),
                                );
                              }

                              List<Note> list = await NoteHelper().getNotes(appInfo.sortMode, currentView);
                              setState(() {
                                noteList = list;
                                selectionList.clear();
                                isSelectorVisible = false;
                              });
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                          ),
                          onPressed: () async {
                            List<Note> noteBackup = List.from(selectionList);

                            for(int i = 0; i < selectionList.length; i++) {
                              await NoteHelper().update(
                                noteList.firstWhere((note) => note == selectionList[i])
                                    .copyWith(isDeleted: 1, isStarred: 0),
                              );
                            }
                                          
                            selectionList.clear();

                            noteList.forEach((item) {
                              item.isSelected = false;
                            });

                            List<Note> list = await NoteHelper().getNotes(appInfo.sortMode, currentView);

                            setState(() {
                              noteList = list;
                              isSelectorVisible = false;
                            });

                            scaffoldKey.currentState.removeCurrentSnackBar();
                            scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(locales.note_delete_snackbar),
                                action: SnackBarAction(
                                  label: locales.undo,
                                  onPressed: () async {
                                    for(int i = 0; i < noteBackup.length; i++) {
                                      await NoteHelper().insert(noteBackup[i]
                                          .copyWith(isDeleted: 0));
                                    }

                                    List<Note> list =
                                        await NoteHelper().getNotes(appInfo.sortMode, currentView);
                                    setState(() => noteList = list);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.archive,
                          ),
                          onPressed: () async {
                            List<Note> noteBackup = List.from(selectionList);

                            for(int i = 0; i < selectionList.length; i++) {
                              await NoteHelper().update(
                                noteList.firstWhere((note) => note == selectionList[i])
                                    .copyWith(isArchived: 1, isStarred: 0),
                              );
                            }
                                          
                            selectionList.clear();

                            noteList.forEach((item) {
                              item.isSelected = false;
                            });

                            List<Note> list = await NoteHelper().getNotes(appInfo.sortMode, currentView);

                            setState(() {
                              noteList = list;
                              isSelectorVisible = false;
                            });

                            scaffoldKey.currentState.removeCurrentSnackBar();
                            scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(locales.note_delete_snackbar),
                                action: SnackBarAction(
                                  label: locales.undo,
                                  onPressed: () async {
                                    for(int i = 0; i < noteBackup.length; i++) {
                                      await NoteHelper().insert(noteBackup[i]
                                          .copyWith(isArchived: 0));
                                    }

                                    List<Note> list =
                                        await NoteHelper().getNotes(appInfo.sortMode, currentView);
                                    setState(() => noteList = list);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        PopupMenuButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: appInfo.mainColor
                          ),
                          onSelected: null,
                          itemBuilder: (context) {
                            return [
                              (selectionList.length == 1 ? PopupMenuItem(
                                enabled: false,
                                child: ListTile(
                                  title: Text(locales.note_share),
                                  onTap: () {
                                    String shareText = "";

                                    if (selectionList[0].title != "")
                                      shareText += selectionList[0].title + "\n\n";
                                    shareText += selectionList[0].content;

                                    Share.share(shareText);
                                    Navigator.pop(context);

                                    noteList.forEach((item) {
                                      item.isSelected = false;
                                    });

                                    setState(() {
                                      selectionList.clear();
                                      isSelectorVisible = false;
                                    });
                                  },
                                ),
                              ) : null),
                              PopupMenuItem(
                                enabled: false,
                                child: ListTile(
                                  title: Text(locales.note_export),
                                  onTap: () async {
                                    Navigator.pop(context);

                                    if (appInfo.storageStatus ==
                                        PermissionStatus.granted) {
                                      DateTime now = DateTime.now();

                                      bool backupDirExists = await Directory(
                                              '/storage/emulated/0/PotatoNotes/exported')
                                          .exists();

                                      if (!backupDirExists) {
                                        await Directory(
                                                '/storage/emulated/0/PotatoNotes/exported')
                                            .create(recursive: true);
                                      }

                                      for(int i = 0; i < selectionList.length; i++) {
                                        Note curNote = noteList.firstWhere((note) => note == selectionList[i]);

                                        String noteExportPath =
                                            '/storage/emulated/0/PotatoNotes/exported/exported_note_' +
                                                DateFormat("dd-MM-yyyy_HH-mm")
                                                    .format(now) +
                                                '_' + curNote.id.toString() + '.md';

                                        String noteContents = "";

                                        if (curNote.title != "")
                                          noteContents +=
                                              "# " + curNote.title + "\n\n";

                                        noteContents += curNote.content;

                                        File(noteExportPath).writeAsString(noteContents);
                                      }

                                      scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content: Text(locales.done),
                                          elevation: 3,
                                        )
                                      );
                                    } else {
                                      await PermissionHandler().requestPermissions(
                                          [PermissionGroup.storage]);
                                      appInfo.storageStatus =
                                          await PermissionHandler()
                                              .checkPermissionStatus(
                                                  PermissionGroup.storage);
                                    }

                                    noteList.forEach((item) {
                                      item.isSelected = false;
                                    });

                                    setState(() {
                                      selectionList.clear();
                                      isSelectorVisible = false;
                                    });
                                  },
                                ),
                              ),
                              (selectionList.length == 1 ? PopupMenuItem(
                                enabled: false,
                                child: ListTile(
                                  title: Text(locales.note_pinToNotifs),
                                  enabled: !appInfo.notificationsIdList
                                      .contains(selectionList[0].id.toString()),
                                  onTap: () async {
                                    appInfo.notificationsIdList
                                        .add(selectionList[0].id.toString());
                                    await FlutterLocalNotificationsPlugin().show(
                                        int.parse(appInfo.notificationsIdList.last),
                                        selectionList[0].title != ""
                                            ? selectionList[0].title
                                            : "Pinned note",
                                        selectionList[0].content,
                                        NotificationDetails(
                                            AndroidNotificationDetails(
                                              '0',
                                              'note_pinned_notifications',
                                              'idk',
                                              priority: Priority.High,
                                              playSound: true,
                                              importance: Importance.High,
                                              ongoing: true,
                                            ),
                                            IOSNotificationDetails()),
                                        payload: selectionList[0].id.toString());
                                    Navigator.pop(context);

                                    noteList.forEach((item) {
                                      item.isSelected = false;
                                    });

                                    setState(() {
                                      selectionList.clear();
                                      isSelectorVisible = false;
                                    });
                                  },
                                ),
                              ) : null),
                            ];
                          },
                        ),
                      ],
                    ),
                  ),
                ) :
                Card(
                  elevation: 1.5,
                  margin: EdgeInsets.fromLTRB(16, 4 + MediaQuery.of(context).padding.top, 16, 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => _searchNoteCaller(context, noteList, Theme.of(context).scaffoldBackgroundColor),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () async {
                              scaffoldKey.currentState.openDrawer();
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Text(
                              locales.searchNotesRoute_searchbar,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).textTheme.title.color
                                    .withAlpha(120)
                              ),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: appInfo.isGridView
                                ? Icon(Icons.view_agenda)
                                : Icon(Icons.grid_on),
                            onPressed: () async {
                              if(controller.status == AnimationStatus.completed) {
                                await controller.animateTo(0);
                                appInfo.isGridView = !appInfo.isGridView;
                                await controller.animateTo(1);
                              }
                            },
                          ),
                          IconButton(
                            iconSize: 24.0,
                            onPressed: () =>
                                Navigator.push(context, PageRouteBuilder(
                                  opaque: false,
                                  transitionDuration: Duration(milliseconds: 200),
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: UserInfoDialog(
                                        onSortSwitchChange: (value) async {
                                          SortMode sortMode;
                                                
                                          if(value) {
                                            sortMode = SortMode.DATE;
                                          } else {
                                            sortMode = SortMode.ID;
                                          }

                                          await controller.animateTo(0);
                                          appInfo.sortMode = sortMode;
                                          List<Note> list = await NoteHelper().getNotes(appInfo.sortMode, currentView);
                                          setState(() => noteList = list);
                                          await controller.animateTo(1);
                                        },
                                        onSettingsTileClick: () => _settingsCaller(context),
                                      ),
                                    );
                                  }
                                )),
                            icon: Hero(
                              createRectTween: (begin, end) {
                                return MaterialRectCenterArcTween(begin: begin, end: end);
                              },
                              tag: "userimage",
                              child: Material(
                                color: Colors.transparent,
                                child: CircleAvatar(
                                  backgroundColor: appInfo.mainColor,
                                  child: appInfo.userImagePath == null
                                      ? Icon(
                                          Icons.account_circle,
                                          color: Colors.white,
                                          size: 28.0,
                                        )
                                      : null,
                                  backgroundImage: appInfo.userImagePath == null
                                      ? null
                                      : FileImage(File(appInfo.userImagePath)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          )
        ),
      ),
    );

    Widget altHeader = SliverPersistentHeader(
      pinned: true,
      delegate: HeaderDelegate(
        child: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).padding.top + 60),
          child: Center(
            child: isSelectorVisible ?
                Card(
                  elevation: 1.5,
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 60,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: appInfo.mainColor,
                          ),
                          onPressed: () async {
                            selectionList.clear();
                            noteList.forEach((item) {
                              item.isSelected = false;
                            });
                            setState(() => isSelectorVisible = false);
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            selectionList.length.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Spacer(),
                        (
                          currentView == NotesReturnMode.ARCHIVED ?
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.star),
                                    onPressed: () async {
                                      for(int i = 0; i < selectionList.length; i++) {
                                        await NoteHelper().update(
                                          noteList.firstWhere((note) => note == selectionList[i])
                                              .copyWith(isArchived: 0, isStarred: 1),
                                        );
                                      }
                                    
                                      List<Note> list = await NoteHelper().getNotes(appInfo.sortMode, currentView);
                                      setState(() => noteList = list);

                                      noteList.forEach((item) {
                                        item.isSelected = false;
                                      });

                                      setState(() {
                                        selectionList.clear();
                                        isSelectorVisible = false;
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.color_lens,
                                    ),
                                    onPressed: () async {
                                      var result = await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return NoteColorDialog(
                                            noteColor: null,
                                          );
                                        }
                                      );

                                      if(result != null) {
                                        for(int i = 0; i < selectionList.length; i++) {
                                          await NoteHelper().update(
                                            noteList.firstWhere((note) => note == selectionList[i])
                                                .copyWith(color: result),
                                          );
                                        }

                                        List<Note> list = await NoteHelper().getNotes(appInfo.sortMode, currentView);
                                        setState(() {
                                          noteList = list;
                                          selectionList.clear();
                                          isSelectorVisible = false;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ) : Container()
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                          ),
                          onPressed: () async {
                            if(currentView == NotesReturnMode.ARCHIVED) {
                              List<Note> noteBackup = List.from(selectionList);

                              for(int i = 0; i < selectionList.length; i++) {
                                await NoteHelper().update(
                                  noteList.firstWhere((note) => note == selectionList[i])
                                      .copyWith(isDeleted: 1, isStarred: 0),
                                );
                              }
                                            
                              selectionList.clear();

                              noteList.forEach((item) {
                                item.isSelected = false;
                              });

                              List<Note> list = await NoteHelper().getNotes(appInfo.sortMode, currentView);

                              setState(() {
                                noteList = list;
                                isSelectorVisible = false;
                              });

                              scaffoldKey.currentState.removeCurrentSnackBar();
                              scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text(locales.note_delete_snackbar),
                                  action: SnackBarAction(
                                    label: locales.undo,
                                    onPressed: () async {
                                      for(int i = 0; i < noteBackup.length; i++) {
                                        await NoteHelper().insert(noteBackup[i]
                                            .copyWith(isDeleted: 0));
                                      }

                                      List<Note> list =
                                          await NoteHelper().getNotes(appInfo.sortMode, currentView);
                                      setState(() => noteList = list);
                                    },
                                  ),
                                ),
                              );
                            } else if(currentView == NotesReturnMode.DELETED) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)
                                    ),
                                    title: Text("Delete selected notes?"),
                                    content: Text("Once the notes are deleted from here you can't restore them.\nAre you sure you want to continue?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(locales.cancel),
                                        onPressed: () => Navigator.pop(context),
                                        textColor: appInfo.mainColor,
                                      ),
                                      FlatButton(
                                        child: Text(locales.confirm),
                                        color: appInfo.mainColor,
                                        textColor: Theme.of(context).scaffoldBackgroundColor,
                                        onPressed: () async {
                                          Navigator.pop(context);

                                          for(int i = 0; i < selectionList.length; i++) {
                                            await NoteHelper().delete(selectionList[i].id);
                                          }

                                          List<Note> list =
                                              await NoteHelper().getNotes(appInfo.sortMode, NotesReturnMode.DELETED);
                                          setState(() => noteList = list);

                                          noteList.forEach((item) {
                                            item.isSelected = false;
                                          });

                                          setState(() {
                                            selectionList.clear();
                                            isSelectorVisible = false;
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                }
                              );
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.settings_backup_restore,
                          ),
                          onPressed: () async {
                            if(currentView == NotesReturnMode.ARCHIVED) {
                              List<Note> noteBackup = List.from(selectionList);

                              for(int i = 0; i < selectionList.length; i++) {
                                await NoteHelper().update(
                                  noteList.firstWhere((note) => note == selectionList[i])
                                      .copyWith(isArchived: 0),
                                );
                              }
                                          
                              selectionList.clear();

                              noteList.forEach((item) {
                                item.isSelected = false;
                              });

                              List<Note> list = await NoteHelper().getNotes(appInfo.sortMode, currentView);

                              setState(() {
                                noteList = list;
                                isSelectorVisible = false;
                              });

                              scaffoldKey.currentState.removeCurrentSnackBar();
                              scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text("Notes removed from archived"),
                                  action: SnackBarAction(
                                    label: locales.undo,
                                    onPressed: () async {
                                      for(int i = 0; i < noteBackup.length; i++) {
                                        await NoteHelper().insert(noteBackup[i]
                                            .copyWith(isArchived: 1));
                                      }

                                      List<Note> list =
                                          await NoteHelper().getNotes(appInfo.sortMode, currentView);
                                      setState(() => noteList = list);
                                    },
                                  ),
                                ),
                              );
                            } else if(currentView == NotesReturnMode.DELETED) {
                              List<Note> noteBackup = List.from(selectionList);

                              for(int i = 0; i < selectionList.length; i++) {
                                await NoteHelper().update(
                                  noteList.firstWhere((note) => note == selectionList[i])
                                      .copyWith(isDeleted: 0),
                                );
                              }
                                          
                              selectionList.clear();

                              noteList.forEach((item) {
                                item.isSelected = false;
                              });

                              List<Note> list = await NoteHelper().getNotes(appInfo.sortMode, currentView);

                              setState(() {
                                noteList = list;
                                isSelectorVisible = false;
                              });

                              scaffoldKey.currentState.removeCurrentSnackBar();
                              scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text("Notes restored"),
                                  action: SnackBarAction(
                                    label: locales.undo,
                                    onPressed: () async {
                                      for(int i = 0; i < noteBackup.length; i++) {
                                        await NoteHelper().insert(noteBackup[i]
                                            .copyWith(isDeleted: 1));
                                      }

                                      List<Note> list =
                                          await NoteHelper().getNotes(appInfo.sortMode, currentView);
                                      setState(() => noteList = list);
                                    },
                                  ),
                                ),
                              );
                            }
                          }
                        ),
                        (
                          currentView == NotesReturnMode.ARCHIVED ?
                              PopupMenuButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: appInfo.mainColor
                                ),
                                onSelected: null,
                                itemBuilder: (context) {
                                  return [
                                    (selectionList.length == 1 ? PopupMenuItem(
                                      enabled: false,
                                      child: ListTile(
                                        title: Text(locales.note_share),
                                        onTap: () {
                                          String shareText = "";

                                          if (selectionList[0].title != "")
                                            shareText += selectionList[0].title + "\n\n";
                                          shareText += selectionList[0].content;

                                          Share.share(shareText);
                                          Navigator.pop(context);

                                          noteList.forEach((item) {
                                            item.isSelected = false;
                                          });

                                          setState(() {
                                            selectionList.clear();
                                            isSelectorVisible = false;
                                          });
                                        },
                                      ),
                                    ) : null),
                                    PopupMenuItem(
                                      enabled: false,
                                      child: ListTile(
                                        title: Text(locales.note_export),
                                        onTap: () async {
                                          Navigator.pop(context);

                                          if (appInfo.storageStatus ==
                                              PermissionStatus.granted) {
                                            DateTime now = DateTime.now();

                                            bool backupDirExists = await Directory(
                                                    '/storage/emulated/0/PotatoNotes/exported')
                                                .exists();

                                            if (!backupDirExists) {
                                              await Directory(
                                                      '/storage/emulated/0/PotatoNotes/exported')
                                                  .create(recursive: true);
                                            }

                                            for(int i = 0; i < selectionList.length; i++) {
                                              Note curNote = noteList.firstWhere((note) => note == selectionList[i]);

                                              String noteExportPath =
                                                  '/storage/emulated/0/PotatoNotes/exported/exported_note_' +
                                                      DateFormat("dd-MM-yyyy_HH-mm")
                                                          .format(now) +
                                                      '_' + curNote.id.toString() + '.md';

                                              String noteContents = "";

                                              if (curNote.title != "")
                                                noteContents +=
                                                    "# " + curNote.title + "\n\n";

                                              noteContents += curNote.content;

                                              File(noteExportPath).writeAsString(noteContents);
                                            }

                                            scaffoldKey.currentState.showSnackBar(
                                              SnackBar(
                                                content: Text(locales.done),
                                                elevation: 3,
                                              )
                                            );
                                          } else {
                                            await PermissionHandler().requestPermissions(
                                                [PermissionGroup.storage]);
                                            appInfo.storageStatus =
                                                await PermissionHandler()
                                                    .checkPermissionStatus(
                                                        PermissionGroup.storage);
                                          }

                                          noteList.forEach((item) {
                                            item.isSelected = false;
                                          });

                                          setState(() {
                                            selectionList.clear();
                                            isSelectorVisible = false;
                                          });
                                        },
                                      ),
                                    ),
                                    (selectionList.length == 1 ? PopupMenuItem(
                                      enabled: false,
                                      child: ListTile(
                                        title: Text(locales.note_pinToNotifs),
                                        enabled: !appInfo.notificationsIdList
                                            .contains(selectionList[0].id.toString()),
                                        onTap: () async {
                                          appInfo.notificationsIdList
                                              .add(selectionList[0].id.toString());
                                          await FlutterLocalNotificationsPlugin().show(
                                              int.parse(appInfo.notificationsIdList.last),
                                              selectionList[0].title != ""
                                                  ? selectionList[0].title
                                                  : "Pinned note",
                                              selectionList[0].content,
                                              NotificationDetails(
                                                  AndroidNotificationDetails(
                                                    '0',
                                                    'note_pinned_notifications',
                                                    'idk',
                                                    priority: Priority.High,
                                                    playSound: true,
                                                    importance: Importance.High,
                                                    ongoing: true,
                                                  ),
                                                  IOSNotificationDetails()),
                                              payload: selectionList[0].id.toString());
                                          Navigator.pop(context);

                                          noteList.forEach((item) {
                                            item.isSelected = false;
                                          });

                                          setState(() {
                                            selectionList.clear();
                                            isSelectorVisible = false;
                                          });
                                        },
                                      ),
                                    ) : null),
                                  ];
                                },
                              ) : Container()
                        ),
                      ],
                    ),
                  ),
                ) :
                Card(
                  elevation: 1.5,
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 60,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () async {
                            scaffoldKey.currentState.openDrawer();
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Text(
                            currentView == NotesReturnMode.DELETED ?
                                "Trash" :
                                "Archive",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).textTheme.title.color
                                  .withAlpha(220)
                            ),
                          ),
                        ),
                        Spacer(),
                        (
                          currentView == NotesReturnMode.DELETED ?
                              PopupMenuButton(
                                onSelected: (value) {
                                  if(value == 0) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12)
                                          ),
                                          title: Text("Empty trash?"),
                                          content: Text("Once the notes are deleted from here you can't restore them.\nAre you sure you want to continue?"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text(locales.cancel),
                                              onPressed: () => Navigator.pop(context),
                                              textColor: appInfo.mainColor,
                                            ),
                                            FlatButton(
                                              child: Text(locales.confirm),
                                              color: appInfo.mainColor,
                                              textColor: Theme.of(context).scaffoldBackgroundColor,
                                              onPressed: () async {
                                                Navigator.pop(context);

                                                for(int i = 0; i < noteList.length; i++) {
                                                  await NoteHelper().delete(noteList[i].id);
                                                }

                                                List<Note> list =
                                                    await NoteHelper().getNotes(appInfo.sortMode, NotesReturnMode.DELETED);
                                                setState(() => noteList = list);
                                              },
                                            ),
                                          ],
                                        );
                                      }
                                    );
                                  }
                                },
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      enabled: noteList.length != 0,
                                      value: 0,
                                      child: Text("Empty trash"),
                                    ),
                                  ];
                                },
                              ) :
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: appInfo.isGridView
                                        ? Icon(Icons.view_agenda)
                                        : Icon(Icons.grid_on),
                                    onPressed: () async {
                                      if(controller.status == AnimationStatus.completed) {
                                        await controller.animateTo(0);
                                        appInfo.isGridView = !appInfo.isGridView;
                                        await controller.animateTo(1);
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.search),
                                    onPressed: () async {
                                      _searchNoteCaller(
                                        context,
                                        await NoteHelper().getNotes(appInfo.sortMode, NotesReturnMode.NORMAL),
                                        Theme.of(context).cardColor
                                      );
                                    }
                                  ),
                                ],
                              )
                        )
                      ],
                    ),
                  ),
                ),
          )
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      key: scaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          (currentView == NotesReturnMode.NORMAL ? normalHeader : altHeader),
          noteList.length != 0 ? SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: AnimatedBuilder(
                    animation: Tween<double>(begin: 0, end: 1).animate(controller),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      child: Column(
                        //physics: NeverScrollableScrollPhysics(),
                        children: noteListBuilder(context),
                      ),
                    ),
                    builder: (context, child) {
                      return Opacity(
                        opacity: controller.value,
                        child: child,
                      );
                    },
                  ),
                ),
              ]
            )
          ) : SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    currentView == NotesReturnMode.DELETED ?
                        Icons.delete_outline :
                        currentView == NotesReturnMode.ARCHIVED ?
                            Icons.archive :
                            Icons.note,
                    size: 50.0,
                    color: HSLColor.fromColor(
                        Theme.of(context).textTheme.title.color)
                        .withAlpha(0.4)
                        .toColor()),
                  Text(
                    currentView == NotesReturnMode.DELETED ?
                    "Your trash is empty" :
                    currentView == NotesReturnMode.ARCHIVED ?
                        "You don't have any notes in the archive" :
                        locales.notesMainPageRoute_noNotes,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: HSLColor.fromColor(
                              Theme.of(context).textTheme.title.color)
                          .withAlpha(0.4)
                          .toColor(),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: currentView == NotesReturnMode.NORMAL ? bottomBar : null,
      drawer: drawer,
    );
  }

  Widget get bottomBar {
    return Material(
      elevation: 140,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: () {
          _addNoteCaller(context);
          selectionList.clear();
          noteList.forEach((item) {
            item.isSelected = false;
          });
          setState(() => isSelectorVisible = false);
        },
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              Text(
                "Write a note...",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.title.color
                      .withAlpha(120)
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.check_box),
                onPressed: () {
                  _addNoteCaller(context, startAsList: true);
                  selectionList.clear();
                  noteList.forEach((item) {
                    item.isSelected = false;
                  });
                  setState(() => isSelectorVisible = false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get drawer {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Theme.of(context).scaffoldBackgroundColor
      ),
      child: Drawer(
        child: SafeArea(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                height: 80,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Image(
                        image: AssetImage('assets/notes_orange.png'),
                        width: 36,
                        height: 36,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      "PotatoNotes",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: currentView == NotesReturnMode.NORMAL ? appInfo.mainColor.withAlpha(80) : null,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )
                ),
                margin: EdgeInsets.fromLTRB(0, 5, 15, 5),
                child: ListTile(
                  leading: Icon(Icons.note),
                  title: Text(locales.notes),
                  selected: currentView == NotesReturnMode.NORMAL,
                  onTap: () async {
                    if(currentView != NotesReturnMode.NORMAL) {
                      currentView = NotesReturnMode.NORMAL;
                      List<Note> list = await NoteHelper().getNotes(appInfo.sortMode, currentView);
                      setState(() => noteList = list);
                      Navigator.pop(context);

                      noteList.forEach((item) {
                        item.isSelected = false;
                      });

                      setState(() {
                        selectionList.clear();
                        isSelectorVisible = false;
                      });

                      Brightness systemBarsIconBrightness =
                          Theme.of(context).brightness == Brightness.dark
                              ? Brightness.light
                              : Brightness.dark;

                      changeSystemBarsColors(Theme.of(context).scaffoldBackgroundColor, systemBarsIconBrightness);
                    }
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: currentView == NotesReturnMode.DELETED ? appInfo.mainColor.withAlpha(80) : null,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )
                ),
                margin: EdgeInsets.fromLTRB(0, 5, 15, 5),
                child: ListTile(
                  leading: Icon(Icons.delete_outline),
                  title: Text("Trash"),
                  selected: currentView == NotesReturnMode.DELETED,
                  onTap: () async {
                    if(currentView != NotesReturnMode.DELETED) {
                      currentView = NotesReturnMode.DELETED;
                      List<Note> list = await NoteHelper().getNotes(appInfo.sortMode, currentView);
                      setState(() => noteList = list);
                      Navigator.pop(context);

                      noteList.forEach((item) {
                        item.isSelected = false;
                      });

                      setState(() {
                        selectionList.clear();
                        isSelectorVisible = false;
                      });

                      Brightness systemBarsIconBrightness =
                          Theme.of(context).brightness == Brightness.dark
                              ? Brightness.light
                              : Brightness.dark;

                      changeSystemBarsColors(Theme.of(context).cardColor, systemBarsIconBrightness);
                    }
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: currentView == NotesReturnMode.ARCHIVED ? appInfo.mainColor.withAlpha(80) : null,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )
                ),
                margin: EdgeInsets.fromLTRB(0, 5, 15, 5),
                child: ListTile(
                  leading: Icon(Icons.archive),
                  title: Text("Archive"),
                  selected: currentView == NotesReturnMode.ARCHIVED,
                  onTap: () async {
                    if(currentView != NotesReturnMode.ARCHIVED) {
                      currentView = NotesReturnMode.ARCHIVED;
                      List<Note> list = await NoteHelper().getNotes(appInfo.sortMode, currentView);
                      setState(() => noteList = list);
                      Navigator.pop(context);

                      noteList.forEach((item) {
                        item.isSelected = false;
                      });

                      setState(() {
                        selectionList.clear();
                        isSelectorVisible = false;
                      });

                      Brightness systemBarsIconBrightness =
                          Theme.of(context).brightness == Brightness.dark
                              ? Brightness.light
                              : Brightness.dark;

                      changeSystemBarsColors(Theme.of(context).cardColor, systemBarsIconBrightness);
                    }
                  },
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  List<Widget> noteListBuilder(BuildContext context) {
    final appInfo = Provider.of<AppInfoProvider>(context);

    if (!appInfo.isGridView) {
      List<Widget> pinnedNotes = List<Widget>();
      List<Widget> normalNotes = List<Widget>();

      pinnedNotes.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          child: Text(
            locales.notesMainPageRoute_starred,
            style: TextStyle(
              fontSize: 14.0,
              color: HSLColor.fromColor(
                  Theme.of(context).textTheme.title.color)
                  .withAlpha(0.4)
                  .toColor()
            ),
          ),
        )
      );

      for (int i = 0; i < noteList.length; i++) {
        int bIndex = (noteList.length - 1) - i;
        if (noteList[bIndex].isStarred == 1) {
          pinnedNotes.add(noteListItem(context, bIndex, false));
        }
      }

      for (int i = 0; i < noteList.length; i++) {
        int bIndex = (noteList.length - 1) - i;
        if (noteList[bIndex].isStarred == 0) {
          normalNotes.add(noteListItem(context, bIndex, false));
        }
      }

      pinnedNotes.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          child: Text(
            "Other notes",
            style: TextStyle(
              fontSize: 14.0,
              color: HSLColor.fromColor(
                  Theme.of(context).textTheme.title.color)
                  .withAlpha(0.4)
                  .toColor()
            ),
          ),
        )
      );

      return <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            pinnedNotes.length > 2
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: pinnedNotes,
                  )
                : Container(),
            normalNotes.length > 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: normalNotes,
                  )
                : Container(),
          ],
        ),
      ];
    } else {
      List<int> pinnedIndexes = List<int>();
      List<int> normalIndexes = List<int>();
      List<Widget> pinnedWidgets = List<Widget>();
      List<Widget> normalWidgets = List<Widget>();

      pinnedWidgets.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          child: Text(
            locales.notesMainPageRoute_starred,
            style: TextStyle(
              fontSize: 14.0,
              color: HSLColor.fromColor(
                  Theme.of(context).textTheme.title.color)
                  .withAlpha(0.4)
                  .toColor()
            ),
          ),
        )
      );

      for (int i = 0; i < noteList.length; i++) {
        if (noteList[i].isStarred == 1) {
          pinnedIndexes.add(i);
        }
      }

      for (int i = 0; i < noteList.length; i++) {
        if (noteList[i].isStarred == 0) {
          normalIndexes.add(i);
        }
      }

      Widget pinnedGrid = noteGridBuilder(context, pinnedIndexes);
      Widget normalGrid = noteGridBuilder(context, normalIndexes);

      if (pinnedGrid != null) pinnedWidgets.add(pinnedGrid);

      if (normalGrid != null) normalWidgets.add(normalGrid);

      pinnedWidgets.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          child: Text(
            "Other notes",
            style: TextStyle(
              fontSize: 14.0,
              color: HSLColor.fromColor(
                  Theme.of(context).textTheme.title.color)
                  .withAlpha(0.4)
                  .toColor()
            ),
          ),
        )
      );

      return <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            pinnedWidgets.length > 2
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: pinnedWidgets,
                  )
                : Container(),
            normalWidgets.length > 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: normalWidgets,
                  )
                : Container(),
          ],
        ),
      ];
    }
  }

  Widget noteGridBuilder(BuildContext context, List<int> indexes) {
    List<Widget> columnOne = List<Widget>();
    List<Widget> columnTwo = List<Widget>();

    bool secondColumnFirst = false;

    if ((indexes.length - 1).isEven) {
      secondColumnFirst = false;
    } else {
      secondColumnFirst = true;
    }

    for (int i = 0; i < indexes.length; i++) {
      int bIndex = (indexes.length - 1) - i;
      if (bIndex.isEven) {
        columnOne.add(noteListItem(context, indexes[bIndex], true));
      } else {
        columnTwo.add(noteListItem(context, indexes[bIndex], true));
      }
    }

    if (indexes.length > 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 2 - 4,
            child: Column(
              children: secondColumnFirst ? columnTwo : columnOne,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2 - 4,
            child: Column(
              children: secondColumnFirst ? columnOne : columnTwo,
            ),
          ),
        ],
      );
    } else
      return null;
  }

  void _addNoteCaller(BuildContext context, {bool startAsList = false}) async {
    final Note emptyNote = Note(
      id: null,
      title: "",
      content: "",
      isStarred: 0,
      date: 0,
      color: null,
      imagePath: null,
      isList: startAsList ? 1 : 0,
      listParseString: null,
      reminders: null,
      hideContent: 0,
      pin: null,
      password: null,
    );

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ModifyNotesRoute(
          note: emptyNote, heroIndex: "", autofocus: true,
        ),
      )
    );

    if (result != null) setState(() => noteList = result);

    Brightness systemBarsIconBrightness =
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark;

    changeSystemBarsColors(
        Theme.of(context).scaffoldBackgroundColor, systemBarsIconBrightness);
  }

  void _editNoteCaller(BuildContext context, Note note, String heroIndex) async {
    if (note.hideContent == 1 && (note.pin != null || note.password != null)) {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SecurityNoteRoute(note: note, heroIndex: heroIndex.toString())));
    } else {
      await Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 200),
          pageBuilder: (_, __, ___) => ModifyNotesRoute(note: note, heroIndex: heroIndex.toString()),
        )
      );
    }

    Brightness systemBarsIconBrightness =
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark;

    changeSystemBarsColors(
        Theme.of(context).scaffoldBackgroundColor, systemBarsIconBrightness);

    List<Note> list = await NoteHelper().getNotes(appInfo.sortMode, currentView);

    setState(() => noteList = list);
  }

  void _searchNoteCaller(BuildContext context, List<Note> noteList, Color returnBarsColor) async {
    SearchFiltersProvider searchFilters =
        Provider.of<SearchFiltersProvider>(context);

    searchFilters.color = null;
    searchFilters.date = null;
    searchFilters.caseSensitive = false;

    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchNotesRoute(noteList: noteList)));

    if (result != null) setState(() => noteList = result);

    Brightness systemBarsIconBrightness =
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark;

    changeSystemBarsColors(
        returnBarsColor, systemBarsIconBrightness);
  }

  void _settingsCaller(BuildContext context) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsRoute()));

    List<Note> list = await NoteHelper().getNotes(appInfo.sortMode, currentView);
    setState(() => noteList = list);

    Brightness systemBarsIconBrightness =
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark;

    changeSystemBarsColors(
        Theme.of(context).scaffoldBackgroundColor, systemBarsIconBrightness);
  }

  Widget noteListItem(BuildContext context, int index, bool oneSideOnly) {
    final appInfo = Provider.of<AppInfoProvider>(context);

    double getAlphaFromTheme() {
      if (Theme.of(context).brightness == Brightness.light) {
        return 0.1;
      } else {
        return 0.2;
      }
    }

    Color cardColor = Theme.of(context).textTheme.title.color;

    double cardBrightness = getAlphaFromTheme();

    Color borderColor =
        HSLColor.fromColor(cardColor).withAlpha(cardBrightness).toColor();

    Color getTextColorFromNoteColor(int index, bool isContent) {
      double noteColorBrightness =
          Color(noteList[index].color).computeLuminance();
      Color contentWhite =
          HSLColor.fromColor(Colors.white).withAlpha(0.7).toColor();
      Color contentBlack =
          HSLColor.fromColor(Colors.black).withAlpha(0.7).toColor();

      if (noteColorBrightness > 0.5) {
        return isContent ? contentBlack : Colors.black;
      } else {
        return isContent ? contentWhite : Colors.white;
      }
    }

    Color getBorderColor() {
      if(noteList[index].isSelected) {
        if(noteList[index].color != null) {
          return Theme.of(context).textTheme.title.color;
        } else {
          return Theme.of(context).accentColor;
        }
      } else if(noteList[index].color != null) {
        return Colors.transparent;
      } else {
        if(Theme.of(context).brightness == Brightness.light) {
          return borderColor;
        } else {
          if(appInfo.followSystemTheme) {
            if(MediaQuery.of(context).platformBrightness == Brightness.dark) {
              return Colors.transparent;
            } else {
              return borderColor;
            }
          } else {
            if(appInfo.themeMode != 0) {
              return Colors.transparent;
            } else {
              return borderColor;
            }
          }
        }
      }
    }

    return Hero(
      createRectTween: (Rect begin, Rect end) {
        return MaterialRectArcTween(begin: begin, end: end);
      },
      tag: "note" + index.toString(),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            color: getBorderColor(),
            width: 2
          ),
        ),
        color: noteList[index].color == null
            ? (Theme.of(context).brightness == Brightness.light ? null : Theme.of(context).scaffoldBackgroundColor)
            : Color(noteList[index].color),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () {
            if (isSelectorVisible) {
              setState(() {
                noteList[index].isSelected = !noteList[index].isSelected;
                if (noteList[index].isSelected) {
                  selectionList.add(noteList[index]);
                } else {
                  selectionList.remove(noteList[index]);
                  if (selectionList.length == 0) {
                    isSelectorVisible = false;
                  }
                }
              });
            } else {
              _editNoteCaller(context, noteList[index], index.toString());
            }
          },
          onDoubleTap: isSelectorVisible
              ? null
              : appInfo.isQuickStarredGestureOn
                  ? () => toggleStarNote(index)
                  : null,
          onLongPress: () {
            if (!isSelectorVisible)
              setState(() {
                isSelectorVisible = true;
                noteList[index].isSelected = true;
                selectionList.add(noteList[index]);
              });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Visibility(
                visible: noteList[index].imagePath != null,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  child: noteList[index].imagePath == null
                      ? Container()
                      : Image(
                          image: FileImage(File(noteList[index].imagePath)),
                          fit: BoxFit.fitWidth,
                          width: oneSideOnly
                              ? MediaQuery.of(context).size.width / 2
                              : MediaQuery.of(context).size.width,
                        ),
                ),
              ),
              Visibility(
                visible: noteList[index].hideContent == 1 ||
                    noteList[index].reminders != null,
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      20,
                      14,
                      20,
                      noteList[index].hideContent == 1 &&
                              noteList[index].title == ""
                          ? 14
                          : 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Visibility(
                        visible: noteList[index].reminders != null,
                        child: Center(
                          child: Icon(
                            Icons.alarm,
                            size: 12,
                            color: noteList[index].color == null
                                ? Theme.of(context).textTheme.title.color
                                    .withAlpha(140)
                                : getTextColorFromNoteColor(index, false),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: noteList[index].hideContent == 1,
                        child: Center(
                          child: Icon(
                            noteList[index].pin != null ||
                                    noteList[index].password != null
                                ? Icons.lock
                                : Icons.remove_red_eye,
                            size: 12,
                            color: noteList[index].color == null
                                ? Theme.of(context).textTheme.title.color
                                    .withAlpha(140)
                                : getTextColorFromNoteColor(index, false),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: (noteList[index].hideContent == 1 &&
                                noteList[index].reminders == null) ||
                            (noteList[index].hideContent == 0 &&
                                noteList[index].reminders != null),
                        child: Container(
                          padding: EdgeInsets.only(left: 8),
                          width: oneSideOnly
                              ? MediaQuery.of(context).size.width / 2 - 80
                              : MediaQuery.of(context).size.width - 100,
                          child: (noteList[index].hideContent == 1 &&
                                  noteList[index].reminders == null)
                              ? Text(
                                  locales
                                      .notesMainPageRoute_note_hiddenContent,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: noteList[index].color == null
                                        ? Theme.of(context).textTheme.title.color
                                            .withAlpha(140)
                                        : getTextColorFromNoteColor(
                                            index, false),
                                  ),
                                )
                              : (noteList[index].hideContent == 0 &&
                                      noteList[index].reminders != null)
                                  ? Text(
                                      locales
                                          .notesMainPageRoute_note_remindersSet,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: noteList[index].color == null
                                            ? Theme.of(context).textTheme.title.color
                                                .withAlpha(140)
                                            : getTextColorFromNoteColor(
                                                index, false),
                                      ),
                                    )
                                  : Container(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: appInfo.devShowIdLabels,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
                  child: Text(
                    "Note id: " + noteList[index].id.toString(),
                    style: TextStyle(
                      color: noteList[index].color == null
                          ? null
                          : getTextColorFromNoteColor(index, false),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: noteList[index].title != "",
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 14, 20, 0),
                  width: oneSideOnly
                      ? MediaQuery.of(context).size.width / 2
                      : MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      noteList[index].title ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: TextStyle(
                        color: noteList[index].color == null
                            ? Theme.of(context).textTheme.title.color
                                .withAlpha(220)
                            : getTextColorFromNoteColor(index, false),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: noteList[index].hideContent == 0,
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      20, noteList[index].title == "" ? 14 : 0, 20, 14),
                  width: oneSideOnly
                      ? MediaQuery.of(context).size.width / 2
                      : MediaQuery.of(context).size.width,
                  child: noteList[index].isList == 1
                      ? Column(
                          children: generateListWidgets(index, oneSideOnly),
                        )
                      : Text(
                          noteList[index].content ?? "",
                          overflow: TextOverflow.ellipsis,
                          textWidthBasis: TextWidthBasis.parent,
                          maxLines: 11,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: noteList[index].color == null
                                ? Theme.of(context).textTheme.title.color
                                    .withAlpha(180)
                                : getTextColorFromNoteColor(index, true),
                          ),
                        ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  List<Widget> generateListWidgets(int index, bool oneSideOnly) {
    List<Widget> widgets = List<Widget>();
    List<ListPair> checkedList = List<ListPair>();
    List<ListPair> uncheckedList = List<ListPair>();

    Color getTextColorFromNoteColor(int index, bool isContent) {
      double noteColorBrightness =
          Color(noteList[index].color).computeLuminance();
      Color contentWhite =
          HSLColor.fromColor(Colors.white).withAlpha(0.7).toColor();
      Color contentBlack =
          HSLColor.fromColor(Colors.black).withAlpha(0.7).toColor();

      if (noteColorBrightness > 0.5) {
        return isContent ? contentBlack : Colors.black;
      } else {
        return isContent ? contentWhite : Colors.white;
      }
    }

    List<String> rawList = noteList[index].listParseString.split("\'..\'");

    for (int i = 0; i < rawList.length; i++) {
      List<dynamic> rawStrings = rawList[i].split("\',,\'");

      int checkValue = rawStrings[0] == "" ? 0 : int.parse(rawStrings[0]);

      if (checkValue == 1) {
        try {
          checkedList
              .add(ListPair(checkValue: checkValue, title: rawStrings[1]));
        } on RangeError {}
      } else {
        try {
          uncheckedList
              .add(ListPair(checkValue: checkValue, title: rawStrings[1]));
        } on RangeError {}
      }
    }

    for (int i = 0; i < uncheckedList.length; i++) {
      widgets.add(Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(Icons.check_box_outline_blank,
              size: 14,
              color: noteList[index].color == null
                  ? Theme.of(context).iconTheme.color
                  : getTextColorFromNoteColor(index, true)),
          Container(
            padding: EdgeInsets.only(left: 6, top: 4, bottom: 4),
            width: oneSideOnly
                ? MediaQuery.of(context).size.width / 2 - 88
                : MediaQuery.of(context).size.width - 108,
            child: Text(
              uncheckedList[i].title,
              overflow: TextOverflow.ellipsis,
              textWidthBasis: TextWidthBasis.parent,
              style: TextStyle(
                  color: noteList[index].color == null
                      ? Theme.of(context).textTheme.title.color
                      : getTextColorFromNoteColor(index, true)),
            ),
          )
        ],
      ));
    }

    if (checkedList.length != 0) {
      widgets.add(Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(Icons.add,
              size: 14,
              color: noteList[index].color == null
                  ? Theme.of(context).iconTheme.color
                  : getTextColorFromNoteColor(index, true)),
          Container(
            width: oneSideOnly
                ? MediaQuery.of(context).size.width / 2 - 88
                : MediaQuery.of(context).size.width - 108,
            padding: EdgeInsets.only(left: 6, top: 4, bottom: 4),
            child: Text(
              checkedList.length.toString() +
                  locales.notesMainPageRoute_note_list_selectedEntries,
              style: TextStyle(
                  color: noteList[index].color == null
                      ? Theme.of(context).textTheme.title.color
                      : getTextColorFromNoteColor(index, true)),
            ),
          )
        ],
      ));
    }

    return widgets;
  }
  
  void toggleStarNote(int index) async {
    if (noteList[index].isStarred == 0) {
      await NoteHelper().update(
        noteList[index].copyWith(isStarred: 1),
      );
      List<Note> list = await NoteHelper().getNotes(appInfo.sortMode, currentView);
      setState(() => noteList = list);
    } else if (noteList[index].isStarred == 1) {
      await NoteHelper().update(
        noteList[index].copyWith(isStarred: 0),
      );
      List<Note> list = await NoteHelper().getNotes(appInfo.sortMode, currentView);
      setState(() => noteList = list);
    }
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  HeaderDelegate({this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapOffset) {
    return child;
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}