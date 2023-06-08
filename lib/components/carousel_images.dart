import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_news_/common/app_color.dart';
import 'package:flutter_news_/model/article_model.dart';
import 'package:flutter_news_/screens/article_screes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_fonts/google_fonts.dart';

class CarouselImages extends StatelessWidget {
  final List<Article> articles;

  const CarouselImages({required this.articles, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: articles.length > 5 ? 5 : articles.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        final Article article = articles[itemIndex];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: ArticlePage(article: article),
              ),
            );
            print('$article');
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: article.urlToImage.isNotEmpty
                    ? Image.network(
                        article.urlToImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Image.asset(
                        'assets/images/nocontent.jpg',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              Positioned(
                top: 140,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.lightPurple,
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            AppColor.lightPurple.withOpacity(0.9),
                            Colors.white.withOpacity(0.5),
                          ])),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Author: ${article.author}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Published At: ${article.publishedAt}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        animateToClosest: true,
        viewportFraction: 1,
      ),
    );
  }
}
