import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.text,
      this.onChanged,
      this.isObsureText = false});
  final String text;
  ValueChanged<String>? onChanged;
  bool? isObsureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObsureText!,
      validator: (value) {
        if (value!.isEmpty) return 'Field is required';
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(width: 5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
