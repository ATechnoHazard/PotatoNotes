import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:potato_notes/data/database.dart';

class NoteViewStatusbar extends StatelessWidget {
  final Note note;

  NoteViewStatusbar({@required this.note});

  @override
  Widget build(BuildContext context) {
    List<Widget> icons = getIcons(context);

    return Visibility(
      visible: icons.isNotEmpty,
      child: Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: IconTheme(
          data: Theme.of(context).iconTheme.copyWith(size: 16),
          child: Wrap(
            children: List.generate(
              icons.isNotEmpty ? icons.length + icons.length - 1 : 0,
              (index) {
                if (index % 2 == 0)
                  return icons[index ~/ 2];
                else
                  return VerticalDivider(
                    width: 4,
                    color: Colors.transparent,
                  );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getIcons(BuildContext context) {
    List<int> iconDataIndexes = [];
    List<Widget> icons = [];

    if (note.hideContent) iconDataIndexes.add(0);

    if (note.pin != null || note.password != null) iconDataIndexes.add(1);

    if (note.reminders.reminders.isNotEmpty) iconDataIndexes.add(2);

    if (note.synced) iconDataIndexes.add(3);

    if (iconDataIndexes.length > 1) {
      iconDataIndexes.forEach((item) => icons.add(Icon(iconData[item].value)));
    } else if (iconDataIndexes.isNotEmpty) {
      icons.add(Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(iconData[iconDataIndexes[0]].value),
          SizedBox(width: 8),
          Text(
            iconData[iconDataIndexes[0]].key,
            style: TextStyle(
              color: Theme.of(context).iconTheme.color,
              fontSize: 12,
            ),
          ),
        ],
      ));
    }

    return icons;
  }
}

List<MapEntry<String, IconData>> get iconData => [
      MapEntry<String, IconData>(
          "Content hidden", CommunityMaterialIcons.eye_off_outline),
      MapEntry<String, IconData>(
          "Content locked", CommunityMaterialIcons.lock_outline),
      MapEntry<String, IconData>("Reminders set", CommunityMaterialIcons.alarm),
      MapEntry<String, IconData>("Synced", CommunityMaterialIcons.sync_icon),
    ];
