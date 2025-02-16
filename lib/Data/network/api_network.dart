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

    //  var data = await http.get(uri);
    //   log(data.body as num);
    // } catch(errors){
    //   throw Exception(errors.toString());
    // }
  }

