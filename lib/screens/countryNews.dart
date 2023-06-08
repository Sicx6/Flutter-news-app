// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_news_/components/custom_listTile.dart';
import 'package:flutter_news_/model/article_model.dart';
import 'package:flutter_news_/services/api.dart';

class CountryNews extends StatelessWidget {
  static const String routeName = '/country-screen';
  final String country;
// Add the wishlistId variable

  const CountryNews({
    Key? key,
    required this.country,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Api api = Api();
    return Scaffold(
      appBar: AppBar(
        title: Text('News by Country: $country'),
      ),
      body: FutureBuilder<List<Article>>(
        future: api.searchCountryArticles(country),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Article> articles = snapshot.data!;
            // Display the news articles here
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return customListTile(
                    article: articles[index],
                    context: context,
                  );
              },
            );
          } else {
            return Center(child: Text('No articles found'));
          }
        },
      ),
    );
  }
}
