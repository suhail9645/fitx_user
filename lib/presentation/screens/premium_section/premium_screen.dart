import 'dart:async';

import 'package:fitx_user/logic/premium_cubit/premium_cubit.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/widget/elevated_button_without_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data_layer/models/user/user.dart';
import '../../widget/rps_painter.dart';
StreamController streamController = StreamController.broadcast();
class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: screenHeight * 0.55,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: 0.5,
                    image: AssetImage('assets/premium.webp'),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.10),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Be Premium',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Get Unlimited access',
                          style: TextStyle(fontSize: 19, wordSpacing: 1),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                        'Once you paid, you wiil get\n life time unlimited access')
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight / 4.59),
              child: CustomPaint(
                size: Size(double.maxFinite, screenHeight / 3),
                painter: RPSCustomPainter(),
              ),
            ),
          ],
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: screenHeight * 0.09,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 59, 58, 58),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  horizontalTitleGap: 5,
                  leading: Radio(
                    value: '',
                    groupValue: '',
                    onChanged: (value) {},
                  ),
                  title: const Text(
                    'Life Time',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    'Get Unimited Access',
                    style: TextStyle(fontSize: 13, color: primaryColor),
                  ),
                  trailing: const Text(
                    '₹ 100.00',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              spaceforHeight20,
              BlocConsumer<PremiumCubit, PremiumState>(
                listener: (context, state) {
                 if(state is PremiumSuccessState){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('SuccessFull')));
                 }
               else   if(state is PremiumErrorState){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error')));
                 }
                },
                builder: (context, state) {
                  return ElevatedButtonWithIcon(
                    width: screenWidth * 0.80,
                    text: 'Subscibe Now',
                    onClicked: () {
                      BlocProvider.of<PremiumCubit>(context).subscribeEvent(user);
                    },
                  );
                },
              )
            ],
          ),
        )
      ],
    ));
  }
}
