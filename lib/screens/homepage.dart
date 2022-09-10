import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_news_/components/custom_listTile.dart';
import 'package:flutter_news_/model/article_model.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/api.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Api client = Api();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NEWS APPS',
          style: GoogleFonts.getFont('Lato'),
        ),
      ),
      body: FutureBuilder(
        future: client.getArticle(),
        builder: (context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData) {
            List<Article> articles = snapshot.data!;
            return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return customListTile(articles[index], context);
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
