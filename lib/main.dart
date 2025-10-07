import 'package:chat_app/Screens/login_screen.dart';
import 'package:chat_app/Screens/register_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.pageId : (context)=> LoginScreen(),
        RegisterScreen.pageId : (context)=> RegisterScreen(),
      },
      initialRoute: 'LoginScreen',
    );
  }
}
