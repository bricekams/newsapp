import 'package:flutter/material.dart';
import '../../../../../data/models/article.dart';

class ArticleTile extends StatelessWidget {
  final Article article;

  const ArticleTile({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        article.source?.name ?? "No source",
        style: Theme.of(context).textTheme.bodyText2,
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

  _imgBox(url) {
    return SizedBox(
      width: 100,
      child: Ink.image(
        fit: BoxFit.cover,
        image: NetworkImage(url),
        onImageError: (obj, trace) {},
      ),
    );
  }
}
