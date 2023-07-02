import 'package:fitx_user/data_layer/models/exercise_page/result.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:flutter/material.dart';

import '../constants/sized_box.dart';

class ExerciseContainer extends StatelessWidget {
  const ExerciseContainer(
      {super.key,
      required this.screenHeight,
      required this.exercise,
      required this.music});

  final double screenHeight;
  final Exercise exercise;
  final String music;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 2.1,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: NetworkImage(exercise.demo!), fit: BoxFit.fill),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () async {},
                    icon: const Icon(
                      Icons.play_arrow,
                      color: primaryColor,
                      size: 35,
                    ))
              ],
            ),
            spaceforHeight20
          ],
        ),
      ),
    );
  }
}
