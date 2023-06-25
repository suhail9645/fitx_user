import 'package:flutter/material.dart';

class ElevatedButtonWithIcon extends StatelessWidget {
  const ElevatedButtonWithIcon({
    super.key,
    required this.text,
    required this.onClicked,
    this.width,
  });
  final String text;
  final Function() onClicked;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(colors: [
            Color.fromARGB(255, 214, 219, 66),
            Color.fromARGB(255, 210, 172, 4)
          ])),
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent),
          onPressed: onClicked,
          icon: Text(
            text,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          label: const Icon(Icons.arrow_right, color: Colors.black)),
    );
  }
}
