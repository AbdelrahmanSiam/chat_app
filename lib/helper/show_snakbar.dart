import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, [Color? backgroundColor]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      backgroundColor: backgroundColor ?? Colors.black87,
      behavior: SnackBarBehavior.floating, // يخليها floating بدل full width
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      duration: Duration(seconds: 2),
    ),
  );
}
