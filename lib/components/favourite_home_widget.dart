import 'package:flutter/material.dart';
import 'package:flutter_news_/Provider/theme_provider.dart';
import 'package:flutter_news_/model/article_model.dart';
import 'package:flutter_news_/screens/article_screes.dart';
import 'package:flutter_news_/services/api.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

Widget favouriteHome({
  required Article article,
  required BuildContext context,
}) {
  final api = Api();

  final theme = Provider.of<ThemeChanger>(context);
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: ArticlePage(article: article),
          ),
        );
      },
      child: Container(
        height: 500,
        width: 200, // Adjust the width as needed
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              theme.themeMode == ThemeMode.light ? Colors.white : Colors.grey,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: article.urlToImage.isNotEmpty
                      ? NetworkImage(article.urlToImage)
                      : AssetImage('assets/images/nocontent.jpg')
                          as ImageProvider,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                article.source.name,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              article.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Color.fromARGB(221, 32, 32, 32),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
