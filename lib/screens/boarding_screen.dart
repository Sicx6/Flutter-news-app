import 'package:flutter/material.dart';
import 'package:flutter_news_/const/app_assets.dart';
import 'package:flutter_news_/screens/homepage.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({Key? key}) : super(key: key);

  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
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
