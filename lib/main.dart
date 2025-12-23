import 'package:chat_app/Screens/chat_screen.dart';
import 'package:chat_app/Screens/sign_in_screen.dart';
import 'package:chat_app/Screens/register_screen.dart';
import 'package:chat_app/cubits/register%20-cubits/cubit/chat_cubit.dart';
import 'package:chat_app/cubits/register%20-cubits/register_cubit.dart';
import 'package:chat_app/cubits/siginIn_cubits/sigin_in_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SiginInCubit()),
        BlocProvider(create: (_) => RegisterCubit()),
        BlocProvider(create: (_) => ChatCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          SignInScreen.pageId: (context) => SignInScreen(),
          RegisterScreen.pageId: (context) => RegisterScreen(),
          ChatScreen.pageId: (context) => ChatScreen(),
        },
        initialRoute: SignInScreen.pageId,
      ),
    );
  }
}
