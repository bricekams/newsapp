import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:newsapp/data/api/api.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/ui/screens/home/components/article_tile/article_tile.dart';
import 'package:newsapp/ui/screens/home/components/errors_widgets/api_error_widget.dart';
import 'package:newsapp/ui/screens/home/components/errors_widgets/no_internet_widget.dart';
import 'package:newsapp/ui/screens/home/components/search_delegate/shimmer/shimmer.dart';
import 'package:newsapp/utils/enum.dart';
import 'package:newsapp/utils/localization.dart';
import 'package:newsapp/utils/persistance/settings/settings_prefs.dart';
import 'package:provider/provider.dart';

class ArticleSearchDelegate extends SearchDelegate<Article?> {
  ArticleSearchDelegate();

  String lang = SettingsPrefs.lang;
  bool darkMode = SettingsPrefs.darkMode;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
        Provider.of<NewsAPI>(context, listen: false).searchResults.clear();
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Provider.of<NewsAPI>(context, listen: false)
      ..setSearchAPIRequestStatus = APIRequestStatus.searchLoading
      ..fetchNewsBySearchQuery(query.characters.string);

    return FutureBuilder(
      future: Provider.of<NewsAPI>(context, listen: false)
          .requestNewsBySearch(query.characters.string),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Article> articles = snapshot.data as List<Article>;
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, i) {
              return ArticleTile(
                lang: lang,
                article: articles[i],
                darkMode: darkMode,
              );
            },
          );
        }
        if (snapshot.hasError) {
          InternetConnectionChecker().hasConnection.then((value) {
            if (value) {
              return const ApiErrorWidget(search: true);
            } else {
              return const NoInternetErrorWidget();
            }
          });
        }
        return const LoadingShimmer();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (Provider.of<NewsAPI>(context, listen: false).searchResults.isNotEmpty) {
      List<Article> results =
          Provider.of<NewsAPI>(context, listen: false).searchResults;
      return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, i) {
          return ArticleTile(
              lang: lang, article: results[i], darkMode: darkMode);
        },
      );
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.search, size: 60, color: Colors.grey),
          const SizedBox(
            height: 20,
          ),
          Text(
            dictionary['@searchSm'][SettingsPrefs.lang],
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
