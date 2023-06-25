import 'dart:convert';

import 'package:fitx_user/data_layer/models/category/category_page/result.dart';
import 'package:fitx_user/logic/category_bloc/category_bloc.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/sized_box.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.greeting});
 final String greeting;
  @override
  
  @override
  Widget build(BuildContext context) {
    
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CategoryErrorState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('session expired'),
              content: const Text('Please Login again'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'signInAndSignUp', (route) => false);
                    },
                    child: const Text('Login Page'))
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is CategoryInitial) {
          return Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                const  Row(

                    children: [
                      Text('HELLO',style: TextStyle(fontSize: 35,),),
                      spaceforwidth10,
                      Expanded(child: Text('SuhailPk,',overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),))
                    ],
                  ),
              const  Row(
                  children: [
                      Text('Good Morning.',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: primaryColor),),
                  ],
                ),const SizedBox(height: 30,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Newly Added',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                      children: List.generate(
                          state.catgories.length,
                          (index) => CategoryContainer(
                                screenHeight: screenHeight,
                                category: state.catgories[
                                    (state.catgories.length - 1) - index],
                              )))
                ],
              ),
            ),
          );
        } else if (state is CategoryLoadingState) {
          return SingleChildScrollView(
            child: Column(
              children: List.generate(
                  10,
                  (index) => Shimmer.fromColors(
                        baseColor: Colors.grey[500]!,
                        highlightColor: Colors.grey[100]!,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: screenHeight / 4.6,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      )),
            ),
          );
        } else {
          return const Center(
            child: Text('something wrong please try again'),
          );
        }
      },
    );
  }
}

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
                    const Text(
                      '0 People like this Category',
                      style: TextStyle(color: primaryColor),
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.favorite))
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
