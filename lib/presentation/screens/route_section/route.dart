import 'dart:convert';
import 'package:fitx_user/data_layer/models/user/user.dart';
import 'package:fitx_user/logic/message_bloc/message_bloc.dart';
import 'package:fitx_user/logic/network_cubit/network_cubit.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/screens/explore_section/explore_screen.dart';
import 'package:fitx_user/presentation/screens/home_section/home_screen.dart';
import 'package:fitx_user/presentation/screens/report_section/report_screen.dart';
import 'package:fitx_user/presentation/screens/trainer_section/trainer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/bottem_nav_cubit/bottem_navbar_cubit.dart';
import '../../../logic/category_bloc/category_bloc.dart';
import '../../../logic/report_bloc/report_bloc.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key, required this.userData});
  final String userData;
  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  String greeting = '';
  late User user;
  @override
  void initState() {
    super.initState();
    user = User.fromJson(jsonDecode(widget.userData));
    greeting = user.username!;
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryBloc>(context).add(CategoryInitialEvent());
    BlocProvider.of<ReportBloc>(context).add(ReportInitialEvent());
     BlocProvider.of<MessageBloc>(context).add(MessageInitialEvent());

    List<Widget> pages = [
      HomeScreen(
        userName: greeting,
      ),
      const ExplreScreen(),
      ReportScreen(),
       TrainerScreen(user: user,)
    ];
    List<String> appBarTitles = [
      'Home',
      'Explore',
      'Report',
      'FITNESS TRAINERS'
    ];

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
                  Navigator.pushNamed(context, 'Profile', arguments: user);
                },
                icon: const Icon(
                  Icons.manage_accounts_sharp,
                  size: 30,
                ),
              ),
              spaceforwidth10
            ],
          ),
          body: BlocBuilder<NetworkCubit, bool>(
            builder: (context, state) {
              if (!state) {
                return AlertDialog(
                  title: const Icon(
                    Icons.signal_wifi_statusbar_connected_no_internet_4_sharp,
                    size: 35,
                    color: primaryColor,
                  ),
                  content: const Text('No network ,Please check network'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          if (state) {
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Try again'))
                  ],
                );
              } else {
                return pages[indexState.index];
              }
            },
          ),
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
