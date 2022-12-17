import 'package:ap/models/userData/userDataModel.dart';

abstract class ProfileStates {}
class ProfileInitialState extends ProfileStates {}
class Refresh extends ProfileStates{}
//profile
class ProfileLoadingState extends ProfileStates {}
class ProfileSuccessState extends ProfileStates {
  final UserDataModel profileData;
  ProfileSuccessState(this.profileData);
}
class ProfileErrorState extends ProfileStates {}

//UpdateProfile
class UpdateProfileLoadingState extends ProfileStates {}
class UpdateProfileSuccessState extends ProfileStates {
  final UserDataModel updateProfileData;
  UpdateProfileSuccessState(this.updateProfileData);
}
class UpdateProfileErrorState extends ProfileStates {}

//ChangePassword
class ChangePasswordLoadingState extends ProfileStates {}
class ChangePasswordSuccessState extends ProfileStates {}
class ChangePasswordErrorState extends ProfileStates {}

//About
class AboutLoadingState extends ProfileStates {}
class AboutSuccessState extends ProfileStates {}
class AboutErrorState extends ProfileStates {}

//Logout
class LogoutLoadingState extends ProfileStates {}
class LogoutSuccessState extends ProfileStates {}
class LogoutErrorState extends ProfileStates {}