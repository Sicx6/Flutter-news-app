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

        List<Article> articles =
            body.map((item) => Article.fromJson(item)).toList();

        return articles;
      } else {
        throw Exception('Failed to get articles');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to get articles');
    }
  }

  Future<List<Article>> searchArticles(String query) async {
    final searchUrl =
        'https://newsapi.org/v2/everything?q=$query&apiKey=d887dd084e044c339d3d09c2774fc065';

    http.Response response = await http.get(
      Uri.parse(searchUrl),
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['articles'];

        List<Article> articles =
            body.map((item) => Article.fromJson(item)).toList();

        return articles;
      } else {
        throw Exception('Failed to search articles');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to search articles');
    }
  }

  Future<List<Article>> searchCountryArticles(String country) async {
    final searchCountry =
        'https://newsapi.org/v2/top-headlines?country=$country&apiKey=d887dd084e044c339d3d09c2774fc065';

    http.Response response = await http.get(
      Uri.parse(searchCountry),
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['articles'];

        List<Article> articles =
            body.map((item) => Article.fromJson(item)).toList();

        print(articles);

        return articles;
      } else {
        throw Exception('Failed to search articles');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to search articles');
    }
  }
}


