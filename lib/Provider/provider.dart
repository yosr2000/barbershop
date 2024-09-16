import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  bool _isdark = true;
  //Custom dark theme
  final darkTheme = ThemeData(
    primaryColor: Color.fromARGB(202, 36, 125, 233),
    brightness: Brightness.dark,
    primaryColorDark: Colors.black12,
  );

  //Custom light theme
  final lightTheme = ThemeData(
      primaryColor: Colors.white,
      brightness: Brightness.light,
      primaryColorDark: Colors.white);
  bool get isdark => !_isdark;
  void changeTheme() {
    _isdark = !_isdark;
    notifyListeners();
  }

  init() {
    notifyListeners();
  }
}
