import 'package:fitx_user/data_layer/models/exercise_page/result.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/widget/exercise_container.dart';
import 'package:flutter/material.dart';

class ExercisePlayingScreen extends StatelessWidget {
  const ExercisePlayingScreen({super.key,required this.exercise});
  final Exercise exercise;
  @override
  Widget build(BuildContext context) {
     Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;

    const textStyle = TextStyle(fontSize: 22,color: Colors.white);
    return Scaffold(
      body: Column(children: [
        ExerciseContainer(screenHeight: screenHeight, exercise: exercise),
        
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(exercise.name!,style:const TextStyle(fontSize: 22,),),
              Text('X${exercise.count}',style:const TextStyle(fontSize: 42,color: primaryColor,fontWeight: FontWeight.bold),),
              Container(
      height: 45.0,
      width: screenHeight/4,
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
           Navigator.pushReplacementNamed(context, 'Rest',arguments: exercise);
          },
          icon:const Text(
            'DONE',
            style:  TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold,fontSize: 22),
          ),
          label:const SizedBox()),
    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
               TextButton.icon(onPressed: () {
                 
               }, icon:const Icon(Icons.arrow_back_ios,color: Colors.white,), label:const Text('QUIT',style: textStyle,),),
              Container(width: 2,height: 30,color: primaryColor,),
               TextButton.icon(
               
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'Rest',arguments: exercise);
               }, icon:const Text('NEXT',style: textStyle,), label:const Icon(Icons.arrow_forward_ios,color: Colors.white),)
              ],)
            ],
          ),
        )
      ],),
    );
  }
}
