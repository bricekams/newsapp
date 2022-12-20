import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newsapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPrefs {

  static openBox() async {
    await Hive.openBox("settings");
  }

  static final Box _box = Hive.box("settings");

  static bool get darkMode => _box.get("darkMode") as bool;
  static String get lang => _box.get("lang") as String;
  static bool get jsActive => _box.get("jsMode") as bool;
  static bool get jsWarningDisplay => _box.get("doNotShowJsWarning") as bool;

  static void initBox() async {
    _box.put("darkMode", _box.get('darkMode', defaultValue: false) as bool);
    _box.put("lang", _box.get("lang", defaultValue: "en") as String);
    _box.put("jsMode", _box.get('jsMode', defaultValue: false) as bool);
    _box.put("doNotShowJsWarning",
        _box.get('doNotShowJsWarning', defaultValue: false) as bool);
  }

  static void setDarkTheme(BuildContext context) {
    bool isDark =
        Provider.of<AppThemeProvider>(context, listen: false).isItDark;
    Provider.of<AppThemeProvider>(context, listen: false).setDarkTheme =
        !isDark;
  }

  static void setLang() {
    String currentLang = _box.get("lang") as String;
    _box.put("lang", currentLang == "en" ? "fr" : "en");
  }

  static void setJsMode(value) {
    _box.put("jsMode", value);
    if (value == false) _box.put("doNotShowJsWarning", false); /// show js warning again
  }

  static void setJsWarningDisplay (value) {
    _box.put("doNotShowJsWarning", value);
  }
}
