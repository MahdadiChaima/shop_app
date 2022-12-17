import '../../../models/userData/userDataModel.dart';

abstract class LoginStates {}
class LoginInitialState extends LoginStates {}
class ChangePasswordState extends LoginStates {}
class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {
  final UserDataModel loginModel;
  LoginSuccessState(this.loginModel);
}
class FillColorButtonLoginState extends LoginStates{

  FillColorButtonLoginState();
}
class LoginErrorState extends LoginStates {}
