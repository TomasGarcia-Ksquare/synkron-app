import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomNumberField extends StatelessWidget {
  const CustomNumberField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  final TextEditingController controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "input can't be empty";
            } else if (int.parse(value) > 8) {
              return "Too many hours";
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: labelText,
          ),
          maxLines: 1,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ]),
    );
  }
}
