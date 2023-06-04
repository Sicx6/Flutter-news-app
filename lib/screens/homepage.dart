import 'package:flutter/material.dart';
import 'package:flutter_news_/Provider/theme_provider.dart';
import 'package:flutter_news_/Provider/user_provider.dart';
import 'package:flutter_news_/components/custom_listTile.dart';
import 'package:flutter_news_/model/article_model.dart';
import 'package:flutter_news_/screens/countryNews.dart';
import 'package:flutter_news_/screens/search_screens.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  static const String routeName = '/homepage-screen';
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _searchQuery = '';

  List<Article> wishList = [];

  void navigateCountryScreen() {
    Navigator.pushNamed(context, CountryNews.routeName);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeChanger>(context, listen: false);
    Api client = Api();
    return Scaffold(
      body: FutureBuilder(
        future: client.getArticle(),
        builder: (context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData) {
            List<Article> articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return customListTile(articles[index], context, wishList);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
