import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app/cores/constants/EndPoints.dart';
import 'package:news_app/cores/constants/constnts.dart';


import '../article_model.dart';
import '../source_model.dart';

abstract class AbiNetwork{

  static Future<List<Source>> getAllSources (String CategoryID) async{

    try{
      var queryParameters = {
        "apiKey": Constants.apiKey,
        "Category": CategoryID
      };
      var uri =   Uri.https(
          Constants.baseURL,
          EndPoints.getAllSources,
          queryParameters
      );


      var response = await http.get(uri);
      Map<String, dynamic> data = jsonDecode(response.body);

      log(response.request.toString() );
      log(response.body.toString() );

      SourcesModel sourceModel = SourcesModel.fromJson(data);

      return sourceModel.sources;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<List<Article>> getAllArticles(String sourceID) async {
    try {
      var queryParameters = {
        "apiKey": Constants.apiKey,
        "sources": sourceID,
      };

      var uri = Uri.https(
        Constants.baseURL,
        EndPoints.getAllArticles,
        queryParameters,
      );

      var response = await http.get(uri);

      log(response.request.toString() );
      log(response.body.toString() );

      Map<String, dynamic> data = jsonDecode(response.body);

      ArticleModel articleModel = ArticleModel.fromJson(data);

      return articleModel.articles;
    } catch (error) {
      throw Exception(error.toString());
    }
  }
  static Future<List<Article>> searchArticle({
    required String searchQuery,
    required int pageNumber,
  }) async {
    try {
      var queryParameters = {
        "page": pageNumber.toString(),
        "q": searchQuery,
        "pageSize": "10",
        "apiKey": Constants.apiKey
      };

      var uri = Uri.https(
        Constants.baseURL,
        Constants.everything,
        queryParameters,

      );
      log("Final API URL: $uri");
      var response = await http.get(uri);

      log(response.request.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        ArticleModel articleModel = ArticleModel.fromJson(data);
        return articleModel.articles ?? [];
      } else {
        log("Error: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      log("Exception: $error");
      return [];
    }
  }
  }

