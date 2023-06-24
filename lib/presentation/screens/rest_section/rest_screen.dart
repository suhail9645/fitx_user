import 'package:fitx_user/data_layer/models/exercise_page/result.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:flutter/material.dart';

class RestScreen extends StatelessWidget {
  final Exercise exercise;
  const RestScreen({super.key, required this.exercise});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color.fromARGB(255, 244, 244, 108),
            primaryColor,
            Color.fromARGB(255, 188, 188, 4),
          ])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Container(
                height: screenHeight / 1.8,
                // color: Colors.blue,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    spaceforHeight10,
                    const Text(
                      'REST',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    TweenAnimationBuilder<Duration>(
                        duration: const Duration(seconds: 20),
                        tween: Tween(
                            begin: const Duration(seconds: 20),
                            end: const Duration(seconds: 01)),
                        onEnd: () {
                          // Navigator.pushReplacementNamed(context, 'ExercisePlay',arguments: category.exercises[2]);
                        },
                        builder: (BuildContext context, Duration value,
                            Widget? child) {
                          final minutes = value.inMinutes;
                          final seconds = value.inSeconds;

                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text('$minutes:$seconds',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 50)));
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RestButtons(
                          title: 'PAUSE',
                          onTap: () {},
                        ),
                        RestButtons(
                          title: 'SKIP',
                          onTap: () {},
                        ),
                      ],
                    ),
                    Container(
                      height: screenHeight / 9,
                      width: double.infinity,
                      // color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'NEXT 2/12',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  exercise.name!,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                                Text('X${exercise.count}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                decoration:  BoxDecoration(
                    // color: Color.fromARGB(255, 27, 25, 25),
                    borderRadius:const BorderRadiusDirectional.only(
                      topStart: Radius.circular(25),
                      topEnd: Radius.circular(25),
                    ),image: DecorationImage(image: NetworkImage(exercise.demo!),fit: BoxFit.fill)),
              ))
            ],
          )),
    );
  }
}

class RestButtons extends StatelessWidget {
  const RestButtons({super.key, required this.title, required this.onTap});
  final String title;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 130,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor:title=='SKIP'? Colors.black:Colors.grey,
            ),
        onPressed: onTap,
        child: Text(
          title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
