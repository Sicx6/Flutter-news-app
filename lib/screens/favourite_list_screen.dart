import 'package:flutter/material.dart';
import 'package:flutter_news_/Provider/article_provider.dart';
import 'package:flutter_news_/Provider/theme_provider.dart';
import 'package:flutter_news_/common/app_textstyle.dart';
import 'package:flutter_news_/components/animated_loader.dart';
import 'package:flutter_news_/model/article_model.dart';
import 'package:flutter_news_/screens/article_screes.dart';
import 'package:flutter_news_/services/api.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouritesListScreen extends StatelessWidget {
  static const String routeName = '/favourite-list-screen';

  @override
  Widget build(BuildContext context) {
    final api = Api();

    var theme = Provider.of<ThemeChanger>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Favourite',
          style: AppTextStyle.abezee(),
        ),
      ),
      body: StreamBuilder<List<Article>>(
        stream: api.getFavouriteArticleStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: AnimatedLoader());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Article> favouriteArticles = snapshot.data ?? [];
            return ListView.builder(
              itemCount: favouriteArticles.length,
              itemBuilder: (context, index) {
                Article article = favouriteArticles[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: ArticlePage(article: article),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.themeMode == ThemeMode.light
                          ? Colors.white
                          : Colors.grey,
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
                                  : AssetImage('assets/images/nocontent.jpg')
                                      as ImageProvider,
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                api.removeFavoriteArticle(article);
                              },
                              icon: Icon(
                                article.isAddedToFavourite
                                    ? Icons.remove_circle
                                    : Icons.remove_circle,
                                color: article.isAddedToFavourite
                                    ? Colors.red
                                    : null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          article.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: Color.fromARGB(221, 32, 32, 32),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
