import 'package:flutter/material.dart';
import 'package:flutter_news_/Provider/theme_provider.dart';
import 'package:flutter_news_/common/app_color.dart';
import 'package:flutter_news_/const/app_assets.dart';
import 'package:flutter_news_/screens/homepage.dart';
import 'package:flutter_news_/screens/signin_screen.dart';
import 'package:provider/provider.dart';

class BoardingScreen extends StatefulWidget {
  static const String routeName = '/boarding-screen';
  const BoardingScreen({Key? key}) : super(key: key);

  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeChanger>(context);
    return Scaffold(
      backgroundColor: AppColor.lightPurple,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: AppAssets.pages,
                ),
              ),
              _buildIndicators(),
              const SizedBox(height: 16),
              _buildBottomButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(AppAssets.pages.length, (int index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _currentPage == index ? 12 : 6,
          height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Colors.blue : Colors.grey,
          ),
        );
      }),
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentPage != 0)
            TextButton(
              onPressed: () {
                _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              },
              child: const Text('PREVIOUS'),
            ),
          if (_currentPage != AppAssets.pages.length - 1)
            TextButton(
              onPressed: () {
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              },
              child: const Text('NEXT'),
            ),
          if (_currentPage == AppAssets.pages.length - 1)
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: const Text('GET STARTED'),
            ),
        ],
      ),
    );
  }
}

class BoardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const BoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 200),
          const SizedBox(height: 32),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

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
