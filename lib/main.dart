import 'package:flutter/material.dart';
import 'package:flutter_news_/screens/boarding_screen.dart';
import 'package:flutter_news_/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyNews Apps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
      ),
      home: const BoardingScreen(),
    );
  }
}
