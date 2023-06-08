import 'package:flutter/material.dart';
import 'package:flutter_news_/model/article_model.dart';

class ArticleProvider with ChangeNotifier {
  List<Article> _articles = [];

  List<Article> get articles => _articles;

  void addArticle(Article article) {
    _articles.add(article);
    notifyListeners();
  }

  void removeArticle(Article article) {
    _articles.remove(article);
    notifyListeners();
  }

  void toggleFavorite(Article article) {
    article.isAddedToFavourite = !article.isAddedToFavourite;
    notifyListeners();
  }
}
