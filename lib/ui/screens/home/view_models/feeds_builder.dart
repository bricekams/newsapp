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
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        log("end end end");
        Provider.of<NewsAPI>(context, listen: false).addToArticlesList();
      }
    });
    return ListView.builder(
      controller: scrollController,
      itemCount:
          Provider.of<NewsAPI>(context, listen: false).articles.length + 1,
      primary: false,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, i) {
        if (i < Provider.of<NewsAPI>(context, listen: false).articles.length) {
          return ArticleTile(
              article: Provider.of<NewsAPI>(context, listen: true).articles[i]);
        } else {
          if (Provider.of<NewsAPI>(context, listen: true)
              .apiRequestStatus
              .isLoadingMore) {
            return SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
          return const SizedBox();
        }
      },
    );
  }
}
