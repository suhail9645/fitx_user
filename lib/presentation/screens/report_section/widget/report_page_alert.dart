import 'package:flutter/material.dart';

import '../../../constants/lists.dart';
import '../../../constants/sized_box.dart';
import '../../../widget/text_form_field.dart';

class ReportPageAlert extends StatelessWidget {
  const ReportPageAlert({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(1.0),
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: List.generate(
                  3,
                  (index) => CustomTextFormField(
                      controller: goalControllers[index],
                      hint: goalHints[index]),
                ),
              ),
              Container(
                width: screenHeight * 0.30,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 214, 219, 66),
                      Color.fromARGB(255, 210, 172, 4)
                    ])),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                  onPressed: () {},
                  child: const Text(
                    'Done',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              spaceforHeight10,
              InkWell(
                onTap: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              spaceforHeight20
            ],
          ),
        ),
      ),
    );
  }
}
