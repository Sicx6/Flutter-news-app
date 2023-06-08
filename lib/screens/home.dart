import 'package:flutter/material.dart';
import 'package:flutter_news_/Provider/theme_provider.dart';
import 'package:flutter_news_/Provider/user_provider.dart';
import 'package:flutter_news_/common/app_color.dart';
import 'package:flutter_news_/common/app_global.dart';
import 'package:flutter_news_/common/app_textstyle.dart';
import 'package:flutter_news_/components/animated_loader.dart';
import 'package:flutter_news_/components/carousel_images.dart';
import 'package:flutter_news_/components/country_category_widgets.dart';
import 'package:flutter_news_/components/country_item_widgets.dart';
import 'package:flutter_news_/components/favourite_home_widget.dart';
import 'package:flutter_news_/components/home_drawer_widget.dart';
import 'package:flutter_news_/model/article_model.dart';
import 'package:flutter_news_/screens/countryNews.dart';
import 'package:flutter_news_/screens/favourite_list_screen.dart';
import 'package:flutter_news_/screens/homepage.dart';
import 'package:flutter_news_/screens/profile_screen.dart';
import 'package:flutter_news_/screens/search_screens.dart';
import 'package:flutter_news_/services/api.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home-screen';
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _searchQuery = '';
  List<Article> wishList = [];
  Api client = Api();

  @override
  void initState() {
    super.initState();
    AppUser();
  }

  @override
  Widget build(BuildContext context) {
    void navigateFavourite() {
      Navigator.pushNamed(context, FavouritesListScreen.routeName);
    }

    void navigateCountryScreen(BuildContext context, String country) {
      Navigator.pushNamed(context, CountryNews.routeName, arguments: country);
    }

    void navigateProfileScreen(BuildContext context) {
      Navigator.pushNamed(context, ProfileScreen.routeName);
    }

    final theme = Provider.of<ThemeChanger>(context);
    final user = Provider.of<AppUser>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'MYNEWS APPS',
          style: AppTextStyle.abezee(
            fontSize: 20,
            color: theme.themeMode == ThemeMode.light
                ? Colors.black
                : Colors.white,
          ),
        ),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          );
        }),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: ArticleSearchDelegate(),
                );
              },
              child: const Icon(Icons.search),
            ),
          ),
        ],
      ),
      drawer: HomeDrawerWidget(theme: theme),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: AppTextStyle.mainText(),
                      ),
                      Text(
                        user.user?.displayName ?? 'Guest',
                        style: AppTextStyle.mainText2(),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 30,
                    child: user.user?.photoURL == null
                        ? Image.asset(
                            'assets/images/user.png',
                            fit: BoxFit.contain,
                          )
                        : ClipOval(
                            child: Image.network(
                              user.user?.photoURL as String,
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60,
                            ),
                          ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder<List<Article>>(
                future: client.getArticle(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: AnimatedLoader());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    List<Article> articles = snapshot.data!;
                    return CarouselImages(articles: articles);
                  } else {
                    return Center(child: Text('No data available'));
                  }
                },
              ),
              const SizedBox(
                height: 17,
              ),
              Text(
                'Countries',
                style: AppTextStyle.abezee(
                  color: theme.themeMode == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CountryCategoryWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Favourite',
                    style: AppTextStyle.abezee(
                      color: theme.themeMode == ThemeMode.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: navigateFavourite,
                    child: Text(
                      'See All',
                      style: AppTextStyle.seeMore(),
                    ),
                  ),
                ],
              ),
              StreamBuilder<List<Article>>(
                stream: client.getFavouriteArticleStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    List<Article> favouriteArticles = snapshot.data ?? [];
                    return Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: favouriteArticles.length > 3
                            ? 4
                            : favouriteArticles.length,
                        itemBuilder: (context, index) {
                          Article article = favouriteArticles[index];
                          return favouriteHome(
                              article: article, context: context);
                        },
                      ),
                    );
                  } else {
                    return Center(child: Text('No favourite articles'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
