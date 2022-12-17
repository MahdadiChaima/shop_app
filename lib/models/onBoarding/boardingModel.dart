class OnBoardingModel {
  final String title, bodyTitle;
  final int index;
  OnBoardingModel(
      {required this.title, required this.index, required this.bodyTitle});
}
List<OnBoardingModel> itemBoarding = [
  OnBoardingModel(title: "Easy Shopping", bodyTitle: "Lorem Ipsum is simply dummy text of the printing and typesetting industry", index: 0),
  OnBoardingModel(title: "Quick Delivery", bodyTitle: "Lorem Ipsum is simply dummy text of the printing and typesetting industry", index: 1),
  OnBoardingModel(title: "Buy ", bodyTitle: "Lorem Ipsum is simply dummy text of the printing and typesetting industry", index: 2),
];