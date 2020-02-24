import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:potato_notes/internal/localizations.dart';
import 'package:potato_notes/internal/note_helper.dart';
import 'package:potato_notes/internal/utils.dart';
import 'package:potato_notes/routes/modify_notes_route.dart';

class SecurityNoteRoute extends StatefulWidget {
  final Note note;
  final String heroIndex;

  SecurityNoteRoute({@required this.note, @required this.heroIndex});

  @override
  createState() => _SecurityNoteRouteState();
}

class _SecurityNoteRouteState extends State<SecurityNoteRoute> {
  String text = "";

  int pinDigitsInserted = 0;

  AppLocalizations locales;

  @override
  void initState() {
    super.initState();
    text = "";
  }

  @override
  Widget build(BuildContext context) {
    locales = AppLocalizations.of(context);

    Brightness systemBarsIconBrightness =
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark;

    Utils.changeSystemBarsColors(
        Theme.of(context).scaffoldBackgroundColor, systemBarsIconBrightness);

    List<Widget> portraitContent = <Widget>[
      Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Container(
          height: 70,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  tooltip: "Back",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 70),
        height: MediaQuery.of(context).size.height -
            (MediaQuery.of(context).padding.top + 70),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Icon(
                  Icons.lock,
                  size: 120,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  widget.note.pin != null
                      ? locales.securityNoteRoute_request_pin
                      : locales.securityNoteRoute_request_password,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Visibility(
                visible: widget.note.pin != null,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: buildPinViewer(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            pinButton("1", true),
                            pinButton("2", true),
                            pinButton("3", true),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            pinButton("4", true),
                            pinButton("5", true),
                            pinButton("6", true),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            pinButton("7", true),
                            pinButton("8", true),
                            pinButton("9", true),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            pinEmptyButton(true),
                            pinButton("0", true),
                            eraseButton(true),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                  visible: widget.note.password != null,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      obscureText: true,
                      onSubmitted: (text) async {
                        String hashedInput = widget.note.password.length == 64
                            ? sha256.convert(utf8.encode(text)).toString()
                            : text;

                        if (hashedInput == widget.note.password.toString()) {
                          Navigator.pop(context);

                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ModifyNotesRoute(
                                      note: widget.note,
                                      heroIndex: widget.heroIndex)));

                          //if (result == null || result != null)
                          //  Navigator.pop(context);
                        }
                      },
                    ),
                  )),
            ],
          ),
        ),
      ),
    ];

    List<Widget> landscapeContent = <Widget>[
      Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Container(
          height: 70,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  tooltip: "Back",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 70),
        height: MediaQuery.of(context).size.height -
            (MediaQuery.of(context).padding.top + 70),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).padding.top + 70),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Icon(
                        Icons.lock,
                        size: 120,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        widget.note.pin != null
                            ? locales.securityNoteRoute_request_pin
                            : locales.securityNoteRoute_request_password,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).padding.top + 70),
                child: Column(
                  children: <Widget>[
                    Visibility(
                      visible: widget.note.pin != null,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: buildPinViewer(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  pinButton("1", false),
                                  pinButton("2", false),
                                  pinButton("3", false),
                                  pinButton("4", false),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  pinButton("5", false),
                                  pinButton("6", false),
                                  pinButton("7", false),
                                  pinButton("8", false),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  pinEmptyButton(false),
                                  pinButton("9", false),
                                  pinButton("0", false),
                                  eraseButton(false),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                        visible: widget.note.password != null,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: TextField(
                            obscureText: true,
                            onSubmitted: (text) async {
                              String hashedInput =
                                  widget.note.password.length == 64
                                      ? sha256
                                          .convert(utf8.encode(text))
                                          .toString()
                                      : text;

                              if (hashedInput ==
                                  widget.note.password.toString()) {
                                Navigator.pop(context);

                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ModifyNotesRoute(
                                            note: widget.note,
                                            heroIndex: widget.heroIndex)));
                              }
                            },
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      body: Stack(
        children: MediaQuery.of(context).orientation == Orientation.landscape
            ? landscapeContent
            : portraitContent,
      ),
    );
  }

  List<Widget> buildPinViewer() {
    List<Widget> widgets = [];

    if (pinDigitsInserted > 0) {
      for (int i = 0; i < pinDigitsInserted; i++) {
        widgets.add(Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
                color: Theme.of(context).textTheme.headline6.color,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Theme.of(context).textTheme.headline6.color,
                    width: 1.5)),
          ),
        ));
      }
    } else {
      widgets.add(Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          height: 18,
          width: 18,
        ),
      ));
    }

    return widgets;
  }

  Widget pinButton(String char, bool portrait) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: portrait ? 16 : 6, horizontal: portrait ? 20 : 8),
      child: IconButton(
        iconSize: portrait ? 60 : 50,
        tooltip: char,
        icon: Text(
          char,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
        onPressed: () async {
          setState(() {
            text += char;
            pinDigitsInserted = text.length;
          });

          String hashedInput = widget.note.pin.length == 64
              ? sha256.convert(utf8.encode(text)).toString()
              : text;

          if (hashedInput == widget.note.pin) {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ModifyNotesRoute(
                        note: widget.note, heroIndex: widget.heroIndex)));

            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Widget eraseButton(bool portrait) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: portrait ? 16 : 6, horizontal: portrait ? 20 : 10),
      child: IconButton(
        iconSize: portrait ? 60 : 50,
        tooltip: "Delete last digit",
        icon: Icon(
          Icons.keyboard_backspace,
          size: 30,
        ),
        onPressed: () async {
          if (text.length > 0) {
            setState(() {
              text = text.substring(0, text.length - 1);
              pinDigitsInserted = text.length;
            });
          }
        },
      ),
    );
  }

  Widget pinEmptyButton(bool portrait) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: portrait ? 16 : 6, horizontal: portrait ? 20 : 10),
      child: IconButton(
        iconSize: portrait ? 60 : 50,
        icon: Text(
          "",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
        onPressed: null,
      ),
    );
  }
}
