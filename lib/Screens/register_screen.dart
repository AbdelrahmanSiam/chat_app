import 'package:chat_app/Screens/chat_screen.dart';
import 'package:chat_app/Screens/sign_in_screen.dart';
import 'package:chat_app/Widgets/custom_navigate_button_widget.dart';
import 'package:chat_app/Widgets/custom_text_field_widget.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snakbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  static String pageId = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
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
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await userCredential();
                        showSnackBar(
                            context,
                            "Your email are created succesfully.",
                            Colors.green);
                            Navigator.pushNamed(context,ChatScreen.pageId);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(
                              context, 'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context,
                              'The account already exists for that email.');
                        }
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }

                      setState(() {
                        isLoading = false;
                      });
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
                          Navigator.pop(context); // pop instand of push again
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
  }

  Future<void> userCredential() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
