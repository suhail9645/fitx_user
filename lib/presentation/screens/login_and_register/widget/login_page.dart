import 'package:fitx_user/presentation/constants/lists.dart';
import 'package:fitx_user/presentation/screens/login_and_register/widget/loading_elevated_button.dart';
import 'package:fitx_user/presentation/widget/elevated_button_without_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logic/user_auth_bloc/auth_bloc.dart';
import '../../welcome_section/widget/welcome_one_and_two.dart';
import '../../../widget/text_form_field.dart';
import 'message.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 25, 25),
      body: ListView(children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: screenHeight / 2,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/login.jpg'),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LoginAndRegisterMessage(screenHeight: screenHeight),
                 
                  CustomPaint(
                size: Size(double.maxFinite, screenHeight / 4),
                painter: RPSCustomPainter(),
              ),
                ],
              ),
            ),
           
          ],
        ),
        Form(
          key: _formKey,
          child: Column(
              children: List.generate(
                  2,
                  (index) => CustomTextFormField(
                      controller: loginPageTextEditingControllers[index],
                      hint: loginPageTextEditingControllerHint[index]))),
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthErrorState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                } else if (state is AuthSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('welcome to success')));
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      'Route', arguments: state.userName, (route) => false);
                }
              },
              builder: (context, state) {
                if (state is! AuthLoadingState) {
                  return ElevatedButtonWithIcon(
                      text: 'Login',
                      onClicked: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context)
                              .add(SignInButtonClickedEvent());
                        }
                      });
                } else {
                  return const LoadingElevatedButtton();
                }
              },
            ),
            const SizedBox(
              width: 30,
            ),
          ],
        )
      ]),
    );
  }
}
