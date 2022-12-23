import 'package:flutter/material.dart';
import 'package:newsapp/utils/localization.dart';
import 'package:newsapp/utils/persistance/settings/settings_prefs.dart';
/// TODO: bookmarks save and read articles
class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lang = SettingsPrefs.lang;
    return Scaffold(
      appBar: AppBar(
        title: Text(dictionary["@bookmarks"][lang]),
      ),
    );
  }
}
