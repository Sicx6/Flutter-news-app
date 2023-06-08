import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_news_/Provider/article_provider.dart';
import 'package:flutter_news_/common/app_color.dart';
import 'package:flutter_news_/common/app_textstyle.dart';
import 'package:flutter_news_/model/article_model.dart';
import 'package:flutter_news_/services/api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key, required this.article}) : super(key: key);

  final Article article;

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse(article.url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    Api api = Api();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: Text(
          article.title,
          style: AppTextStyle.abezee(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: article.urlToImage.isNotEmpty
                      ? NetworkImage(article.urlToImage)
                      : const AssetImage('assets/images/nocontent.jpg')
                          as ImageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          article.source.name,
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // IconButton(
                      //     onPressed: () {
                      //       api.addFavoriteArticle(article);
                      //     },
                      //     icon: Icon(
                      //       Icons.favorite,
                      //       color: article.isAddedToFavourite == true
                      //           ? Colors.red
                      //           : Colors.black,
                      //     ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    article.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    article.content,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    child: Text(
                      article.url,
                      style: const TextStyle(color: Colors.blue),
                    ),
                    onTap: () async {
                      await _launchUrl();
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  AnimatedButton(
                    height: 70,
                    text: 'Add to Favourite',
                    isReverse: true,
                    selectedTextColor:
                        Colors.black, // Set the selected text color to white
                    transitionType: TransitionType.BOTTOM_CENTER_ROUNDER,
                    textStyle: AppTextStyle.abezee(),
                    backgroundColor: Colors.black,
                    borderColor: Colors.black,
                    borderRadius: 50,
                    borderWidth: 1,
                    onPress: () {
                      api.addFavoriteArticle(article);
                    },
                    isSelected: true, // Set the selected state to true
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
