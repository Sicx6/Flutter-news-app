import 'package:flutter/material.dart';
import 'package:flutter_news_/Provider/theme_provider.dart';
import 'package:flutter_news_/common/app_color.dart';
import 'package:provider/provider.dart';

class CountryItemWidget extends StatelessWidget {
  final String country;

  const CountryItemWidget({
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    final themer = Provider.of<ThemeChanger>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.lightPurple,
            ),
            child: Center(
              child: Text(
                country.toUpperCase(),
                style: TextStyle(
                    fontSize: 20,
                    color: themer.themeMode == ThemeMode.light
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(country),
        ],
      ),
    );
  }
}
