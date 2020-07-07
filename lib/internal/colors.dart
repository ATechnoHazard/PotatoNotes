import 'package:flutter/material.dart';

class NoteColors {
  static List<ColorInfo> get colorList {
    return [
      NoteColors.none,
      NoteColors.red,
      NoteColors.orange,
      NoteColors.yellow,
      NoteColors.green,
      NoteColors.cyan,
      NoteColors.lightBlue,
      NoteColors.blue,
      NoteColors.purple,
      NoteColors.pink,
    ];
  }

  static ColorInfo get none => ColorInfo(
        label: "None",
        color: Colors.transparent.value,
      );

  static ColorInfo get red => ColorInfo(
        label: "Red",
        color: 0xFFF44336,
        lightColor: 0xFFF99B94,
        darkColor: 0xFF5B2925,
      );

  static ColorInfo get orange => ColorInfo(
        label: "Orange",
        color: 0xFFF57C00,
        lightColor: 0xFFF9CE94,
        darkColor: 0xFF5B4325,
      );

  static ColorInfo get yellow => ColorInfo(
        label: "Yellow",
        color: 0xFFffb300,
        lightColor: 0xFFF9EF94,
        darkColor: 0xFF5B5525,
      );

  static ColorInfo get green => ColorInfo(
        label: "Green",
        color: 0xFF4CAf50,
        lightColor: 0xFF94F998,
        darkColor: 0xFF255B27,
      );

  static ColorInfo get cyan => ColorInfo(
        label: "Cyan",
        color: 0xFF00ACC1,
        lightColor: 0xFF94F9EC,
        darkColor: 0xFF255B53,
      );

  static ColorInfo get lightBlue => ColorInfo(
        label: "Light blue",
        color: 0xFF03A9f4,
        lightColor: 0xFF94D9F9,
        darkColor: 0xFF254A5B,
      );

  static ColorInfo get blue => ColorInfo(
        label: "Blue",
        color: 0xFF1E88E5,
        lightColor: 0xFF94A5F9,
        darkColor: 0xFF252E5B,
      );

  static ColorInfo get purple => ColorInfo(
        label: "Purple",
        color: 0xFF9C27B0,
        lightColor: 0xFFBD94F9,
        darkColor: 0xFF3A255B,
      );

  static ColorInfo get pink => ColorInfo(
        label: "Pink",
        color: 0xFFE91E63,
        lightColor: 0xFFF994D4,
        darkColor: 0xFF5B2547,
      );
}

class ColorInfo {
  final String label;
  final int color;
  final int lightColor;
  final int darkColor;

  ColorInfo({
    @required this.label,
    @required this.color,
    this.lightColor,
    this.darkColor,
  });

  int dynamicColor(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;

    return brightness == Brightness.light
        ? lightColor ?? color
        : darkColor ?? color;
  }
}
