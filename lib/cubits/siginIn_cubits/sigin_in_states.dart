abstract class SiginInStates {}

class SiginInInitialState extends SiginInStates {}

class SiginInLoadingState extends SiginInStates {}

class SiginInSuccesState extends SiginInStates {}

class SiginInFailureState extends SiginInStates {
  String errorMsg;
  SiginInFailureState({required this.errorMsg});
}
