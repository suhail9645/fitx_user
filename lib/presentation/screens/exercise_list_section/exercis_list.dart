import 'package:fitx_user/data_layer/models/category/category_page/result.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/screens/exercise_list_section/widget/bottem_sheet.dart';
import 'package:fitx_user/presentation/widget/elevated_button_without_icon.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExerciseViewPage extends StatelessWidget {
  final Category category;
  const ExerciseViewPage({super.key, required this.category});
  @override
  Widget build(BuildContext context) {
  
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: screenHeight / 3.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(category.image!), fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              category.name!,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                         
                          ],
                        ),
                        spaceforHeight20
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        size: 17,
                        color: primaryColor,
                      ),
                      spaceforwidth10,
                      Text(
                        '${category.exercisesCount} workouts',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Column(
                    children: List.generate(category.exercises.length, (index) {
                  const textStyle =
                      TextStyle(fontSize: 17, color: primaryColor);
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    height: screenHeight * 0.10,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 37, 36, 36),
                        borderRadius: BorderRadiusDirectional.circular(7)),
                    child: Row(
                      children: [
                        Container(
                          width: 76,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadiusDirectional.only(
                              topStart: Radius.circular(7),
                              bottomStart: Radius.circular(7),
                            ),
                            image: DecorationImage(
                                image: NetworkImage(
                                    category.exercises[index].demo!),
                                fit: BoxFit.fill),
                          ),
                        ),
                        spaceforwidth10,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              category.exercises[index].name!,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            category.exercises[index].count != null
                                ? Text('X ${category.exercises[index].count}',
                                    style: textStyle)
                                : Text(
                                    category.exercises[index].duration
                                        .toString()
                                        .split(':')
                                        .sublist(1, 3)
                                        .join(':'),
                                    style: textStyle,
                                  ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return DetailesBottemSheet(
                                      screenHeight: screenHeight,
                                      category: category,
                                      index: index,
                                    );
                                  },
                                );
                              },
                              child: const Icon(Icons.question_mark),
                            ),
                            InkWell(
                              onTap: () async {

                                await launchUrl(Uri.parse(  category.exercises[index].videoLink!));
                              },
                              child: const Text(
                                'WATCH',
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }))
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButtonWithIcon(
                width: screenHeight / 2.4,
                text: 'Start',
                onClicked: () {
                  if (category.exercises.isNotEmpty) {
                    Navigator.pushNamed(context, 'ReadyToGo',
                        arguments: category);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('No exercise in this category')));
                  }
                },
              ))
        ],
      ),
    );
  }
}
