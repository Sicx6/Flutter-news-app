import 'package:flutter/material.dart';
import 'package:flutter_news_/components/custom_listTile.dart';
import 'package:flutter_news_/model/article_model.dart';
import 'package:flutter_news_/screens/search_screens.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _searchQuery = '';

  List<Article> wishList = [];

  @override
  Widget build(BuildContext context) {
    Api client = Api();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MYNEWS APPS',
          style: GoogleFonts.getFont('Lato'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: ArticleSearchDelegate(wishList),
                );
              },
              child: const Icon(Icons.search),
            ),
          ),
        ],
      ),
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
