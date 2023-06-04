import 'package:flutter/material.dart';
import 'package:flutter_news_/common/app_global.dart';
import 'package:flutter_news_/components/country_item_widgets.dart';
import 'package:flutter_news_/screens/countryNews.dart';

class CountryCategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void navigateCountryScreen(BuildContext context, String country) {
      Navigator.pushNamed(context, CountryNews.routeName, arguments: country);
    }

    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppGlobal.countries.length,
        itemBuilder: (context, index) {
          final country = AppGlobal.countries[index];
          return GestureDetector(
            onTap: () => navigateCountryScreen(context, country),
            child: CountryItemWidget(country: country),
          );
        },
      ),
    );
  }
}
