import 'package:chat_app/Screens/register_screen.dart';
import 'package:chat_app/Widgets/custom_navigate_button_widget.dart';
import 'package:chat_app/Widgets/custom_text_field_widget.dart';
import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static String pageId =
      'RegisterScreen'; // use it from the class name ass LoginScreen.pageId
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 180,
            ),
            Center(
              child: Image.asset(
                "assets/images.jpeg",
                height: 150,
                width: 150,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "Scholar Chat",
                style: TextStyle(
                    fontFamily: 'Pacifico', color: Colors.white, fontSize: 30),
              ),
            ),
            Text(
              "LOGIN",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              text: 'Email',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              text: 'password',
            ),
            SizedBox(
              height: 50,
            ),
            CustomNavigateButton(
              buttonText: 'LOGIN',
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "dont have an account?",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterScreen.pageId);
                    },
                    child: Text(
                      "REGISTER",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
