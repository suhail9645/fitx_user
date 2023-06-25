import 'package:flutter/material.dart';

class ReportRowWidget extends StatelessWidget {
  const ReportRowWidget({
    super.key,
    required this.text,
    required this.buttonText,
    required this.onClicked,
  });
  final String text;
  final String buttonText;
  final Function() onClicked;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 19),
        ),
        Container(
          height: 36,
          width: 90,
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
            onPressed: onClicked,
            child: Text(
              buttonText,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
