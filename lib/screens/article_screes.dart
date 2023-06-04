import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key, required this.article}) : super(key: key);

  final Article article;

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse(article.url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: article.urlToImage.isNotEmpty
                        ? NetworkImage(article.urlToImage)
                        : const AssetImage('assets/images/nocontent.jpg')
                            as ImageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  article.source.name,
                  style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                article.title,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                article.content,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
              ),
              const SizedBox(
                height: 8,
              ),
              InkWell(
                child: Text(
                  article.url,
                  style: const TextStyle(color: Colors.blue),
                ),
                onTap: () async {
                   await _launchUrl();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
