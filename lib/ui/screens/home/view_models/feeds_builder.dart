import 'package:flutter/material.dart';
import 'package:newsapp/ui/screens/home/view_models/screen_builder.dart';
import 'package:newsapp/utils/enum.dart';
import 'package:provider/provider.dart';
import '../../../../data/api/api.dart';
import '../../../../utils/persistance/settings/settings_prefs.dart';
import '../components/article_tile/article_tile.dart';

class FeedsBuilder extends StatelessWidget {
  const FeedsBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lang = SettingsPrefs.lang;
    bool darkMode = SettingsPrefs.darkMode;
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: false,
      itemCount:
      Provider.of<NewsAPI>(context, listen: true).articles.length + 1,
      itemBuilder: (context, i) {
        if (i < Provider.of<NewsAPI>(context, listen: true).articles.length) {
          return ArticleTile(
              article: Provider.of<NewsAPI>(context, listen: true).articles[i],lang: lang,darkMode: darkMode);
        } else {
          /// to avoid a infinite progress indicator, show it only if data are loading, means that there are more to load
          if (Provider.of<NewsAPI>(context, listen: false)
              .apiRequestStatus
              .isLoadingMore) {
            return Container(
              margin: const EdgeInsets.only(top: 10,bottom: 10),
              child: const Center(
                child: SizedBox(
                  width: 60,
                  child: LinearProgressIndicator(minHeight: 3),
                ),
              ),
            );
          }
          return const SizedBox();
        }
      },
    );
  }
}