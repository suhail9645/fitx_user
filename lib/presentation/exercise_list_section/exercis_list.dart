import 'package:fitx_user/data_layer/models/category/category_page/result.dart';
import 'package:fitx_user/data_layer/models/exercise_page/result.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/widget/elevated_button_without_icon.dart';
import 'package:flutter/material.dart';

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
          Column(
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
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
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
              Expanded(
                child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      const textStyle =
                          TextStyle(fontSize: 17, color: primaryColor);
                      return ListTile(
                        minVerticalPadding: 0,
                        contentPadding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                        leading: Container(
                          width: screenHeight / 12,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    category.exercises[index].demo!),
                                fit: BoxFit.fill),
                          ),
                        ),
                        title: Text(
                          category.exercises[index].name!,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        subtitle: category.exercises[index].count != null
                            ? Text('X ${category.exercises[index].count}',
                                style: textStyle)
                            : Text(
                                category.exercises[index].duration,
                                style: textStyle,
                              ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return Container(
                                      height: screenHeight / 1.2,
                                      child: Column(
                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'DETAILES',
                                                style: TextStyle(fontSize: 23),
                                              )
                                            ],
                                          ),
                                          const Divider(),
                                          Container(
                                            height: screenHeight / 3.5,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(category
                                                      .exercises[index].demo!),
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  category.exercises[index].name!,
                                                  style:
                                                      const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                                ),
                                             
                                              ],
                                            ),
                                          ),
                                             Text(category.exercises[index].description!,textAlign: TextAlign.start,)
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Icon(Icons.question_mark),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                'WATCH',
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: category.exercises.length),
              )
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButtonWithIcon(
                width: screenHeight / 2.4,
                text: 'Start',
                onClicked: () {},
              ))
        ],
      ),
    );
  }
}
