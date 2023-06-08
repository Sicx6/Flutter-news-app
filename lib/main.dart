import 'package:flutter/material.dart';
import 'package:flutter_news_/Provider/article_provider.dart';
import 'package:flutter_news_/Provider/theme_provider.dart';
import 'package:flutter_news_/Provider/user_provider.dart';
import 'package:flutter_news_/const/app_assets.dart';
import 'package:flutter_news_/resources/firebase_listener.dart';
import 'package:flutter_news_/routes.dart';
import 'package:flutter_news_/screens/boarding_screen.dart';
import 'package:flutter_news_/screens/home.dart';
import 'package:flutter_news_/screens/homepage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseAppCheck.instance.activate(
  //   webRecaptchaSiteKey: 'your_recaptcha_site_key',
  //   androidProvider: AndroidProvider.debug,
  // );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeChanger>(
          create: (_) => ThemeChanger(),
        ),
        ChangeNotifierProvider<AppUser>(
          create: (_) => AppUser(),
        ),
        ChangeNotifierProvider<ArticleProvider>(
            create: (_) => ArticleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static final messangerKey = GlobalKey<ScaffoldMessengerState>();
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeChanger>(context);

    return Builder(builder: (context) {
      return MaterialApp(
        title: 'MyNews App',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: theme.themeMode,
        onGenerateRoute: (settings) => generateRoute(settings),
        home: const GetListener(),
      );
    });
  }
}
