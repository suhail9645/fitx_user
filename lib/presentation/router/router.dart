import 'package:fitx_user/logic/image_cubit/image_cubit.dart';
import 'package:fitx_user/logic/user_auth_bloc/auth_bloc.dart';
import 'package:fitx_user/presentation/screens/home_section/home.dart';
import 'package:fitx_user/presentation/screens/login_and_register/login_and_register_screen.dart';
import 'package:fitx_user/presentation/screens/login_and_register/widget/login_page.dart';
import 'package:fitx_user/presentation/screens/login_and_register/widget/register_page.dart';
import 'package:fitx_user/presentation/screens/welcome_section/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final ImageCubit imageCubit = ImageCubit();
  final AuthBloc authBloc = AuthBloc();
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        );
     
      case 'signInAndSignUp':
        return MaterialPageRoute(
          builder: (_) =>  MultiBlocProvider(
            providers: [
            BlocProvider.value(value: imageCubit),
            BlocProvider.value(value: authBloc)
          ],
            child:const LoginAndRegister(),
          ),
        );
        case 'Home':
        return MaterialPageRoute(builder: (_) =>const HomeScreen() ,);
      default:
        return MaterialPageRoute(
          builder: (_) => const SizedBox(),
        );
    }
  }
}
