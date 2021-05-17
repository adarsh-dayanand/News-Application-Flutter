import 'package:dio/dio.dart';
import 'package:news_app/model/article_response.dart';
import 'package:news_app/model/source_response.dart';

class NewsRepository{
  static String mainUrl = "";
  final String apiKey = "";

  final Dio _dio = Dio();

  var getSourcesUrl = "$mainUrl/sources";
  var getTopHeadlinesUrl = "$mainUrl/top-headlines";
  var everythingUrl = "$mainUrl/everything";

  Future<SourceResponse> getSources() async {
    var params = {
      "apiKey": apiKey,
      "language": "en",
      "country": "in"
    };
    try{
      Response response = await _dio.get(getSourcesUrl, queryParameters: params);
      return SourceResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error \nStacktrace: $stacktrace");
      return SourceResponse.withError(error);
    }
  }

  Future<ArticleResponse> getTopHeadlines() async {
    var params = {
      "apiKey": apiKey,
      "country": "in"
    };
    try{
      Response response = await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error \nStacktrace: $stacktrace");
      return ArticleResponse.withError(error);
    }
  }

  Future<ArticleResponse> getHotNews() async {
    var params = {
      "apiKey": apiKey,
      "q": "india",
      "sortBy": "popularity"
    };
    try {
      Response response = await _dio.get(everythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error \nStacktrace: $stacktrace");
      return ArticleResponse.withError(error);
    }
  }


  Future<ArticleResponse> getSourceNews(String sourceId) async {
    var params = {
      "apiKey": apiKey,
      "sources": sourceId
    };
    try{
      Response response = await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error \nStacktrace: $stacktrace");
      return ArticleResponse.withError(error);
    }
  }


  Future<ArticleResponse> search(String searchValue) async {
    var params = {
      "apiKey": apiKey,
      "q": searchValue
    };
    try{
      Response response = await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error \nStacktrace: $stacktrace");
      return ArticleResponse.withError(error);
    }
  }

}