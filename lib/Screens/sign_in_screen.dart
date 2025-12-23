import 'package:chat_app/Screens/chat_screen.dart';
import 'package:chat_app/Screens/register_screen.dart';
import 'package:chat_app/Widgets/custom_navigate_button_widget.dart';
import 'package:chat_app/Widgets/custom_text_field_widget.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/register%20-cubits/cubit/chat_cubit.dart';
import 'package:chat_app/cubits/siginIn_cubits/sigin_in_cubit.dart';
import 'package:chat_app/cubits/siginIn_cubits/sigin_in_states.dart';
import 'package:chat_app/helper/show_snakbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInScreen extends StatelessWidget {
  static String pageId = 'SignInScreen';
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SiginInCubit, SiginInStates>(
      listener: (context, state) {
        if (state is SiginInSuccesState) {
          BlocProvider.of<ChatCubit>(context).fetchMessages();
          Navigator.pushNamed(context, ChatScreen.pageId, arguments: email!);
        } else if (state is SiginInFailureState) {
          showSnackBar(context, state.errorMsg);
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: state is SiginInLoadingState,
        child: Scaffold(
          backgroundColor: primaryColor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
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
                          fontFamily: 'Pacifico',
                          color: Colors.white,
                          fontSize: 30),
                    ),
                  ),
                  Text(
                    "SIGN IN",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    onChanged: (value) => email = value,
                    text: 'Email',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    isObsureText: true,
                    onChanged: (value) => password = value,
                    text: 'password',
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  CustomNavigateButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<SiginInCubit>(context)
                            .userSiginIn(email: email!, password: password!);
                      }
                    },
                    buttonText: 'SIGN IN',
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
          ),
        ),
      ),
    );
  }
}
