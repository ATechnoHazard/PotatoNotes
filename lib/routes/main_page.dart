import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:potato_notes/data/dao/note_helper.dart';
import 'package:potato_notes/data/database.dart';
import 'package:potato_notes/internal/app_info.dart';
import 'package:potato_notes/routes/note_page.dart';
import 'package:potato_notes/widget/note_view.dart';
import 'package:provider/provider.dart';
import 'package:spicy_components/spicy_components.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int numOfColumns;
  int numOfImages;
  AppInfoProvider appInfo;
  NoteHelper helper;

  @override
  void dispose() {
    appInfo.accentSubscription.cancel();
    appInfo.themeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (appInfo == null) appInfo = Provider.of<AppInfoProvider>(context);

    if (helper == null) helper = Provider.of<NoteHelper>(context);

    double width = MediaQuery.of(context).size.width;

    if (width >= 1280) {
      numOfColumns = 5;
      numOfImages = 4;
    } else if (width >= 900) {
      numOfColumns = 4;
      numOfImages = 3;
    } else if (width >= 600) {
      numOfColumns = 3;
      numOfImages = 3;
    } else if (width >= 360) {
      numOfColumns = 2;
      numOfImages = 2;
    } else {
      numOfColumns = 1;
      numOfImages = 2;
    }

    return Scaffold(
      body: StreamBuilder<List<Note>>(
        stream: helper.noteStream(),
        builder: (context, snapshot) {
          if ((snapshot.data?.length ?? 0) != 0) {
            return StaggeredGridView.countBuilder(
              crossAxisCount: numOfColumns,
              itemBuilder: (context, index) => NoteView(
                note: snapshot.data[index],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotePage(
                      note: snapshot.data[index],
                      numOfImages: numOfImages,
                    ),
                  ),
                ),
                numOfImages: numOfImages,
              ),
              staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              itemCount: snapshot.data.length,
              padding: EdgeInsets.fromLTRB(
                4,
                4 + MediaQuery.of(context).padding.top,
                4,
                4.0 + 56,
              ),
            );
          } else
            return Text("bruh");
        },
      ),
      extendBody: true,
      bottomNavigationBar: SpicyBottomBar(
        leftItems: [
          IconButton(
            icon: Icon(Icons.menu),
            padding: EdgeInsets.all(0),
            onPressed: () {},
          ),
        ],
        elevation: 12,
        notched: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotePage(
                numOfImages: numOfImages,
              ),
            ),
          );
          appInfo.barManager.lightNavBarColor = SpicyThemes.light(appInfo.mainColor).cardColor;
          appInfo.barManager.darkNavBarColor = SpicyThemes.dark(appInfo.mainColor).cardColor;
        },
        child: Icon(OMIcons.edit),
        backgroundColor: Theme.of(context).accentColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
