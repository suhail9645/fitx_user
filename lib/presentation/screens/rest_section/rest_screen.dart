import 'package:fitx_user/data_layer/models/category/category_page/result.dart';
import 'package:fitx_user/data_layer/models/exercise_page/result.dart';
import 'package:fitx_user/logic/timer_cubit/timer_cubit.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/screens/exercise_playing_section/exercise_playing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class RestScreen extends StatelessWidget {
  final Category category;
  final int index;
  RestScreen({super.key, required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    final CountdownController _controller =
        CountdownController(autoStart: true);
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    Exercise exercise = category.exercises[index];
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
              SizedBox(
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
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    Countdown(
                      interval: const Duration(milliseconds: 100),
                      controller: _controller,
                      seconds: 9,
                      build: (p0, p1) {
                        return Text(
                          '0${p1.toString().split('.').first}',
                          style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        );
                      },
                      onFinished: () {
                        Navigator.pushReplacementNamed(context, 'ExercisePlay',
                            arguments: ExercisePlayingScreen(
                                category: category, index: index));
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BlocBuilder<WaitPageTimerCubit, bool>(
                          builder: (context, state) {
                            return RestButtons(
                              title: state ? 'PAUSE' : 'RESUME',
                              onTap: () {
                                BlocProvider.of<WaitPageTimerCubit>(context)
                                    .onResumeAndPause(!state);
                                state
                                    ? _controller.pause()
                                    : _controller.resume();
                              },
                            );
                          },
                        ),
                        RestButtons(
                          title: 'SKIP',
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, 'ExercisePlay',
                                arguments: ExercisePlayingScreen(
                                    category: category, index: index));
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight / 9,
                      width: double.infinity,
                      // color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'NEXT ${index + 1}/${category.exercisesCount}',
                              style: const TextStyle(
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
                decoration: BoxDecoration(
                    // color: Color.fromARGB(255, 27, 25, 25),
                    borderRadius: const BorderRadiusDirectional.only(
                      topStart: Radius.circular(25),
                      topEnd: Radius.circular(25),
                    ),
                    image: DecorationImage(
                        image: NetworkImage(exercise.demo!), fit: BoxFit.fill)),
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
          backgroundColor: title == 'SKIP' ? Colors.black : Colors.grey,
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
