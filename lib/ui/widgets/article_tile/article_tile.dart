import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/utils/persistance/settings/settings_prefs.dart';
import '../../../data/models/article.dart';

//TODO: cache image
class ArticleTile extends StatelessWidget {
  final Article article;

  const ArticleTile({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }

  Widget _imgBox(url) {
    return SizedBox(
      width: 100,
      child: CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => Ink.image(
          image: SettingsPrefs.darkMode?const AssetImage("assets/placeholder_dark.png"):const AssetImage("assets/placeholder.png"),
          fit: BoxFit.cover,
        ),
        errorWidget: (context, url, error) => Ink.image(
          image: SettingsPrefs.darkMode?const AssetImage("assets/placeholder_dark.png"):const AssetImage("assets/placeholder.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
