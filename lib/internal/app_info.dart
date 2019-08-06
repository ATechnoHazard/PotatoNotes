import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:potato_notes/internal/methods.dart';

class AppInfoProvider extends ChangeNotifier {
  AppInfoProvider() {
    loadData();
  }

  bool _isDark = false;
  Color _mainColor = Colors.blue;
  bool _devShowIdLabels = false;

  bool get isDark => _isDark;
  Color get mainColor => _mainColor;
  bool get devShowIdLabels => _devShowIdLabels;

  set isDark(bool val) {
    _isDark = val;
    setDark(val);
    notifyListeners();
  }

  set mainColor(Color color) {
    _mainColor = color;
    setMainColor(color);
    notifyListeners();
  }

  set devShowIdLabels(bool val) {
    _devShowIdLabels = val;
    setDevShowIdLabels(val);
    notifyListeners();
  }

  Future<void> loadData() async {
    isDark = await getDark();
    mainColor = await getMainColor();
    devShowIdLabels = await getDevShowIdLabels();
  }
}