import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_news_/components/custom_listTile.dart';
import 'package:flutter_news_/model/article_model.dart';
import 'package:flutter_news_/services/api.dart';

class CountryNews extends StatelessWidget {
  static const String routeName = '/country-screen';
  final String country;

  const CountryNews({required this.country});

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
                return customListTile(articles[index], context, []);
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
