import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:flutter/material.dart';
import '../../../data_layer/models/category/category_page/result.dart';
import '../../constants/sized_box.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../widget/exercise_container.dart';

class ReadyToGoScreen extends StatelessWidget {
  const ReadyToGoScreen({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;

    return Scaffold(
      body: Column(
        children: [
          ExerciseContainer(screenHeight: screenHeight, exercise: category.exercises[2]),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'READY TO GO!',
            style: TextStyle(
                color: primaryColor, fontSize: 27, fontWeight: FontWeight.bold),
          ),
          spaceforHeight20,
          Text(
            category.exercises[2].name!,
            style: const TextStyle(fontSize: 21),
          ),
          spaceforHeight20,
          spaceforHeight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                // rotateLinearGradient: true,
                animation: true,
                animationDuration: 10000,
                linearGradient: const LinearGradient(colors: [
                  Color.fromARGB(255, 237, 41, 27),
                  Color.fromARGB(255, 232, 211, 22),
                ]),
                radius: 60.0,
                lineWidth: 7.0,
                percent: 1.0,
                center: TweenAnimationBuilder<Duration>(
                    duration: const Duration(seconds: 10),
                    tween: Tween(
                        begin: const Duration(seconds: 11),
                        end: const Duration(seconds: 1)),
                    onEnd: () {
                      Navigator.pushReplacementNamed(context, 'ExercisePlay',arguments: category.exercises[2]);
                    },
                    builder:
                        (BuildContext context, Duration value, Widget? child) {
                      // final minutes = value.inMinutes;
                      final seconds = value.inSeconds;
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(seconds.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35)));
                    }),

                backgroundColor: const Color.fromARGB(255, 180, 178, 178),
              ),
              const SizedBox(
                width: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'ExercisePlay',arguments: category);
                },
                child: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 40,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

