import 'package:flutter/material.dart';
import '../../../../../data/models/article.dart';

class ArticleTile extends StatelessWidget {
  final Article article;
  const ArticleTile({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(article.title??"No title"),
      subtitle: Text(article.source?.name??"No source"),
    );
  }
}
