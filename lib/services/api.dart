import 'dart:convert';

import 'package:flutter_news_/model/article_model.dart';
import 'package:http/http.dart' as http;

class Api {
  final url =
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=d887dd084e044c339d3d09c2774fc065';

  Future<List<Article>> getArticle() async {
    http.Response response = await http.get(
      Uri.parse(url),
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['articles'];

        List<Article> article =
            body.map((item) => Article.fromJson(item)).toList();

        return article;
      } else {
        throw ('cant get the article');
      }
    } catch (e) {
      print(e.toString());
      throw (e);
    }
  }
}
