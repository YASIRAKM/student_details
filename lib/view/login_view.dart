import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_details/controller/auth_controller.dart';
import 'package:student_details/utils/constants/themes/app_color.dart';
import 'package:student_details/utils/constants/themes/app_text_styles.dart';
import 'package:student_details/utils/constants/validators.dart';

import '../utils/widgets/new_elevated_button.dart';
import '../utils/widgets/new_icon_text_column.dart';
import '../utils/widgets/new_text_form_field.dart';
import '../utils/widgets/password_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.only(
            top: ht * .02, left: wt * .1, right: wt * .1, bottom: ht * .03),
        child: Form(
            key: formKey,
            child: Consumer<AuthController>(
                builder: (context, authController, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: ht * .05),
                      child: SizedBox(
                        height: ht * .27,
                        child: Lottie.asset("assets/sign_in.json"),
                      ),
                    ),
                    SizedBox(
                      height: ht * .0002,
                    ),
                    NewTextFieldWidget(
                      controller: authController.emailController,
                      labelText: 'E mail',
                      iconData: Icons.mail,
                      validator: MyValidator.validateEmail,
                      keyBoardType: TextInputType.emailAddress,
                      dark: false,
                    ),
                    SizedBox(
                      height: ht * .02,
                    ),
                    NewTextFormFieldPasswordWidget(
                        obscure: authController.isVisible,
                        controller: authController.passwordController,
                        iconButton: authController.isVisible
                            ? IconButton(
                                onPressed: () {
                                  authController.visibleChange();
                                },
                                icon: Icon(CupertinoIcons.eye,
                                    color: AppColor.lightColor))
                            : IconButton(
                                onPressed: () {
                                  authController.visibleChange();
                                },
                                icon: Icon(
                                  CupertinoIcons.eye_slash,
                                  color: AppColor.lightColor,
                                ))),
                    SizedBox(
                      height: ht * .02,
                    ),
                    Padding(
                        padding:
                            EdgeInsets.only(left: wt * .15, right: wt * .15),
                        child: authController.isLogin
                            ? NewElevatedButtonWidget(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    authController.createAuth(context);
                                    authController.emailController.clear();
                                    authController.passwordController.clear();
                                  }
                                },
                                buttonText: 'Sign Up',
                                dark: true,
                              )
                            : NewElevatedButtonWidget(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    authController.loginAuth(context);
                                    authController.emailController.clear();
                                    authController.passwordController.clear();
                                  }
                                },
                                buttonText: 'Login',
                                dark: true,
                              )),
                    SizedBox(
                      height: ht * .01,
                    ),
                    authController.isLogin
                        ? TextButton(
                            onPressed: () {
                              authController.boolChange();
                            },
                            child: const Text("have account!!"))
                        : TextButton(
                            onPressed: () {
                              authController.boolChange();
                            },
                            child: const Text("Don't have an account?")),
                    const Divider(),
                    Padding(
                      padding: EdgeInsets.only(
                          left: wt * .05, right: wt * .05, top: ht * .02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          NewIconColumnTextWidget(ht: ht, iconData: MdiIcons.google, wt: wt, type: 'GOOGLE', onTap: () {
                            authController.signInWithGoogle(context);
                          },),

                          const VerticalDivider(),
                          NewIconColumnTextWidget(
                            ht: ht,
                            iconData: Icons.phone_android_outlined,
                            wt: wt,
                            type: 'PHONE',
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: ht * .3,
                                        bottom: ht * .3,
                                        left: wt * .05,
                                        right: wt * .05),
                                    child: Card(
                                      color: AppColor.appBarColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: ht * .07,
                                                left: wt * .02,
                                                right: wt * .02),
                                            child: NewTextFieldWidget(
                                              controller: authController
                                                  .phoneNumberController,
                                              keyBoardType: TextInputType.phone,
                                              validator:
                                                  MyValidator.validatePhone,
                                              labelText: 'Phone Number',
                                              iconData: Icons.numbers_outlined,
                                              dark: false,
                                            ),
                                          ),
                                          SizedBox(
                                            height: ht * .05,
                                          ),
                                          NewElevatedButtonWidget(
                                            onPressed: () {
                                              authController.signInWithMobile(
                                                  "+91 ${authController.phoneNumberController.text}",
                                                  context);
                                            },
                                            buttonText: 'Verify Number',
                                            dark: true,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            })),
      ),
    );
  }
}


