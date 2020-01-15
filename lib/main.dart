import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path/path.dart';
import 'package:potato_notes/internal/app_info.dart';
import 'package:potato_notes/internal/localizations.dart';
import 'package:potato_notes/internal/note_helper.dart';
import 'package:potato_notes/internal/search_filters.dart';
import 'package:potato_notes/routes/notes_main_page_route.dart';
import 'package:potato_notes/routes/welcome_route.dart';
import 'package:potato_notes/ui/no_glow_scroll_behavior.dart';
import 'package:potato_notes/ui/themes.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'internal/methods.dart';

Future<Database> database;
AppInfoProvider appInfo;
SearchFiltersProvider searchFilters;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = openDatabase(
    join(await getDatabasesPath(), 'notes_database.db'),
    onCreate: (db, version) {
      return db.execute(
        """
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY,
            title TEXT,
            content TEXT,
            isStarred INTEGER,
            date INTEGER,
            color INTEGER,
            imagePath TEXT,
            isList INTEGER,
            listParseString TEXT,
            reminders TEXT,
            hideContent INTEGER,
            pin TEXT,
            password TEXT,
            isDeleted INTEGER,
            isArchived INTEGER
          )
        """,
      );
    },
    onOpen: (db) async {
      List<String> columnsToAdd = [
        "ALTER TABLE notes ADD COLUMN id INTEGER PRIMARY KEY",
        "ALTER TABLE notes ADD COLUMN title TEXT",
        "ALTER TABLE notes ADD COLUMN content TEXT",
        "ALTER TABLE notes ADD COLUMN isStarred INTEGER",
        "ALTER TABLE notes ADD COLUMN date INTEGER",
        "ALTER TABLE notes ADD COLUMN color INTEGER",
        "ALTER TABLE notes ADD COLUMN imagePath TEXT",
        "ALTER TABLE notes ADD COLUMN isList INTEGER",
        "ALTER TABLE notes ADD COLUMN listParseString TEXT",
        "ALTER TABLE notes ADD COLUMN reminders TEXT",
        "ALTER TABLE notes ADD COLUMN hideContent INTEGER",
        "ALTER TABLE notes ADD COLUMN pin TEXT",
        "ALTER TABLE notes ADD COLUMN password TEXT",
        "ALTER TABLE notes ADD COLUMN isDeleted INTEGER",
        "ALTER TABLE notes ADD COLUMN isArchived INTEGER",
      ];

      for (int i = 0; i < columnsToAdd.length; i++) {
        try {
          await db.execute(columnsToAdd[i]);
        } on DatabaseException {
          //do nothing
        }
      }
    },
    version: 5,
  );

  Preferences preferences = await Preferences().create();
  List<Note> noteList = await NoteHelper.getNotes(
      preferences.getSortMode(), NotesReturnMode.NORMAL);
  bool showWelcomeScreen = !preferences.getWelcomeScreenSeen();

  runApp(NotesRoot(noteList: noteList, showWelcomeScreen: showWelcomeScreen));
}

class NotesRoot extends StatelessWidget {
  final List<Note> noteList;
  final bool showWelcomeScreen;

  NotesRoot({@required this.noteList, this.showWelcomeScreen});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppInfoProvider>.value(
          value: AppInfoProvider(),
        ),
        ChangeNotifierProvider<SearchFiltersProvider>.value(
          value: SearchFiltersProvider(),
        ),
      ],
      child: Builder(builder: (context) {
        appInfo = Provider.of<AppInfoProvider>(context);
        searchFilters = Provider.of<SearchFiltersProvider>(context);

        if (appInfo.followSystemTheme) {
          if (CustomThemes.getCurrentBrightness(context, appInfo) ==
              Brightness.dark) {
            changeSystemBarsColors(
                CustomThemes.light(appInfo).scaffoldBackgroundColor,
                Brightness.dark);
          } else {
            if (appInfo.darkThemeMode == 0) {
              changeSystemBarsColors(
                  CustomThemes.dark(appInfo).scaffoldBackgroundColor,
                  Brightness.light);
            } else if (appInfo.darkThemeMode == 1) {
              changeSystemBarsColors(
                  CustomThemes.black(appInfo).scaffoldBackgroundColor,
                  Brightness.light);
            }
          }
        } else {
          if (appInfo.themeMode == 0) {
            changeSystemBarsColors(
                CustomThemes.light(appInfo).scaffoldBackgroundColor,
                Brightness.dark);
          } else if (appInfo.themeMode == 1) {
            changeSystemBarsColors(
                CustomThemes.dark(appInfo).scaffoldBackgroundColor,
                Brightness.light);
          } else {
            changeSystemBarsColors(
                CustomThemes.black(appInfo).scaffoldBackgroundColor,
                Brightness.light);
          }
        }

        List<Locale> supportedLocales = [];
        for (int i = 0; i < AppInfoProvider.supportedLocales.length; i++) {
          supportedLocales.add(Locale(AppInfoProvider.supportedLocales[i]));
        }

        return MaterialApp(
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: supportedLocales,
          builder: (context, child) => ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: child,
          ),
          home: showWelcomeScreen ? WelcomeRoute() : NotesMainPageRoute(),
          debugShowCheckedModeBanner: false,
          theme: appInfo.followSystemTheme
              ? CustomThemes.light(appInfo)
              : (appInfo.themeMode == 0
                  ? CustomThemes.light(appInfo)
                  : appInfo.themeMode == 1
                      ? CustomThemes.dark(appInfo)
                      : CustomThemes.black(appInfo)),
          darkTheme: appInfo.darkThemeMode == 0
              ? CustomThemes.dark(appInfo)
              : CustomThemes.black(appInfo),
          themeMode:
              appInfo.followSystemTheme ? ThemeMode.system : ThemeMode.light,
          title: 'Notes',
          color: appInfo.mainColor,
        );
      }),
    );
  }
}
