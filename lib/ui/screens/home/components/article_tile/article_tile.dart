import 'package:flutter/material.dart';
import 'package:newsapp/data/api/source_api.dart';
import 'package:newsapp/data/models/full_source.dart';
import 'package:newsapp/utils/persistance/settings/settings_prefs.dart';
import 'package:provider/provider.dart';
import '../../../../../data/models/article.dart';

class ArticleTile extends StatelessWidget {
  final Article article;

  const ArticleTile({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _logoBox(Provider.of<SourceAPI>(context,listen: true).fetchSourceLogoUrl(Provider.of<SourceAPI>(context,listen: true).sources.firstWhere((element) => element.id==article.source?.id,orElse: ()=>FullSource()).id??"")),
          Text(
            article.source?.name ?? "No source",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: SettingsPrefs.darkMode
                      ? Colors.grey.shade200
                      : Colors.grey.shade700,
                ),
          ),
        ],
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
      child: Ink.image(
        fit: BoxFit.cover,
        image: NetworkImage(url),
        onImageError: (obj, trace) {},
      ),
    );
  }

  Widget _logoBox(String url){
    return url.isNotEmpty ? SizedBox(
      width: 20,
      height: 20,
      child: Ink.image(
        fit: BoxFit.cover,
        image: NetworkImage(url),
        onImageError: (obj, trace) {},
      ),
    ):const SizedBox(width: 0,height: 0);
  }
}
