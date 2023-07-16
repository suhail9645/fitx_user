import 'package:flutter/material.dart';

import '../../../../data_layer/models/user_report/user_report.dart';
import '../../../constants/lists.dart';
import 'circular_of_report.dart';

class GoalPercentage extends StatelessWidget {
  const GoalPercentage(
      {super.key, required this.screenHeight, required this.userReport});

  final double screenHeight;
  final UserReport userReport;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 7.50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(3, (index) {
              List<String> num = [
                '${userReport.thisweekCompletedExercise.toString()}/${userReport.exerciseGoal.toString()}',
                '${userReport.thisweekCompletedCalorie.toString()}/${userReport.calorieGoal.toString()}',
                '${userReport.thisweekCompletedCategory.toString()}/${userReport.categoryGoal.toString()}'
              ];
              List<double> percentage = [
                userReport.thisweekCompletedExercise / userReport.exerciseGoal,
                userReport.thisweekCompletedCalorie / userReport.calorieGoal,
                userReport.thisweekCompletedCategory / userReport.categoryGoal
              ];
              return CircularOfReport(
                title: names[index],
                contant: num[index],
                percentage: percentage[index] <= 1 ? percentage[index] : 1,
              );
            })),
      ),
    );
  }
}
