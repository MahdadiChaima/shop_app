import 'package:flutter/material.dart';

abstract class CounterState{}
class CounterIntialState extends CounterState{}
class CounterMinusState extends CounterState{
  late final int counter;
  CounterMinusState(this.counter);

}
class CounterAddState extends CounterState{
  late final int counter;
  CounterAddState(this.counter);

}
