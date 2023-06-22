import 'dart:io';
import 'package:fitx_user/logic/user_auth_bloc/auth_bloc.dart';
import 'package:fitx_user/presentation/constants/lists.dart';
import 'package:fitx_user/logic/image_cubit/image_cubit.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/screens/login_and_register/widget/picked_image_alert.dart';
import 'package:fitx_user/presentation/widget/elevated_button_without_icon.dart';
import 'package:fitx_user/presentation/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../welcome_section/widget/welcome_one_and_two.dart';
import 'custom_radio_button.dart';
import 'loading_elevated_button.dart';
import 'message.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    File? image;
    String? groupValue;
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 27, 25, 25),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: screenHeight / 2.0,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: screenHeight / 2,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://www.healthkart.com/connect/wp-content/uploads/2016/03/banner-7.jpg'),
                              fit: BoxFit.cover)),
                      child:
                          LoginAndRegisterMessage(screenHeight: screenHeight),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenWidth / 2),
                      child: CustomPaint(
                        size: Size(double.maxFinite, screenHeight / 3),
                        painter: RPSCustomPainter(),
                      ),
                    ),
                    Positioned(
                        top: screenWidth / 1.85,
                        left: screenWidth / 3,
                        child: BlocBuilder<ImageCubit, ImageState>(
                          // bloc:BlocProvider.of<ImageCubit>(context) ,
                          builder: (context, state) {
                            final imageState = state as ImageInitial;
                            image = imageState.image;
                            groupValue = imageState.groupValue;
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => PickedImageAlert(
                                    screenWidth: screenWidth,
                                    groupValue: groupValue ?? 'Male',
                                    cot: context,
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: screenWidth / 5,
                                backgroundImage: imageState.image != null
                                    ? FileImage(imageState.image!)
                                    : const NetworkImage(
                                            'https://img.freepik.com/free-icon/user_318-159711.jpg')
                                        as ImageProvider,
                              ),
                            );
                          },
                        ))
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: List.generate(
                      5,
                      (index) => CustomTextFormField(
                            controller:
                                registerPageTextEditingControllers[index],
                            hint: registerPageTextEditingControllerHint[index],
                          )),
                ),
              ),
              const Row(
                children: [
                  CustomRadio(
                    value: 'Male',
                  ),
                  CustomRadio(
                    value: 'Female',
                  ),
                ],
              ),
              spaceforHeight20,
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
                            const SnackBar(
                                content: Text('welcome to success')));
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('Route', (route) => false);
                      }
                    },
                    builder: (context, state) {
                      if (state is! AuthLoadingState) {
                        return ElevatedButtonWithIcon(
                            text: 'Signup',
                            onClicked: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<AuthBloc>(context).add(
                                    SignUpButtonClickedEvent(
                                        image: image,
                                        groupValue: groupValue ?? 'Male'));
                              }
                            });
                      } else {
                        return const LoadingElevatedButtton();
                      }
                    },
                  ),
                  const SizedBox(
                    width: 30,
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ));
  }
}
