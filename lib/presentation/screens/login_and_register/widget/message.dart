import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class LoginAndRegisterMessage extends StatelessWidget {
  const LoginAndRegisterMessage({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.3),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SizedBox(
          height: screenHeight / 7,
          child: const Column(
            children: [
              Row(
                children: [
                  Text(
                    'HELLO ROCKIES',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Lets Dive In !!',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
