import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/image_cubit/image_cubit.dart';

class CustomRadio extends StatelessWidget {
  const CustomRadio({
    super.key,
    required this.value,
  });
  final String value;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCubit, ImageState>(
      builder: (context, state) {
        final radioState = state as ImageInitial;
        return Expanded(
          flex: 1,
          child: ListTile(
            leading: Radio(
              value: value,
              groupValue: radioState.groupValue ?? 'Male',
              onChanged: (value) {
                BlocProvider.of<ImageCubit>(context)
                    .onChangeRadio(value!, radioState.image);
              },
            ),
            title: Text(value),
          ),
        );
      },
    );
  }
}
