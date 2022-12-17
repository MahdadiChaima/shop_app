import 'package:ap/models/settings/aboutModel.dart';
import 'package:ap/models/userData/userDataModel.dart';
import 'package:ap/modules/settings/cubit/states.dart';
import 'package:ap/shared/components/constants.dart';
import 'package:ap/shared/network/dioHelper.dart';
import 'package:ap/shared/network/endPoints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());
  static ProfileCubit get(context) => BlocProvider.of(context);
  //profile
  UserDataModel? profileData;
  void getProfileData() {
    emit(ProfileLoadingState());
    DioHelper.getData(path: profilePath, token: token).then((value) {
      profileData = UserDataModel.toObject(value.data);
      print("getProfileData: ${profileData!.data!.name}");
      print("check model Profile: ${profileData == null}");
      emit(ProfileSuccessState(profileData!));
    }).catchError((onError) {
      print("getProfileData: ${onError.toString()}");
      emit(ProfileErrorState());
    });
  }

  UserDataModel? updateProfileModel;
  void updateProfile({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(UpdateProfileLoadingState());
    DioHelper.updateData(
            url: updateProfilePath,
            data: {
              "name": name,
              "phone": phone,
              "email": email,
            },
            token: token)
        .then((value) {
      updateProfileModel = UserDataModel.toObject(value.data);
      print("Update Profile Successfully");
      emit(UpdateProfileSuccessState(updateProfileModel!));
    }).catchError((onError) {
      print("get Error: ${onError.toString()}");
      emit(UpdateProfileErrorState());
    });
  }

  ChangePasswordModel? changePasswordModel;
  void changePassword(
      {required String currentPassword, required String newPassword}) {
    emit(ChangePasswordLoadingState());
    DioHelper.postData(url: changePasswordPath, token: token, data: {
      "current_password": currentPassword,
      "new_password": newPassword
    }).then((value) {
      changePasswordModel = ChangePasswordModel.toObject(value.data);
      emit(ChangePasswordSuccessState());
    }).catchError((onError) {
      print("get Error: ${onError.toString()}");
      emit(ChangePasswordErrorState());
    });
  }

  LogoutModel? logoutModel;
  void logout() {
    emit(LogoutLoadingState());
    DioHelper.postData(url: logoutPath, token: token, data: {}).then((value) {
      logoutModel = LogoutModel.toObject(value.data);
      emit(LogoutSuccessState());
    }).catchError((onError) {
      print("get Error: ${onError.toString()}");
      emit(LogoutErrorState());
    });
  }

  //about
  AboutModel? aboutModel;
  void getAboutUs() {
    emit(AboutLoadingState());
    DioHelper.getData(path: aboutPath).then((value) {
      aboutModel = AboutModel.toObject(value.data);
      emit(AboutSuccessState());
    }).catchError((onError) {
      emit(AboutErrorState());
    });
  }


}
