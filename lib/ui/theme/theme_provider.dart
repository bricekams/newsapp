import 'package:flutter/cupertino.dart';
import 'package:newsapp/utils/persistance/settings/settings_prefs.dart';

class AppThemeProvider with ChangeNotifier {
  bool _isDark = SettingsPrefs.darkMode;
  bool get isItDark => _isDark;
  set setDarkTheme(bool value){
    _isDark = value;
    notifyListeners();
  }
}