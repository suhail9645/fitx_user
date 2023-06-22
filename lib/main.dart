import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color.fromARGB(255, 27, 25, 25),
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  AppRouter route = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FITX',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.ubuntu().fontFamily,
        brightness: Brightness.dark,
      ),
      onGenerateRoute: route.onGenerateRoute,
    );
  }
}
