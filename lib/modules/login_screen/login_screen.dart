//@dart=2.9
import 'dart:ui';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chat/layout/social_app_layout/social_app_layout.dart';
import 'package:social_chat/modules/login_screen/cubit/cubit.dart';
import 'package:social_chat/modules/login_screen/cubit/states.dart';
import 'package:social_chat/modules/register_screen/register_screen.dart';
import 'package:social_chat/shared/components/components.dart';
import 'package:social_chat/shared/network/local/cache_helper.dart';
import 'package:social_chat/shared/styles/colors.dart';

// ignore: must_be_immutable
class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SocialChatLoginCubit(),
        child: BlocConsumer<SocialChatLoginCubit, SocialChatLoginStates>(
          listener: (context, state) {
            if (state is SocialChatLoginErrorState) {
              showToast(
                  text: state.error.toString(),
                  state: ToastStates.ERROR,
                 );
            }
            if (state is SocialChatLoginSuccessState) {
              CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
              ).then((value) {
                navigateAndFinish(
                  context,
                  SocialChatLayout(),
                );
              });
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50.0))),
                toolbarHeight: MediaQuery.of(context).size.height * .2,
                automaticallyImplyLeading: false,
                backgroundColor: defaultColor,
                elevation: 0,
                titleSpacing: 20.0,
                title: Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 100),
                    child: Text(
                      'Login Screen',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.white.withOpacity(0.9),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        defaultTextField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'E-mail',
                          prefix: Icons.email_outlined,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'e-mail must not be empty';
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        defaultTextField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Password is too short';
                            }
                          },
                          isPassword:
                              SocialChatLoginCubit.get(context).isPassword,
                          suffix: SocialChatLoginCubit.get(context).suffix,
                          suffixPressed: () {
                            SocialChatLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          onSubmit: (value) {
                            if (formKey.currentState.validate()) {
                              SocialChatLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 30.0),
                        ConditionalBuilder(
                          condition: state is! SocialChatLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                SocialChatLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'LOGIN',
                            background: Colors.blueGrey,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "don't have an account?",
                              style: TextStyle(color: defaultColor),
                            ),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, SocialRegisterScreen());
                                },
                                text: 'REGISTER')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
