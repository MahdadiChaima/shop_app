import 'package:ap/modules/signup/cubit/states.dart';
import 'package:ap/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/styles/colors.dart';
import '../login/logIn.dart';
import 'cubit/cubit.dart';

var keyForm = GlobalKey<FormState>();
var emailController = TextEditingController();
var passwordController = TextEditingController();
var nameController = TextEditingController();
var phoneController = TextEditingController();

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupStates>(
        builder: (BuildContext context, SignupStates? state) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                titleContainer(text: "Register"),
                Padding(
                  padding: const EdgeInsets.only(top: 110, right: 40, left: 40),
                  child: Form(
                    key: keyForm,
                    child: Column(
                      children: [
                        defaultTextField(
                          text: "Name",
                          controller: nameController,
                          prefix: Icons.person_outline_outlined,
                          type: TextInputType.name,
                          textForUnValid: "Enter your name",
                          onChanged: () {
                            if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty &&
                                nameController.text.isNotEmpty &&
                                phoneController.text.isNotEmpty) {
                              SignupCubit.get(context).isEnabled = true;
                              SignupCubit.get(context).fillButtonColor();
                            } else {
                              SignupCubit.get(context).isEnabled = false;
                              SignupCubit.get(context).fillButtonColor();
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultTextField(
                          text: "Phone",
                          controller: phoneController,
                          prefix: Icons.phone_outlined,
                          type: TextInputType.phone,
                          textForUnValid: "Enter your phone",
                          onChanged: () {
                            if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty &&
                                nameController.text.isNotEmpty &&
                                phoneController.text.isNotEmpty) {
                              SignupCubit.get(context).isEnabled = true;
                              SignupCubit.get(context).fillButtonColor();
                            } else {
                              SignupCubit.get(context).isEnabled = false;
                              SignupCubit.get(context).fillButtonColor();
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultTextField(
                          text: "Email",
                          controller: emailController,
                          prefix: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                          textForUnValid: "Enter your email",
                          onChanged: () {
                            if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty &&
                                nameController.text.isNotEmpty &&
                                phoneController.text.isNotEmpty) {
                              SignupCubit.get(context).isEnabled = true;
                              SignupCubit.get(context).fillButtonColor();
                            } else {
                              SignupCubit.get(context).isEnabled = false;
                              SignupCubit.get(context).fillButtonColor();
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultTextField(
                          text: "Password",
                          controller: passwordController,
                          prefix: Icons.lock_outline,
                          type: TextInputType.visiblePassword,
                          textForUnValid: "Enter you password ",
                          suffix: SignupCubit.get(context).isPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          suffixFunction: () =>
                              SignupCubit.get(context).changePasswordShow(),
                          isPassword: SignupCubit.get(context).isPassword,
                          onChanged: () {
                            if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty &&
                                nameController.text.isNotEmpty &&
                                phoneController.text.isNotEmpty) {
                              SignupCubit.get(context).isEnabled = true;
                              SignupCubit.get(context).fillButtonColor();
                            } else {
                              SignupCubit.get(context).isEnabled = false;
                              SignupCubit.get(context).fillButtonColor();
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        state is! SignupLoadingState ?
                        defaultMaterialButton(isEnabled: SignupCubit.get(context).isEnabled,
                                function: () {
                                  if (keyForm.currentState!.validate()) {
                                    SignupCubit.get(context).RegisterUser(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        password: passwordController.text);
                                    textFieldClear(nameController);
                                    textFieldClear(phoneController);
                                    textFieldClear(emailController);
                                    textFieldClear(passwordController);
                                  }
                                },
                                textButton: "Sign Up",
                                )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                        Row(children: [
                          defaultText(text: "Already have an account? "),
                          defaultTextButton(
                            widget: const LogIn(),
                            textButton: "LogIn here",
                            context: context),],),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        listener: (BuildContext context, SignupStates? state) {
          if (state is SignupSuccessState) {
              print("SSSState: ${state.signModel.status}");
            if (state.signModel.status?? true) {

              defaultSnackBarMaterial(context,fourthColor,state.signModel.message!);

                  navigateAndFinish(context,const LogIn());

            }else{
              defaultSnackBarMaterial(context,thirdColor,state.signModel.message!);
            }
          }
        },
      ),
    );
  }
}

void enableButton(context) {
  if (emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      nameController.text.isNotEmpty &&
      phoneController.text.isNotEmpty) {
    SignupCubit.get(context).isEnabled = true;
    SignupCubit.get(context).fillButtonColor();
  } else {
    SignupCubit.get(context).isEnabled = false;
    SignupCubit.get(context).fillButtonColor();
  }
}
