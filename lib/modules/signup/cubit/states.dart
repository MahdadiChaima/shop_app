import 'package:ap/models/userData/userDataModel.dart';

abstract class SignupStates {}
class SignupInitialState extends SignupStates {}
class ChangePasswordState extends SignupStates {}
class SignupLoadingState extends SignupStates {}
class SignupSuccessState extends SignupStates {
  final UserDataModel signModel;
  SignupSuccessState(this.signModel);
}
class SignupErrorState extends SignupStates {}
class FillColorButtonLoginState extends SignupStates{}