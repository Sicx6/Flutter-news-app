import 'package:flutter/material.dart';
import 'package:flutter_news_/screens/boarding_screen.dart';

class AppAssets {
  static List<Widget> pages = [
    const BoardingPage(
      image: 'assets/images/onboarding1.png',
      title: 'Welcome to MyNews App',
      description: 'Get the latest news at your fingertips!',
    ),
    const BoardingPage(
      image: 'assets/images/onboarding2.png',
      title: 'Explore Different Categories',
      description:
          'Discover news in various categories such as technology, sports, and more.',
    ),
    const BoardingPage(
      image: 'assets/images/onboarding3.png',
      title: 'Save Your Favorite Articles',
      description:
          'Bookmark articles to read them later and create your personalized reading list.',
    ),
  ];


}
