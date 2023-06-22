import 'package:flutter/material.dart';

class TrainerScreen extends StatelessWidget {
  const TrainerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
          child: Center(
        child: Text('TrainerScreen'),
      )),
    );
  }
}
