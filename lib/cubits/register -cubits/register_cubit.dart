 import 'package:chat_app/cubits/register%20-cubits/register_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit <RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  
  Future<void> userCredential({required String email , required String password}) async {
    emit(RegisterLoadingState());
    try{
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
        emit(RegisterSuccesState());
  }on FirebaseAuthException catch (e) {

                        if (e.code == 'weak-password') {
                          emit(RegisterFailureState(errorMsg: "The password provided is too weak."));
                        } else if (e.code == 'email-already-in-use') {
                          emit(RegisterFailureState(errorMsg: "The account already exists for that email."));
                        }else {
        emit(RegisterFailureState(errorMsg: e.message ?? 'Authentication failed',));
      }
                      }catch (e) {
                        emit(RegisterFailureState(errorMsg: "Something went wrong , Please try again later."));
                      }
}
}