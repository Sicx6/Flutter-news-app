import 'package:flutter/material.dart';
import 'package:flutter_news_/components/custom_listTile.dart';
import 'package:flutter_news_/model/article_model.dart';
import 'package:flutter_news_/services/api.dart';

class ArticleSearchDelegate extends SearchDelegate<String> {
  final List<Article> wishlist;

  ArticleSearchDelegate(this.wishlist);
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Api client = Api();

    return FutureBuilder(
      future: client.searchArticles(query),
      builder: (context, AsyncSnapshot<List<Article>> snapshot) {
        if (snapshot.hasData) {
          List<Article> searchResults = snapshot.data!;
          return ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              return customListTile(searchResults[index], context, wishlist);
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Generate search suggestions based on the query
    List<String> suggestions = [
      'Technology',
      'Sports',
      'Politics',
    ];

    suggestions = suggestions.where((suggestion) {
      return suggestion.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}
