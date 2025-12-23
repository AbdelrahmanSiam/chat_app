abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccesState extends RegisterStates {}

class RegisterFailureState extends RegisterStates {
  String errorMsg;
  RegisterFailureState({required this.errorMsg});
}
