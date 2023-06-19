import 'package:fitx_user/presentation/constants/lists.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/screens/login_and_register/widget/register_page.dart';
import 'package:flutter/material.dart';

import '../../../widget/elevated_button_without_icon.dart';

class WelcomeOneAndTwo extends StatelessWidget {
  const WelcomeOneAndTwo({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                  width: double.infinity,
                  height: screenHeight / 1.7,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(welcomeImages[index]),
                          fit: BoxFit.cover)),
                  child: index != 2
                      ? Align(
                          alignment: const Alignment(0.7, -0.8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed('signInAndSignUp');
                            },
                            child: const Text(
                              'Skip',
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : const SizedBox()),
              Padding(
                padding: EdgeInsets.only(top: screenWidth / 1.85),
                child: CustomPaint(
                  size: Size(double.maxFinite, screenHeight / 3),
                  painter: RPSCustomPainter(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight / 10,
          ),
          Text(
            welcomeTexts[index],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          spaceforHeight20,
          index == 2
              ? ElevatedButtonWithIcon(
                  text: 'Start now',
                  onClicked: () {
                  Navigator.of(context).pushNamed('signInAndSignUp');
                  },
                )
              : const SizedBox()
        ],
      ),
    );
  }
}


class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 27, 25, 25)
      ..style = PaintingStyle.fill;

    Path path0 = Path();
    path0.moveTo(size.width, size.height * 0.9984125);
    path0.lineTo(size.width * 0.0057143, size.height * 0.9983042);
    path0.lineTo(size.width, size.height * 0.5415755);
    path0.lineTo(size.width, size.height * 0.9984125);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
