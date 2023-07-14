import 'package:fitx_user/logic/network_cubit/network_cubit.dart';
import 'package:fitx_user/presentation/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color.fromARGB(255, 27, 25, 25),
    statusBarColor: Colors.transparent,
  ));
  SharedPreferences sred = await SharedPreferences.getInstance();
  String? userData = sred.getString('user');

  runApp(MyApp(
    userData: userData,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, this.userData});
  final String? userData;
  final AppRouter route = AppRouter();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NetworkCubit()..observeNetwork(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FITX',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: GoogleFonts.ubuntu().fontFamily,
          brightness: Brightness.dark,
        ),
        initialRoute: userData != null ? 'Route' : '/',
        // initialRoute: '/',

        onGenerateInitialRoutes: (initialRoute) {
          return [
            initialRoute != '/'
                ? route.onGenerateRoute(
                    RouteSettings(name: initialRoute, arguments: userData))
                : route.onGenerateRoute(RouteSettings(
                    name: initialRoute,
                  )),
          ];
        },
        onGenerateRoute: route.onGenerateRoute,
      ),
    );
  }
}
