import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:potato_notes/data/dao/note_helper.dart';

class MainPageBar extends StatelessWidget {
  final ReturnMode currentMode;
  final Function(ReturnMode) onReturnModeChange;

  MainPageBar({
    this.currentMode = ReturnMode.NORMAL,
    this.onReturnModeChange,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(CommunityMaterialIcons.home_variant_outline),
          activeIcon: Icon(CommunityMaterialIcons.home_variant),
          title: Text("Home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(OMIcons.archive),
          activeIcon: Icon(Icons.archive),
          title: Text("Archive"),
        ),
        BottomNavigationBarItem(
          icon: Icon(CommunityMaterialIcons.trash_can_outline),
          activeIcon: Icon(CommunityMaterialIcons.trash_can),
          title: Text("Trash"),
        ),
        BottomNavigationBarItem(
          icon: Icon(CommunityMaterialIcons.bookmark_outline),
          activeIcon: Icon(CommunityMaterialIcons.bookmark),
          title: Text("Bookmarks"),
        ),
      ],
      currentIndex: currentMode.index - 1,
      onTap: (index) => onReturnModeChange(ReturnMode.values[index + 1]),
      type: BottomNavigationBarType.fixed,
    );
  }
}
