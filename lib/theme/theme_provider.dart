import 'package:flutter/cupertino.dart';

class AppThemeProvider with ChangeNotifier {
  bool _isDark = false;
  bool get isItDark => _isDark;
  set setDarkTheme(bool value){
    _isDark = value;
  }
}