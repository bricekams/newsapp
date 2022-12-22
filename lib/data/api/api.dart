import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsapp/utils/enum.dart';
import 'package:newsapp/utils/localization.dart';
import '../../utils/persistance/settings/settings_prefs.dart';
import '../models/article.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsAPI with ChangeNotifier {
  final Dio _dio = Dio()
    ..options.connectTimeout = 60000
    ..options.sendTimeout = 60000
    ..options.receiveTimeout = 60000
    ..options.baseUrl = "https://newsapi.org/v2"
    ..options.headers = {"Connection": "KeepAlive"};

  final String _apiKey = dotenv.env['NEWS_API_KEY']!;

  APIRequestStatus _apiRequestStatus = APIRequestStatus.unInitialized;

  APIRequestStatus get apiRequestStatus => _apiRequestStatus;

  set setAPIRequestStatus(APIRequestStatus status) {
    _apiRequestStatus = status;
    notifyListeners();
  }

  int _page = 1;
  final int _defaultApiLastPage = 5;
  int get getPage => _page;

  void incrementPage() {
    _page++;
  }

  void resetPage() {
    _page = 1;
  }

  int _categoryIndex = 0;

  int get currentCategoryIndex => _categoryIndex;

  set setCategoryIndex(int value) {
    _categoryIndex = value;
    fetchNewsCategory();
  }

  List<Article> articles = [];

  Future<List<Article>> requestNewsByCategories(int i,bool loadMore) async {
    setAPIRequestStatus = loadMore?APIRequestStatus.loadingMore:APIRequestStatus.loading;
    Response response;
    List<dynamic> body;
    List<Article> articles;
    String lang = SettingsPrefs.lang;
    String endpoint =
        '/top-headlines?language=$lang&category=${categories['en']?[_categoryIndex]}&page=$i&pageSize=20&apiKey=$_apiKey';
    try {
      response = await _dio.get(endpoint);
      body = response.data["articles"];
      articles = body.map((item) => Article.fromJson(item)).toList();
      return articles;
    } on DioError catch (err) {
      log(err.message);
      log(err.requestOptions.uri.path);
      setAPIRequestStatus = APIRequestStatus.error;
      rethrow;
    }
  }

  Future<List<Article>> requestNewsBySearch(String query) async {
    Response response;
    List<dynamic> body;
    String lang = SettingsPrefs.lang;
    String endpoint = 'everything?language=$lang&q=$query&apiKey=$_apiKey';
    try {
      response = await _dio.get(endpoint);
      body = response.data["articles"];
      articles = body.map((item) => Article.fromJson(item)).toList();
      return articles;
    } on DioError catch (err) {
      rethrow;
    }
  }

  /// set page = 1
  /// clear the current article list then add new news
  void fetchNewsCategory() async {
    resetPage();
    requestNewsByCategories(1,false).then((articles){
      this.articles.clear();
      this.articles.addAll(articles);
      setAPIRequestStatus = APIRequestStatus.loaded;
    });
  }

  void loadMoreNews() async {
    /// the api allow us to load 20 by pages only 5 times, 5*100, more available for premium
    if (getPage < _defaultApiLastPage) {
      requestNewsByCategories(getPage+1,true).then((articles) {
        this.articles.addAll(articles);
        setAPIRequestStatus = APIRequestStatus.loaded;
        /// next page
        incrementPage();
      }).onError((error, stackTrace) {
        log(error.toString());
        setAPIRequestStatus = APIRequestStatus.error;
      });
    }
  }


}
