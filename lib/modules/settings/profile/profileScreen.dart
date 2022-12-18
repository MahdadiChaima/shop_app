import 'package:ap/layout/Shop/shop_layout_screen.dart';
import 'package:ap/models/userData/userDataModel.dart';
import 'package:ap/modules/settings/profile/updateProfileScreen.dart';
import 'package:ap/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/styles/colors.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var profile = ProfileCubit.get(context).profileData;
        var updateProfile= ProfileCubit.get(context).updateProfileModel;

        return Scaffold(
          appBar: AppBar(

            actions: [Padding(
                    padding: const EdgeInsets.only(right:15.0),
                    child: IconButton(onPressed: (){
                      navigateAndFinish(context, ShopLayoutScreen());
                    }, icon: Icon(Icons.home)),
                  )]),
          body: profile == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : updateProfile==null?information(profile,context):information(updateProfile,context),
        );
      },
    );
  }
  Widget information(UserDataModel profile,context)=>Column(crossAxisAlignment: CrossAxisAlignment.start,
    children: [titleContainer(text: "Profile"),
      Padding(
        padding: const EdgeInsets.only(top: 120.0,left: 15,right: 15),
        child: Column(
          children: [

            Container(
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor,
                  width: 0.2,
                ),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Center(
                child: Column(
                  children: [

                    buildItem("Name","${profile.data!.name}"),
                    Divider(height: 5,color: primaryColor,),
                    buildItem("Phone","${profile.data!.phone}"),
                    Divider(height: 5,color: primaryColor,),
                    buildItem("Email","${profile.data!.email}"),




                  ],
                ),
              ),
            ),
            SizedBox(height: 60,),
            defaultMaterialButton(function: (){
              navigateTo(context, UpdateProfileScreen(email:"${profile.data!.email}" ,name:"${profile.data!.name}" ,phone: "${profile.data!.phone}",));

            }, textButton: "Edit Profile", isEnabled: true)

          ],
        ),
      ),
    ],
  );
  Widget buildItem(String title,String item)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(children: [defaultText(text: "${title}:",googleFont: true,fontSize: 22,fontWeight: FontWeight.w600,color: primaryColor),
      Spacer(),
      Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: defaultText(text: item,googleFont: true,fontSize: 22,fontWeight: FontWeight.w400),
      ),],),
  );
}
