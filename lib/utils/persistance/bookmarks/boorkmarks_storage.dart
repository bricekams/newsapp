import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../data/models/article.dart';

class BookmarkStorage {
  static Iterable allBookmarks = getAllBookmarks;

  ///open bookmark box
  static openBox() async {
    await Hive.openBox<Article>('bookmarks');
  }

  ///get all bookmarks from a openedBox called bookmarks
  static get getAllBookmarks {
    return Hive.box<Article>("bookmarks").values;
  }

  ///Add articles to the bookmark collection with key "${article.source?.name}${article.publishedAt}"
  static void addBookmark({required Article article}) async {
    try {
      await Hive.box<Article>("bookmarks").put(
          "${article.source?.name ?? ""}${article.publishedAt ?? ""}", article);
      log("added with success");
    } on HiveError catch (err) {
      log(err.message);
    }
  }

  static void removeBookmark({required String key}) async {
    try {
      await Hive.box<Article>('bookmarks').delete(key);
      log("removed with success");
    } on HiveError catch (err) {
      log(err.message);
    }
  }

  static bool isBookmarked({required String key}) {
    return Hive.box<Article>('bookmarks').containsKey(key);
  }
}