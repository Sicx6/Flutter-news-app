import 'package:flutter/material.dart';
import 'package:flutter_news_/main.dart';

void CustomSnackBar(BuildContext context, String text) {
  ScaffoldMessengerState? scaffold = MyApp.messangerKey.currentState;
  scaffold?.showSnackBar(SnackBar(content: Text(text)));
}
