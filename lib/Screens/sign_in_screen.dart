import 'package:chat_app/Screens/chat_screen.dart';
import 'package:chat_app/Screens/register_screen.dart';
import 'package:chat_app/Widgets/custom_navigate_button_widget.dart';
import 'package:chat_app/Widgets/custom_text_field_widget.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snakbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SiginInScreen extends StatefulWidget {
  SiginInScreen({super.key});
  static String pageId = 'SignInScreen';
  @override
  State<SiginInScreen> createState() => _SiginInScreenState();
}

class _SiginInScreenState extends State<SiginInScreen> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  // use it from the class name ass LoginScreen.pageId
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
                  onChanged: (value) => password = value,
                  text: 'password',
                ),
                SizedBox(
                  height: 50,
                ),
                CustomNavigateButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await userSiginIn();
                        showSnackBar(
                            context, 'Sign in successfuly', Colors.green);
                        Navigator.pushNamed(context,ChatScreen.pageId);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(
                              context, 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context,
                              'Wrong password provided for that user.');
                        }
                      }
                    }

                    setState(() {
                      isLoading = false;
                    });
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
    );
  }

  Future<void> userSiginIn() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
