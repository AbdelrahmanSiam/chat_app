import 'package:chat_app/Screens/chat_screen.dart';
import 'package:chat_app/Screens/sign_in_screen.dart';
import 'package:chat_app/Widgets/custom_navigate_button_widget.dart';
import 'package:chat_app/Widgets/custom_text_field_widget.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/register%20-cubits/register_cubit.dart';
import 'package:chat_app/cubits/register%20-cubits/register_states.dart';
import 'package:chat_app/helper/show_snakbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatelessWidget {
  static String pageId = 'RegisterScreen';
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (State is RegisterLoadingState) {
          isLoading = true;
        } else if (state is RegisterSuccesState) {
          isLoading = false;
          Navigator.pushNamed(context, ChatScreen.pageId , arguments: email!);
        } else if (state is RegisterFailureState) {
          showSnackBar(context, state.errorMsg);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
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
                      "REGISTER",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      text: 'Email',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      isObsureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      text: 'password',
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    CustomNavigateButton(
                      buttonText: 'REGISTER',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(context)
                              .userCredential(
                                  email: email!, password: password!);
                        }
                      },
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
                              Navigator.pop(
                                  context); // pop instand of push again
                            },
                            child: Text(
                              "SIGN IN",
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
        );
      },
    );
  }
}
