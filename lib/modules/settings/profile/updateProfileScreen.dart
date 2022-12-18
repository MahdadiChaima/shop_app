import 'package:ap/modules/settings/profile/profileScreen.dart';
import 'package:ap/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
class UpdateProfileScreen extends StatelessWidget {
  final String name,phone,email;
  const UpdateProfileScreen({Key? key,required this.name, required this.phone, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {var keyForm = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<ProfileCubit, ProfileStates>( listener:  (context,state){
      if (state is UpdateProfileSuccessState) {
        if (state.updateProfileData.status ?? true) {
          print("profileData.message: ${state.updateProfileData.message}");
          defaultSnackBarMaterial(
              context, fourthColor, state.updateProfileData.message!);
          navigateTo(context, ProfileScreen());


        } else {
          defaultSnackBarMaterial(
              context, thirdColor, state.updateProfileData.message!);

        }
      }
    }
        ,builder: (context,state){

      return Scaffold(
          appBar: AppBar(),
          body:
            SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleContainer(text: "Edit Profile"),
                  Padding(
                    padding: const EdgeInsets.only(top: 180.0,left: 20,right: 20),
                    child: Form(key: keyForm,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          defaultTextField(controller: nameController..text = name, prefix: Icons.person,type: TextInputType.name, text: "Name",textForUnValid: "Enter your name"),
                          SizedBox(height: 20,),
                          defaultTextField(controller: phoneController..text = phone, prefix: Icons.phone,type: TextInputType.phone, text: "Phone",textForUnValid: "Enter your phone"),
                          SizedBox(height: 20,),
                          defaultTextField(controller: emailController..text = email, prefix: Icons.email,type: TextInputType.name, text: "Email",textForUnValid: "Enter your email"),
                          SizedBox(height: 60,),
                          state is!UpdateProfileLoadingState?
                          defaultMaterialButton(function: (){
                           if (keyForm.currentState!.validate()) {
                             print(nameController.text);
                             print(phoneController.text);
                             print(emailController.text);
                             ProfileCubit.get(context).updateProfile(name:nameController.text,email:emailController.text,phone:phoneController.text,);


                           }

                          }, textButton: "Save", isEnabled: true):Center(child:CircularProgressIndicator()),
                      ],),
                    ),
                  ),
                ],
              ),
            )

        );});
  }
}
