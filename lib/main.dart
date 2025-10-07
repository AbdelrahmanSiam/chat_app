import 'package:chat_app/Screens/login_screen.dart';
import 'package:chat_app/Screens/register_screen.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
