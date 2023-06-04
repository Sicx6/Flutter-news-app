import 'package:flutter/material.dart';
import 'package:flutter_news_/Provider/user_provider.dart';
import 'package:flutter_news_/screens/boarding_screen.dart';
import 'package:flutter_news_/screens/home.dart';
import 'package:provider/provider.dart';

class GetListener extends StatelessWidget {
  const GetListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser?>(context);

    if (appUser != null && appUser.user != null && !appUser.user!.isAnonymous) {
      print('logged in');
      return const Home();
    } else {
      print('not logged in');
      return const BoardingScreen();
    }
  }
}
