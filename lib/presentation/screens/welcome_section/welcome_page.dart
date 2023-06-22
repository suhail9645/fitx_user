import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/screens/welcome_section/widget/welcome_one_and_two.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 27, 25, 25),
        body: Stack(
          children: [
            PageView(
                controller: pageController,
                children: List.generate(
                    3, (index) => WelcomeOneAndTwo(index: index))),
            Align(
              alignment: const Alignment(0, 0.8),
              child: SmoothPageIndicator(
                controller: pageController, // PageController
                count: 3,
                effect: const WormEffect(
                    activeDotColor: primaryColor,
                    radius: 20,
                    dotHeight: 4,
                    dotWidth: 20,
                    dotColor: Color.fromARGB(
                        255, 63, 63, 58)), // your preferred effect
              ),
            )
          ],
        ));
  }
}
