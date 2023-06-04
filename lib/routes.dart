import 'package:flutter/material.dart';
import 'package:flutter_news_/screens/countryNews.dart';
import 'package:flutter_news_/screens/home.dart';
import 'package:flutter_news_/screens/homepage.dart';
import 'package:flutter_news_/screens/login_screen.dart';
import 'package:flutter_news_/screens/signin_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignUpPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SignUpPage(),
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => LoginScreen(),
      );
    case MyHomePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MyHomePage(),
      );
    case CountryNews.routeName:
      var country = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CountryNews(
                country: country,
              ));
    case Home.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const Home());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Screen not available'),
                ),
              ));
  }
}
