import 'package:ap/shared/components/components.dart';
import 'package:ap/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var about = ProfileCubit.get(context).aboutModel;
        return Scaffold(
          appBar: AppBar(),
          body: about == null
              ? Center(child: CircularProgressIndicator())
              : Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleContainer(text: "Information:"),
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 120.0, left: 15, right: 15),
                      child: Container(
                        height: 240,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primaryColor,
                            width: 0.2,
                          ),
                          shape: BoxShape.rectangle,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10,top: 10),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              defaultText(
                                  text: "About:",
                                  googleFont: true,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: secondTextColor),
                              Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 40),
                                child: defaultText(text: "${about.data!.about}" ),
                              ),
                              defaultText(
                                  text: "Term:",
                                  googleFont: true,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: secondTextColor),
                              Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 20),
                                child: defaultText(text: "${about.data!.terms}"),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
        );
      },
    );
  }
}
