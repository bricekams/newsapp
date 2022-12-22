import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:newsapp/utils/enum.dart';
import 'package:provider/provider.dart';

import '../../../../data/api/api.dart';
import '../components/article_tile/article_tile.dart';

class FeedsBuilder extends StatelessWidget {
  const FeedsBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        log("end end end");
        Provider.of<NewsAPI>(context, listen: false).addToArticlesList();
      }
    });
    return Column(
      children: [
        ...Provider.of<NewsAPI>(context, listen: true)
            .articles
            .map((article) => ArticleTile(article: article))
            .toList(),
        if (Provider.of<NewsAPI>(context, listen: true)
            .apiRequestStatus
            .isLoadingMore) SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),
        )
      ],
    );
  }
}
