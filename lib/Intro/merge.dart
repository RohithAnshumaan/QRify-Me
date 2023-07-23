import 'package:flutter/material.dart';
import 'package:qrify_me/Intro/fifth.dart';
import 'package:qrify_me/Intro/first.dart';
import 'package:qrify_me/Intro/fourth.dart';
import 'package:qrify_me/Intro/second.dart';
import 'package:qrify_me/Intro/sixth.dart';
import 'package:qrify_me/Intro/third.dart';
import 'package:qrify_me/default/navigation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppIntro extends StatefulWidget {
  const AppIntro({super.key});

  @override
  State<AppIntro> createState() => _AppIntroState();
}

class _AppIntroState extends State<AppIntro> {
  final PageController _controller = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(
                () {
                  isLastPage = (index == 5);
                },
              );
            },
            children: const [
              FirstPage(),
              SecondPage(),
              ThirdPage(),
              FourthPage(),
              FifthPage(),
              SixthPage(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(5);
                  },
                  child: const Text('skip'),
                ),
                SmoothPageIndicator(controller: _controller, count: 6),
                isLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const HomeView();
                              },
                            ),
                          );
                        },
                        child: const Text('done'),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: const Text('next'),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
