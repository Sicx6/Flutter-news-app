import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_/model/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Provider/user_provider.dart';

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

  Future<void> addFavoriteArticle(Article article) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      if (user != null) {
        article.isAddedToFavourite = true; // Set isAddedToFavourite to true
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('articles')
            .add(article.toJson());

        Fluttertoast.showToast(msg: 'Article Added to Favourites');
      } else {
        // Handle case when user is not authenticated
        print('User is not authenticated');
      }
    } catch (e) {
      print('Error adding article to favorites: $e');
    }
  }

  Future<void> removeFavoriteArticle(Article article) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('articles')
            .where('url', isEqualTo: article.url)
            .get();

        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });

        print('Article removed from favorites successfully');
      } else {
        print('User is not authenticated');
      }
    } catch (e) {
      print('Error removing article from favorites: $e');
    }
  }

  // Stream<Article> getFavouriteArticleStream(Article article) {
  //   final user = FirebaseAuth.instance.currentUser;
  //   final snapshot = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user!.uid)
  //       .collection('articles')
  //       .where('author', isEqualTo: article.author)
  //       .orderBy('publishedAt', descending: true)
  //       .snapshots();

  //   return snapshot.map((querySnapshot) {
  //     final docs = querySnapshot.docs;
  //     if (docs.isNotEmpty) {
  //       final doc = docs.first;
  //       return Article.fromJson(doc.data());
  //     } else {
  //       return Article()''
  //     }
  //   });

  Future<List<Article>> getFavouriteArticle() async {
    final user = FirebaseAuth.instance.currentUser;
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('articles')
        .get();

    return snapshot.docs
        .map((e) => Article.fromJson(e.data() as Map<String, dynamic>))
        .toList();
  }

  Stream<List<Article>> getFavouriteArticleStream() {
    final user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('articles')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((e) => Article.fromJson(e.data() as Map<String, dynamic>))
            .toList());
  }
}
