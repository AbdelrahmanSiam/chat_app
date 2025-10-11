import 'package:chat_app/Screens/chat_screen.dart';
import 'package:chat_app/Screens/sign_in_screen.dart';
import 'package:chat_app/Screens/register_screen.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
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
        SiginInScreen.pageId: (context) => SiginInScreen(),
        RegisterScreen.pageId: (context) => RegisterScreen(),
        ChatScreen.pageId: (context) => ChatScreen(),
      },
      initialRoute: ChatScreen.pageId,
    );
  }
}
