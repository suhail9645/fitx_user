import 'package:fitx_user/data_layer/models/category/category_page/result.dart';
import 'package:fitx_user/logic/category_bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/sized_box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryBloc>(context).add(CategoryInitialEvent());
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
        } else {
          return const CircularProgressIndicator();
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
          Navigator.pushNamed(context,'ExerciseView',arguments: category);
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
                  style:
                      const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${category.exercisesCount} Workouts',
                  style:
                      const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
