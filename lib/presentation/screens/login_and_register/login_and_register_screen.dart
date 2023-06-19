import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/screens/login_and_register/widget/login_page.dart';
import 'package:fitx_user/presentation/screens/login_and_register/widget/register_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LoginAndRegister extends StatelessWidget {
  const LoginAndRegister({super.key});
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
    final PageController pageController = PageController();
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: pageController,
          children: [LoginScreen(), RegisterScreen()],
        ),
        Align(
          alignment: const Alignment(-0.8, -0.86),
          child: SizedBox(
            width: 150,
            height: 50,
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Login',
                      style: textStyle,
                    ),
                    Text(
                      'Signup',
                      style: textStyle,
                    )
                  ],
                ),
                SmoothPageIndicator(
                  controller: pageController, // PageController
                  count: 2,
                  effect: const WormEffect(
                      spacing: 30,
                      activeDotColor: primaryColor,
                      radius: 10,
                      dotHeight: 3,
                      dotWidth: 45,
                      dotColor: Colors.transparent),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
