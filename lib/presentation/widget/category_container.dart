import 'package:flutter/material.dart';

import '../../data_layer/models/category/category_page/result.dart';
import '../constants/colors.dart';
import '../constants/sized_box.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer(
      {super.key, required this.screenHeight, required this.category});

  final double screenHeight;
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'ExerciseView', arguments: category);
        },
        child: Container(
          height: screenHeight / 4.6,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(category.image!),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceforHeight20,
                Text(
                  category.name!,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${category.exercisesCount} Workouts',
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${category.likes} People like this Category',
                      style: const TextStyle(color: primaryColor),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          color: category.isLiked ? Colors.red : Colors.white,
                        ))
                  ],
                ),
                spaceforHeight10
              ],
            ),
          ),
        ),
      ),
    );
  }
}
