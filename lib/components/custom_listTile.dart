import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_news_/screens/article_screes.dart';
import 'package:flutter_news_/services/api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../model/article_model.dart';

Widget customListTile(
    Article article, BuildContext context, List<Article> wishList) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: ArticlePage(article: article)));
    },
    child: Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
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
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: article.urlToImage.isNotEmpty
                    ? NetworkImage(article.urlToImage)
                    : const NetworkImage(''),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
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
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    article.isAddedToWishlist
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: article.isAddedToWishlist ? Colors.red : null,
                  ))
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            article.title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
          )
        ],
      ),
    ),
  );
}
