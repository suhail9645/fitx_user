import 'package:flutter/material.dart';

class LoadingElevatedButtton extends StatelessWidget {
  const LoadingElevatedButtton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
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
        onPressed: () {},
        icon: const Text(
          'Wait',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        label: const SizedBox(
            height: 17,
            width: 17,
            child: CircularProgressIndicator(
              color: Colors.black,
              strokeWidth: 2,
            )),
      ),
    );
  }
}
