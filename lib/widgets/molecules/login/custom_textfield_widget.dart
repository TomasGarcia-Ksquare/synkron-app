import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String hint;
  TextEditingController controller;
  bool password;

  CustomTextFieldWidget({
    Key? key,
    required this.hint,
    required this.controller,
    required this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hint,
          filled: false,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        obscureText: password,
      ),
    );
  }
}
