import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/ui/screens/home/components/article_tile/article_tile.dart';
import 'package:newsapp/utils/localization.dart';
import 'package:newsapp/utils/persistance/settings/settings_prefs.dart';
import '../../../utils/persistance/bookmarks/boorkmarks_storage.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lang = SettingsPrefs.lang;
    bool darkMode = SettingsPrefs.darkMode;
    return Scaffold(
      appBar: AppBar(
        title: Text(dictionary["@bookmarks"][lang]),
      ),
      body: BookmarkStorage.allBookmarks.isNotEmpty?
          ValueListenableBuilder<Box<Article>>(
            valueListenable: Hive.box<Article>('bookmarks').listenable(),
            builder: (context,box,child){
              return ListView.builder(
                itemCount: BookmarkStorage.allBookmarks.length,
                itemBuilder: (context,index){
                  return ArticleTile(article: BookmarkStorage.allBookmarks.toList().reversed.toList()[index], lang: lang, darkMode: darkMode);
                },
              );
            },
          )
          :
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.bookmark_outline,
              color: Colors.grey,
              size: 50,
            ),
            const SizedBox(height: 15),
            Text(
              dictionary["@bookmarkEmpty"][lang],
              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold,color: SettingsPrefs.darkMode?Colors.grey.shade300:Colors.grey.shade700),
            )
          ],
        ),
      ),
    );
  }
}
