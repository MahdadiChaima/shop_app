abstract class BoardingState{}
class BoardingInitialState extends BoardingState{}
class IsLastBoardingPageState extends BoardingState{
  late final bool isLast;
  IsLastBoardingPageState(this.isLast);
}
class OnBoardingSubmittedState extends BoardingState{

 OnBoardingSubmittedState();
}