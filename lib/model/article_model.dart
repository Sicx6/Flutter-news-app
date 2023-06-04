// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'source_model.dart';

class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  bool isAddedToWishlist;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    this.isAddedToWishlist = false,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source'] ?? 'no author'),
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
      description: json['description'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'source': source.toMap(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'isAddedToWishlist': isAddedToWishlist,
    };
  }
}
