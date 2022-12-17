import 'package:ap/models/userData/userDataModel.dart';
import 'package:ap/modules/signup/cubit/states.dart';
import 'package:ap/shared/network/dioHelper.dart';
import 'package:ap/shared/network/endPoints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

UserDataModel? model;

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitialState());
  bool isPassword = true;
  bool isEnabled = false;
  late UserDataModel model;
  static SignupCubit get(context) => BlocProvider.of(context);

  void changePasswordShow() {
    isPassword = !isPassword;
    emit(ChangePasswordState());
  }

  void RegisterUser(
      {required String name,
      required String phone,
      required String email,
      required String password}) {
    emit(SignupLoadingState());
    DioHelper.postData(url: signupPath, data: {
      "name": name,
      "phone": phone,
      "email": email,
      "password": password
    }).then((value) {
      model = UserDataModel.toObject(value.data);
      emit(SignupSuccessState(model));
      print(value.data.toString());
    }).catchError((onError) {
      print(onError.toString());
      emit(SignupErrorState());
    });
  }

  void fillButtonColor() {
    emit(FillColorButtonLoginState());
  }
}
