import 'package:flutter/material.dart';

import '../../../../data_layer/models/user_report/user_report.dart';
import '../../../constants/colors.dart';
import '../../../constants/lists.dart';

class TotalCompletedContainer extends StatelessWidget {
  const TotalCompletedContainer({
    super.key,
    required this.screenHeight,required this.userReport
  });

  final double screenHeight;
  final UserReport userReport;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 10,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 81, 79, 79),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(3, (index) {
            List<int> num = [
              userReport.allCompletedExercise,
              userReport.allCompletedCalorie,
              userReport.allCompletedCategory
            ];
            return Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  num[index].toString(),
                  style: const TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  names[index],
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
