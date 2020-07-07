import 'package:flutter/material.dart';
import 'package:potato_notes/internal/colors.dart';
import 'package:potato_notes/internal/providers.dart';
import 'package:potato_notes/internal/tag_model.dart';

class TagEditor extends StatefulWidget {
  final String initialInput;
  final void Function(TagModel) onSave;

  TagEditor({
    this.initialInput = "",
    this.onSave,
  });

  @override
  _NewTagState createState() => _NewTagState();
}

class _NewTagState extends State<TagEditor> {
  TagModel tag = TagModel(
    color: 0,
  );
  TextEditingController controller;

  @override
  void initState() {
    TagModel lastTag;
    List<TagModel> tags = prefs.tags ?? [];
    tags.sort((a, b) => a.id.compareTo(b.id));

    if (tags.isNotEmpty) {
      lastTag = tags.last;
    }

    tag.id = (lastTag?.id ?? 0) + 1;
    tag.name = widget.initialInput;

    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              "New tag",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Name",
              ),
              initialValue: tag.name,
              onChanged: (text) => setState(() => tag.name = text),
            ),
          ),
          Container(
            height: 66,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              scrollDirection: Axis.horizontal,
              itemCount: NoteColors.colorList.length,
              itemBuilder: (context, index) {
                return IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: index == 0
                              ? Theme.of(context).iconTheme.color
                              : Colors.transparent,
                          width: 1.5,
                        ),
                        color: index != 0
                            ? Color(NoteColors.colorList[index].color)
                            : Colors.transparent),
                    width: 32,
                    height: 32,
                    child: tag.color == index
                        ? Icon(
                            Icons.check,
                            color: index != 0
                                ? Theme.of(context).colorScheme.surface
                                : null,
                          )
                        : Container(),
                  ),
                  onPressed: () {
                    setState(() => tag.color = index);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed:
                      tag.name.isNotEmpty ? () => widget.onSave(tag) : null,
                  child: Text("Save"),
                  color: Theme.of(context).accentColor,
                  disabledColor: Theme.of(context).disabledColor,
                  textColor: Theme.of(context).cardColor,
                  disabledTextColor: Theme.of(context).cardColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
