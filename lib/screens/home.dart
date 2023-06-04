import 'package:flutter/material.dart';
import 'package:flutter_news_/Provider/theme_provider.dart';
import 'package:flutter_news_/Provider/user_provider.dart';
import 'package:flutter_news_/common/app_color.dart';
import 'package:flutter_news_/common/app_global.dart';
import 'package:flutter_news_/common/app_textstyle.dart';
import 'package:flutter_news_/components/carousel_images.dart';
import 'package:flutter_news_/components/country_category_widgets.dart';
import 'package:flutter_news_/components/country_item_widgets.dart';
import 'package:flutter_news_/model/article_model.dart';
import 'package:flutter_news_/screens/countryNews.dart';
import 'package:flutter_news_/screens/homepage.dart';
import 'package:flutter_news_/screens/search_screens.dart';
import 'package:flutter_news_/services/api.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home-screen';
  const Home({super.key});

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
    void navigateHighligt() {
      Navigator.pushNamed(context, MyHomePage.routeName);
    }

    void navigateCountryScreen(BuildContext context, String country) {
      Navigator.pushNamed(context, CountryNews.routeName, arguments: country);
    }

    final theme = Provider.of<ThemeChanger>(context);
    final user = Provider.of<AppUser>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'MYNEWS APPS',
          style: GoogleFonts.getFont('Lato'),
        ),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu));
        }),
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
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColor.lightPurple,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 30,
                      child: Image.asset(
                        'assets/images/user.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Welcome the My News Apps'),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Provider.of<ThemeChanger>(context, listen: false)
                              .toggleTheme();
                        },
                        icon: Icon(theme.themeMode == ThemeMode.light
                            ? Icons.dark_mode
                            : Icons.light_mode),
                      ),
                      Text('NightMode'),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          AppUser().logOut();
                        },
                        icon: const Icon(Icons.exit_to_app),
                      ),
                      Text('Log Out'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
              const SizedBox(
                height: 30,
              ),
              FutureBuilder<List<Article>>(
                future: client.getArticle(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
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
                style: AppTextStyle.abezee(),
              ),
              const SizedBox(
                height: 15,
              ),
              CountryCategoryWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Highlight News',
                    style: AppTextStyle.abezee(),
                  ),
                  GestureDetector(
                    onTap: navigateHighligt,
                    child: Text(
                      'See All',
                      style: AppTextStyle.seeMore(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
