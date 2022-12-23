import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/full_source.dart';

class SourceAPI with ChangeNotifier {
  final Dio _dio = Dio()
    ..options.connectTimeout = 60000
    ..options.sendTimeout = 60000
    ..options.receiveTimeout = 60000
    ..options.headers = {"Connection": "KeepAlive"};

  final String _apiKey = dotenv.env['NEWS_API_KEY']!;

  List<FullSource> sources = [];

  void fetchAllSource() async {
    Response response;
    List<dynamic> body;
    List<FullSource> sources;
    String endpoint =
        'https://newsapi.org/v2/top-headlines/sources?apiKey=$_apiKey';
    try {
      response = await _dio.get(endpoint);
      body = response.data["sources"];
      sources = body.map((item) => FullSource.fromJson(item)).toList();
      this.sources.addAll(sources);
      log("added");
      notifyListeners();
    } on DioError catch (err) {
      log(err.message);
      rethrow;
    }
  }

  String fetchSourceLogoUrl(String id) {
    FullSource? source = sources.firstWhere((element) => element.id == id,
        orElse: () => FullSource());
    String? siteUrl = source.url;
    String logoUrl = 'https://www.google.com/s2/favicons?domain=$siteUrl}';
    log(logoUrl);
    return siteUrl==null?"":logoUrl;
  }
}
