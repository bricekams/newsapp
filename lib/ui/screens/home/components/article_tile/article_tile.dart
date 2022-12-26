import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:newsapp/ui/screens/webview/webview.dart';
import 'package:newsapp/utils/localization.dart';
import 'package:newsapp/utils/persistance/bookmarks/boorkmarks_storage.dart';
import 'package:newsapp/utils/persistance/settings/settings_prefs.dart';
import '../../../../../data/models/article.dart';

//TODO: placeholder loading and evict from cache

class ArticleTile extends StatelessWidget {
  final Article article;
  final String lang;
  final bool darkMode;

  const ArticleTile(
      {Key? key,
      required this.article,
      required this.lang,
      required this.darkMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.grey.shade300;
    String bookmarkKey =
        "${article.source?.name ?? ""}${article.publishedAt ?? ""}";
    bool isBookmarked = BookmarkStorage.isBookmarked(key: bookmarkKey);
    return Slidable(
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: (context) {},
            icon: Icons.share,
          ),
          ValueListenableBuilder<Box<Article>>(
            valueListenable: Hive.box<Article>('bookmarks').listenable(),
            builder: (context,box,child){
              return SlidableAction(
                backgroundColor: bgColor,
                label: box.containsKey(bookmarkKey)?dictionary['@removeBookmark'][lang]:dictionary['@addBookmark'][lang],
                onPressed: (context) {
                  if (box.containsKey(bookmarkKey)) {
                    BookmarkStorage.removeBookmark(key: bookmarkKey);
                  } else {
                    BookmarkStorage.addBookmark(article: article);
                  }
                },
                icon: box.containsKey(bookmarkKey)
                    ? Icons.bookmark_remove_outlined
                    : Icons.bookmark_add_outlined,
              );
            },
          )
        ],
      ),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            label: dictionary['@read'][lang],
            backgroundColor: bgColor,
            foregroundColor: Theme.of(context).primaryColor,
            onPressed: (context) {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context)=>ArticleWebView(url: article.url??""))
              // );
            },
            icon: Icons.open_in_new,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListTile(
          title: Text(
            article.source?.name ?? "No source",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: SettingsPrefs.darkMode
                      ? Colors.grey.shade200
                      : Colors.grey.shade700,
                ),
          ),
          subtitle: Text(
            article.title ?? "No title",
            maxLines: 3,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
          ),
          trailing: _imgBox(article.urlToImage ?? ""),
        ),
      ),
    );
  }

  Widget _imgBox(url) {
    return SizedBox(
      width: 100,
      child: CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: darkMode
                  ? const AssetImage("assets/placeholder_dark.png")
                  : const AssetImage("assets/placeholder.png"),
            )
          ),
        ),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: darkMode
                    ? const AssetImage("assets/placeholder_dark.png")
                    : const AssetImage("assets/placeholder.png"),
              )
          ),
        ),
      ),
    );
  }
}
