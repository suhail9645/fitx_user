import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/widget/elevated_button_without_icon.dart';
import 'package:flutter/material.dart';

import '../trainer_add_section/trainer_add_screen.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: screenHeight * 0.55,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: 0.5,
                    image: AssetImage('assets/premium.webp'),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.10),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Be Premium',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Get Unlimited access',
                          style: TextStyle(fontSize: 19, wordSpacing: 1),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                        'Once you paid, you wiil get\n life time unlimited access')
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight / 4.59),
              child: CustomPaint(
                size: Size(double.maxFinite, screenHeight / 3),
                painter: RPSCustomPainter(),
              ),
            ),
          ],
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: screenHeight * 0.09,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 59, 58, 58),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  horizontalTitleGap: 5,
                  leading: Radio(
                    value: '',
                    groupValue: '',
                    onChanged: (value) {},
                  ),
                  title: const Text(
                    'Life Time',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    'Get Unimited Access',
                    style: TextStyle(fontSize: 13, color: primaryColor),
                  ),
                  trailing: const Text(
                    '₹ 10.00',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              spaceforHeight20,
              ElevatedButtonWithIcon(
                width: screenWidth * 0.80,
                text: 'Subscibe Now',
                onClicked: () {},
              )
            ],
          ),
        )
      ],
    ));
  }
}
