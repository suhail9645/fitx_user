import 'package:flutter/material.dart';

class ExplreScreen extends StatelessWidget {
  const ExplreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
          child: Center(
        child: Text('ExplreScreen'),
      )),
    );
  }
}
