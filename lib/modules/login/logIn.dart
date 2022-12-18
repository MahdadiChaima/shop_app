import 'package:ap/layout/Shop/shop_layout_screen.dart';
import 'package:ap/modules/login/cubit/states.dart';
import 'package:ap/modules/signup/signUp.dart';
import 'package:ap/shared/components/components.dart';
import 'package:ap/shared/network/local/cacheHelper.dart';
import 'package:ap/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/constants.dart';
import 'cubit/cubit.dart';

var keyForm = GlobalKey<FormState>();
var emailController = TextEditingController();
var passwordController = TextEditingController();

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        builder: (BuildContext context, LoginStates? state) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                titleContainer(text: "Log In"),
                Padding(
                  padding: const EdgeInsets.only(top: 160, right: 40, left: 40),
                  child: Form(
                    key: keyForm,
                    child: Column(
                      children: [
                        defaultTextField(
                            onChanged: () {
                              if (emailController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty) {
                                LoginCubit.get(context).isEnabled = true;
                                LoginCubit.get(context).fillButtonColor();
                              } else {
                                LoginCubit.get(context).isEnabled = false;
                                LoginCubit.get(context).fillButtonColor();
                              }
                            },
                            text: "Email",
                            controller: emailController,
                            prefix: Icons.email_outlined,
                            type: TextInputType.emailAddress,
                            textForUnValid: "Enter you email "),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextField(
                            onChanged: () {
                              if (emailController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty) {
                                LoginCubit.get(context).isEnabled = true;
                                LoginCubit.get(context).fillButtonColor();
                              } else {
                                LoginCubit.get(context).isEnabled = false;
                                LoginCubit.get(context).fillButtonColor();
                              }
                            },
                            text: "Password",
                            controller: passwordController,
                            prefix: Icons.lock_outline,
                            type: TextInputType.visiblePassword,
                            textForUnValid: "Enter you password ",
                            suffix: LoginCubit.get(context).isPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            suffixFunction: () =>
                                LoginCubit.get(context).changePasswordShow(),
                            isPassword: LoginCubit.get(context).isPassword),
                        const SizedBox(
                          height: 60,
                        ),
                        state is! LoginLoadingState
                            ? defaultMaterialButton(
                                isEnabled: LoginCubit.get(context).isEnabled,
                                function: () {
                                  if (keyForm.currentState!.validate()) {
                                    LoginCubit.get(context).userData(
                                        email: emailController.text,
                                        password: passwordController.text);
                                    textFieldClear(emailController);
                                    textFieldClear(passwordController);

                                    //navigateAndFinish(context,const SignUp());
                                  }
                                },
                                textButton: "Log In")
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                        Container(
                          child: Row(children: [
                            defaultText(text: "Don't have an account? "),
                            defaultTextButton(
                                widget: const SignUp(),
                                textButton: "Register here",
                                context: context),],),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        listener: (BuildContext context, LoginStates? state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status ?? true) {
              defaultSnackBarMaterial(
                  context, fourthColor, state.loginModel.message!);
              token=state.loginModel.data?.token;
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data?.token)
                  .then((value) {
                if (value == true) {
                  navigateAndFinish(context, const ShopLayoutScreen());
                }
              });
            } else {
              defaultSnackBarMaterial(
                  context, thirdColor, state.loginModel.message!);
            }
          }
          if (state is LoginErrorState) {
            defaultSnackBarMaterial(context,Colors.redAccent,"No Internet Connection");

          }

        },
      ),
    );
  }
}
