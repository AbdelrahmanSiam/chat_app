import 'package:flutter/material.dart';

class CustomNavigateButton extends StatelessWidget {
   CustomNavigateButton({
    super.key,
    required this.buttonText, this.onTap,
  });
  final String buttonText;
   VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          width: double.infinity,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                  color: Color(0XFF2C455E),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
