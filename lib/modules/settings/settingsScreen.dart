import 'package:ap/models/userData/userDataModel.dart';
import 'package:ap/modules/settings/aboutUsScreen.dart';
import 'package:ap/shared/components/components.dart';
import 'package:ap/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login/logIn.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'profile/profileScreen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<ProfileCubit>(context)
        ..getProfileData()..getAboutUs(),
        child: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(top: 120.0),
              child: Column(
                children: [
                  BuildCardSettings(() =>navigateTo(context, ProfileScreen()), Icons.person, "Profile"),
                  BuildCardSettings(() {navigateTo(context,AboutUsScreen());}, Icons.info, "About"),
                  BuildCardSettings(() {

                    navigateAndFinish(context, LogIn());
                    ProfileCubit.get(context).logout();
                  }, Icons.logout, "Logout"),
                ],
              ),
            );
          },
        ));
  }

  Widget BuildCardSettings(Function function, IconData icon, String text) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: ListTile(
                  leading: Icon(
                    icon,
                    color: primaryColor,
                    size: 30,
                  ),
                  title: Align(
                    alignment: Alignment(-1, 0),
                    child: defaultText(
                        text: text,
                        googleFont: true,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: () {
                       // function();
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: primaryColor,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
