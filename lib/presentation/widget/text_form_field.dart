import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'package:intl/intl.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hint,
  });

  final TextEditingController controller;
  final String hint;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isVisible;
  @override
  void initState() {
    isVisible = false;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
      child: TextFormField(
        onTap: () async {
          if (widget.hint == 'Date of Birth') {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(), //get today's date
                firstDate: DateTime(
                    2000), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2025));
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              widget.controller.text = formattedDate;
            }
          }
        },
        obscureText: isVisible,
        maxLength:
            widget.hint == 'Full name' || widget.hint == 'Password' ? 12 : null,
        decoration: InputDecoration(
          suffixIcon: widget.hint == 'Password'
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    size: 20,
                    color: Colors.grey,
                  ))
              : const SizedBox(),
          labelText: widget.hint,
          floatingLabelStyle: const TextStyle(color: whiteColor),
          labelStyle: const TextStyle(color: whiteColor),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: lineColor),
          ),
        ),
        controller: widget.controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter the ${widget.hint}';
          } else if (widget.hint == 'Email' &&
              !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
            return 'invalid emil';
          } else if (widget.hint == 'Password' && value.length < 6) {
            return 'Password must have 6 character';
          } else if (widget.hint == 'Date of Birth') {
            if (DateTime.tryParse(value) == null) {
              return 'not formated';
            }
          }
          return null;
        },
      ),
    );
  }
}
