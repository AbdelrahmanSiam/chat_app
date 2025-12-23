import 'package:chat_app/Screens/chat_screen.dart';
import 'package:chat_app/cubits/siginIn_cubits/sigin_in_states.dart';
import 'package:chat_app/helper/show_snakbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SiginInCubit extends Cubit<SiginInStates> {
  SiginInCubit() : super(SiginInInitialState());

  Future<void> userSiginIn(
      {required String email, required String password}) async {
    emit(SiginInLoadingState());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(SiginInSuccesState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(SiginInFailureState(errorMsg: 'User not found'));
      } else if (e.code == 'wrong-password') {
        emit(SiginInFailureState(errorMsg: 'Wrong password'));
      } else {
        emit(SiginInFailureState(errorMsg: e.message ?? 'Authentication failed',));
      }
    } catch (e) {
      emit(SiginInFailureState(
          errorMsg: "Something went wrong , Please try again later."));
    }
  }
}
