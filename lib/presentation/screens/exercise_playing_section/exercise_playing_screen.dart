import 'package:fitx_user/data_layer/models/category/category_page/result.dart';
import 'package:fitx_user/data_layer/models/exercise_page/result.dart';
import 'package:fitx_user/logic/category_bloc/category_bloc.dart';
import 'package:fitx_user/logic/timer_cubit/timer_cubit.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/screens/rest_section/rest_screen.dart';
import 'package:fitx_user/presentation/widget/exercise_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../logic/report_bloc/report_bloc.dart';

class ExercisePlayingScreen extends StatelessWidget {
  const ExercisePlayingScreen(
      {super.key, required this.category, required this.index});
  final Category category;
  final int index;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    Exercise exercise = category.exercises[index];
    const textStyle = TextStyle(fontSize: 22, color: Colors.white);
    CountdownController _controller = CountdownController(autoStart: true);
    return Scaffold(
      body: Column(
        children: [
          ExerciseContainer(
            screenHeight: screenHeight,
            exercise: exercise,
            music: category.music!,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  exercise.name!,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
                exercise.count != null
                    ? Text(
                        'X${exercise.count}',
                        style: const TextStyle(
                            fontSize: 42,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      )
                    : Countdown(
                        interval: const Duration(seconds: 1),
                        controller: _controller,
                        seconds: 25,
                        build: (p0, p1) {
                          return Text(
                            '00:${p1.toString().split('.').first}',
                            style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          );
                        },
                        onFinished: () {
                          onCompletedExercise(context, exercise);
                        },
                      ),
                BlocBuilder<WaitPageTimerCubit, bool>(
                  builder: (context, state) {
                    return Container(
                      height: 45.0,
                      width: screenHeight / 4,
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
                          onPressed: () {
                            if (exercise.count != null) {
                              onCompletedExercise(context, exercise);
                            } else {
                              BlocProvider.of<WaitPageTimerCubit>(context)
                                  .onResumeAndPause(!state);
                              state
                                  ? _controller.pause()
                                  : _controller.resume();
                            }
                          },
                          icon: Text(
                            exercise.count != null
                                ? 'DONE'
                                : state
                                    ? 'PAUSE'
                                    : 'RESUME',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                          label: const SizedBox()),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'QUIT',
                        style: textStyle,
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 30,
                      color: primaryColor,
                    ),
                    TextButton.icon(
                      onPressed: () {
                        if (index < (category.exercisesCount! - 1)) {
                          onCompletedExercise(context, exercise);
                        }
                      },
                      icon: Text(
                        'NEXT',
                        style: index < (category.exercisesCount! - 1)
                            ? textStyle
                            : const TextStyle(
                                color: Color.fromARGB(255, 63, 62, 62),
                                fontSize: 22),
                      ),
                      label: Icon(Icons.arrow_forward_ios,
                          color: index < (category.exercisesCount! - 1)
                              ? Colors.white
                              : const Color.fromARGB(255, 63, 62, 62)),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void onCompletedExercise(BuildContext context, Exercise exercise) {
    if (index < (category.exercisesCount! - 1)) {
      Navigator.pushReplacementNamed(context, 'Rest',
          arguments: RestScreen(category: category, index: index + 1));
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'CONGRATES!',
          ),
          content: Text('You Successfully completed ${category.name}'),
          actions: [
            ElevatedButton(
              onPressed: () {
                int count = 0;
                Navigator.popUntil(context, (route) {
                  return count++ == 3;
                });
              },
              child: const Text('DONE'),
            )
          ],
        ),
      );
      BlocProvider.of<ReportBloc>(context).add(ReportInitialEvent());
    }
    BlocProvider.of<CategoryBloc>(context).add(ExercisCompletedEvent(
        categoryId: category.id!, exerciseId: exercise.id!));
  }
}
