import 'package:ap/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterState> {
  int counter = 0;
  CounterCubit() : super(CounterIntialState());
  static CounterCubit get(context) => BlocProvider.of(context);
  void minus() {
    counter--;
    emit(CounterMinusState(counter));
  }

  void add() {
    counter++;
    emit(CounterAddState(counter));
  }
}


