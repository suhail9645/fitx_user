import 'package:fitx_user/logic/category_bloc/category_bloc.dart';
import 'package:fitx_user/logic/category_like_cubit/category_like_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_layer/models/category/category_page/result.dart';
import '../constants/colors.dart';
import '../constants/sized_box.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer(
      {super.key,
      required this.screenHeight,
      required this.category,
      required this.homeContext,});
  final BuildContext homeContext;
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
                BlocBuilder<CategoryLikeCubit, CategoryLikeState>(
                  builder: (context, state) {
                    if (state is CategoryLikeUnlikeState) {
                          // categoryState.catgories[index]=state.category;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${state.category.likes} People like this Category',
                            style: const TextStyle(color: primaryColor),
                          ),
                          IconButton(
                            onPressed: () {
                        
                              BlocProvider.of<CategoryLikeCubit>(context)
                                  .onLikeAndUnlike(category.id, state.category,
                                      state.likeCount);
                            },
                            icon: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder: (child, anim) =>
                                    RotationTransition(
                                      turns: Tween<double>(begin: 0, end: 1)
                                          .animate(anim),
                                      child: ScaleTransition(
                                          scale: anim, child: child),
                                    ),
                                child: state.category.isLiked
                                    ? const Icon(Icons.thumb_down,
                                        key: ValueKey('icon1'))
                                    : const Icon(
                                        Icons.thumb_up,color: Colors.red,
                                        key: ValueKey('icon2'),
                                      )),
                          )
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
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
