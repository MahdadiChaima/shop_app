
import 'package:ap/modules/onBoarding/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/network/local/cacheHelper.dart';
import '../../login/logIn.dart';

class LastBoardingPageCubit extends Cubit<BoardingState> {
  bool isLast = false;

  LastBoardingPageCubit() : super(BoardingInitialState());
  static LastBoardingPageCubit get(context) => BlocProvider.of(context);
  void isLastT() {
    isLast = true;
    emit(IsLastBoardingPageState(isLast));
  }

  void isLastF() {
    isLast = false;
    emit(IsLastBoardingPageState(isLast));
  }
  submit(context) {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        emit(OnBoardingSubmittedState());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LogIn()),
        );
      }
    });
  }}