import 'package:fitx_user/data_layer/models/category/category_page/result.dart';
import 'package:fitx_user/data_layer/models/exercise_page/result.dart';
import 'package:fitx_user/logic/bottem_nav_cubit/bottem_navbar_cubit.dart';
import 'package:fitx_user/logic/category_bloc/category_bloc.dart';
import 'package:fitx_user/logic/image_cubit/image_cubit.dart';
import 'package:fitx_user/logic/timer_cubit/timer_cubit.dart';
import 'package:fitx_user/logic/user_auth_bloc/auth_bloc.dart';
import 'package:fitx_user/presentation/screens/exercise_list_section/exercis_list.dart';
import 'package:fitx_user/presentation/screens/exercise_playing_section/exercise_playing_screen.dart';
import 'package:fitx_user/presentation/screens/ready_to_go_section/ready_to_go.dart';
import 'package:fitx_user/presentation/screens/rest_section/rest_screen.dart';
import 'package:fitx_user/presentation/screens/route_section/route.dart';
import 'package:fitx_user/presentation/screens/login_and_register/login_and_register_screen.dart';
import 'package:fitx_user/presentation/screens/welcome_section/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final ImageCubit imageCubit = ImageCubit();
  final AuthBloc authBloc = AuthBloc();
  final BottemNavbarCubit bottemNavbarCubit = BottemNavbarCubit();
  final CategoryBloc categoryBloc = CategoryBloc();
  final WaitPageTimerCubit waitPageTimerCubit = WaitPageTimerCubit();
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        );

      case 'signInAndSignUp':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: imageCubit),
              BlocProvider.value(value: authBloc)
            ],
            child: const LoginAndRegister(),
          ),
        );
      case 'Route':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: bottemNavbarCubit),
              BlocProvider.value(value: categoryBloc)
            ],
            child: const RoutePage(),
          ),
        );
      case 'ExerciseView':
        return MaterialPageRoute(
          builder: (context) {
            Category args = routeSettings.arguments as Category;
            return ExerciseViewPage(category: args);
          },
        );
      case 'ReadyToGo':
        return MaterialPageRoute(
          builder: (context) {
            Category args = routeSettings.arguments as Category;
            return ReadyToGoScreen(category: args);
          },
        );
      case 'ExercisePlay':
        return MaterialPageRoute(
          builder: (context) {
            ExercisePlayingScreen args =
                routeSettings.arguments as ExercisePlayingScreen;

            return ExercisePlayingScreen(
              category: args.category,
              index: args.index,
            );
          },
        );
      case 'Rest':
        return MaterialPageRoute(
          builder: (context) {
            RestScreen args = routeSettings.arguments as RestScreen;
            return BlocProvider.value(
              value: waitPageTimerCubit,
              child: RestScreen(
                category: args.category,
                index: args.index,
              ),
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SizedBox(),
        );
    }
  }
}
