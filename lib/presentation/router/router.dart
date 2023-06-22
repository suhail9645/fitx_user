import 'package:fitx_user/logic/bottem_nav_cubit/bottem_navbar_cubit.dart';
import 'package:fitx_user/logic/category_bloc/category_bloc.dart';
import 'package:fitx_user/logic/image_cubit/image_cubit.dart';
import 'package:fitx_user/logic/user_auth_bloc/auth_bloc.dart';
import 'package:fitx_user/presentation/screens/route_section/route.dart';
import 'package:fitx_user/presentation/screens/login_and_register/login_and_register_screen.dart';
import 'package:fitx_user/presentation/screens/login_and_register/widget/login_page.dart';
import 'package:fitx_user/presentation/screens/login_and_register/widget/register_page.dart';
import 'package:fitx_user/presentation/screens/welcome_section/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final ImageCubit imageCubit = ImageCubit();
  final AuthBloc authBloc = AuthBloc();
  final BottemNavbarCubit bottemNavbarCubit = BottemNavbarCubit();
  final CategoryBloc categoryBloc = CategoryBloc();
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
      default:
        return MaterialPageRoute(
          builder: (_) => const SizedBox(),
        );
    }
  }
}
