import 'package:ap/models/onBoarding/boardingModel.dart';
import 'package:ap/modules/login/logIn.dart';
import 'package:ap/modules/onBoarding/cubit/cubit.dart';
import 'package:ap/modules/onBoarding/cubit/states.dart';
import 'package:ap/shared/components/components.dart';
import 'package:ap/shared/network/local/cacheHelper.dart';
import 'package:ap/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

PageController pageController = PageController();

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LastBoardingPageCubit(),
      child: BlocConsumer<LastBoardingPageCubit, BoardingState>(
        builder: (BuildContext context, BoardingState? state) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                actions: [
                  defaultTextButton(
                      widget:const LogIn(),
                      textButton: "Skip",
                      context: context,
                      googleFont: true,
                      fontSize: 24,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      padding: 28),
                ],
              ),
              body: Container(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        onPageChanged: (index) {
                          if (index == itemBoarding.length - 1) {
                            LastBoardingPageCubit.get(context).isLastT();
                          } else {
                            LastBoardingPageCubit.get(context).isLastF();
                          }
                        },
                        physics: const BouncingScrollPhysics(),
                        controller: pageController,
                        itemBuilder: (BuildContext context, int index) =>
                            buildBoardingItem(itemBoarding[index]),
                        itemCount: itemBoarding.length,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SmoothPageIndicator(
                          controller: pageController,
                          count: itemBoarding.length,
                          effect: ExpandingDotsEffect(
                              dotHeight: 16,
                              dotWidth: 16,
                              dotColor: fifthLightColor,
                              activeDotColor: primaryColor,
                              spacing: 4),
                        ),
                        const Spacer(),
                        FloatingActionButton(
                          onPressed: () {
                            if (LastBoardingPageCubit.get(context).isLast) {
                              CacheHelper.saveData(
                                      key: 'onBoarding', value: true)
                                  .then((value) {
                                if (value == true) {
                                  navigateAndFinish(context, const LogIn());
                                }
                              });
                            } else {
                              pageController.nextPage(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.bounceInOut);
                            }
                          },
                          child: const Icon(Icons.arrow_forward_ios_outlined),
                        )
                      ],
                    )
                  ],
                ),
              ));
        },
        listener: (BuildContext context, BoardingState? state) {},
      ),
    );
  }
}

Widget buildBoardingItem(OnBoardingModel model) {
  return Center(
    child: Column(
      children: [
        Expanded(
            flex: 8,
            child: Image(
              image: AssetImage("assets/img/img${model.index}.png"),
              height: 300,
            )),
        const SizedBox(
          height: 15,
        ),
        Expanded(
            flex: 2,
            child: defaultText(
                text: model.title,
                googleFont: true,
                fontSize: 28,
                color: titleTextColor,
                fontWeight: FontWeight.w700)),
        Expanded(
            flex: 2,
            child: defaultText(
                text: model.bodyTitle,
                googleFont: false,
                fontSize: 20,
                color: subTitleTextColor,
                fontWeight: FontWeight.w500)),
      ],
    ),
  );
}
