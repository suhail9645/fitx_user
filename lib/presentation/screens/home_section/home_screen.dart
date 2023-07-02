
import 'package:fitx_user/logic/category_bloc/category_bloc.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/sized_box.dart';
import 'package:shimmer/shimmer.dart';
import '../../widget/category_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userName});
  final String userName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String greeting = '';
  @override
  void initState() {
    super.initState();
    final time = DateTime.now().hour;
    if (time < 12) {
      greeting = 'Good Morning.';
    } else if (time <= 15) {
      greeting = 'Good AfterNoon.';
    } else {
      greeting = 'Good Evening.';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return BlocConsumer<CategoryBloc, CategoryState>(
      // buildWhen: (previous, current) => ,
      listener: (context, state) {
        // if (state is CategoryErrorState) {
        //   showDialog(
        //     context: context,
        //     builder: (context) => AlertDialog(
        //       title: const Text('session expired'),
        //       content: const Text('Please Login again'),
        //       actions: [
        //         ElevatedButton(
        //             onPressed: () {
        //               Navigator.of(context).pushNamedAndRemoveUntil(
        //                   'signInAndSignUp', (route) => false);
        //             },
        //             child: const Text('Login Page'))
        //       ],
        //     ),
        //   );
        // }
      },
      builder: (context, state) {
        if (state is CategoryInitial) {
          return Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'HELLO',
                        style: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                      spaceforwidth10,
                      Expanded(
                          child: Text(
                        widget.userName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        greeting,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
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


