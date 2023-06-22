import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../logic/image_cubit/image_cubit.dart';

class PickedImageAlert extends StatelessWidget {
  const PickedImageAlert({
    super.key,
    required this.screenWidth,
    required this.groupValue,
    required this.cot,
  });

  final double screenWidth;
  final String groupValue;
  final BuildContext cot;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: screenWidth / 6),
      actionsPadding: const EdgeInsets.all(8),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Container(
          height: 40.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 48, 48, 3),
                Color.fromARGB(255, 30, 31, 30)
              ])),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent),
            onPressed: () {
              BlocProvider.of<ImageCubit>(cot)
                  .imagePicking(ImageSource.gallery, groupValue);
            },
            child: const Text('Gallery'),
          ),
        ),
        Container(
          height: 40.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 53, 63, 3),
                Color.fromARGB(255, 90, 45, 4)
              ])),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent),
            onPressed: () {
              BlocProvider.of<ImageCubit>(cot)
                  .imagePicking(ImageSource.camera, groupValue);
            },
            child: const Text('Camera'),
          ),
        ),
      ],
    );
  }
}
