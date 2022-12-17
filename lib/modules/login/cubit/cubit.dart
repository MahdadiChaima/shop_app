
import 'package:ap/modules/login/cubit/states.dart';
import 'package:ap/shared/network/dioHelper.dart';
import 'package:ap/shared/network/endPoints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/userData/userDataModel.dart';
UserDataModel? obj;

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  bool isEnabled=false;
  bool isPassword = true;

  static LoginCubit get(context) => BlocProvider.of(context);
  void changePasswordShow() {
    isPassword = !isPassword;
    emit(ChangePasswordState());
  }

  void userData({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: loginPath, data: {"email": email, "password": password})
        .then((value) {
      obj=UserDataModel.toObject(value.data);

      emit(LoginSuccessState(obj!));
    }).catchError((error) {
      emit(LoginErrorState());

        print(error.toString());

    });
  }
  void fillButtonColor(){
    emit(FillColorButtonLoginState());
  }
}
