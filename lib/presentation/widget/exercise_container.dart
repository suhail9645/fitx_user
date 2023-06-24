import 'package:fitx_user/data_layer/models/exercise_page/result.dart';
import 'package:flutter/material.dart';

import '../constants/sized_box.dart';

class ExerciseContainer extends StatelessWidget {
  const ExerciseContainer({
    super.key,
    required this.screenHeight,
    required this.exercise,
  });

  final double screenHeight;
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 2.1,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(exercise.demo!),
            fit: BoxFit.fill),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            spaceforHeight20
          ],
        ),
      ),
    );
  }
}
