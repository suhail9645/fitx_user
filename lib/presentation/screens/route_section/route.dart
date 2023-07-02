import 'dart:convert';

import 'package:fitx_user/data_layer/models/user/user.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/screens/explore_section/explore_screen.dart';
import 'package:fitx_user/presentation/screens/home_section/home_screen.dart';
import 'package:fitx_user/presentation/screens/report_section/report_screen.dart';
import 'package:fitx_user/presentation/screens/trainer_section/trainer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../logic/bottem_nav_cubit/bottem_navbar_cubit.dart';
import '../../../logic/category_bloc/category_bloc.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key,required this.userData});
 final String userData;
  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  String greeting='';
  @override
  void initState() {
    super.initState();
    User user=User.fromJson(jsonDecode(widget.userData));
    greeting=user.username!;
  }
  @override
  Widget build(BuildContext context) {

    BlocProvider.of<CategoryBloc>(context).add(CategoryInitialEvent());
    List<Widget> pages =  [
      HomeScreen(userName: greeting,),
     const ExplreScreen(),
    const  ReportScreen(),
    const  TrainerScreen()
    ];
    List<String> appBarTitles = ['Home', 'Explore', 'Report', 'FITNESS TRAINERS'];

    return BlocBuilder<BottemNavbarCubit, BottemNavbarState>(
      builder: (context, state) {
        final indexState = state as BottemNavbarInitial;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              appBarTitles[indexState.index],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'Profile');
                },
                icon: const Icon(
                  Icons.manage_accounts_sharp,
                  size: 30,
                ),
              ),
              spaceforwidth10
            ],
          ),
          body: pages[indexState.index],
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: primaryColor,
              currentIndex: indexState.index,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                BlocProvider.of<BottemNavbarCubit>(context).onChanged(value);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.explore), label: 'Explore'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.report), label: 'Report'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_pin_sharp), label: 'Trainer'),
              ]),
        );
      },
    );
  }
}
