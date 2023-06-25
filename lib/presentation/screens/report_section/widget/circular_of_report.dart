import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircularOfReport extends StatelessWidget {
  const CircularOfReport({
    super.key,
    required this.title,
    required this.contant,
    required this.percentage,
  });
  final String title;
  final String contant;
  final double percentage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: CircularPercentIndicator(
        // rotateLinearGradient: true,
        backgroundWidth: 3,
        animation: true,
        animationDuration: 800,
        linearGradient: const LinearGradient(colors: [
          Color.fromARGB(255, 232, 211, 22),
          Color.fromARGB(255, 237, 41, 27),
        ]),
        radius: 36.0,
        lineWidth: 4.0,
        percent: percentage,
        center: TweenAnimationBuilder<Duration>(
            duration: const Duration(seconds: 1),
            tween: Tween(
                begin: const Duration(seconds: 0),
                end: const Duration(seconds: 25)),
            onEnd: () {
              // Navigator.pushReplacementNamed(context, 'ExercisePlay',
              //     arguments: ExercisePlayingScreen(
              //         category: category, index: 0));
            },
            builder: (BuildContext context, Duration value, Widget? child) {
              const textStyle = TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(contant, textAlign: TextAlign.center, style: textStyle),
                  Text(title,
                      style: const TextStyle(
                          fontSize: 11,
                          color: Color.fromARGB(255, 193, 191, 191)))
                ],
              );
            }),

        backgroundColor: const Color.fromARGB(255, 51, 49, 49),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
