//@dart=2.9
import 'dart:ui';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chat/layout/social_app_layout/social_app_layout.dart';
import 'package:social_chat/modules/login_screen/login_screen.dart';
import 'package:social_chat/modules/register_screen/cubit/cubit.dart';
import 'package:social_chat/modules/register_screen/cubit/states.dart';
import 'package:social_chat/shared/components/components.dart';
import 'package:social_chat/shared/styles/colors.dart';

// ignore: must_be_immutable
class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SocialChatRegisterCubit(),
        child: BlocConsumer<SocialChatRegisterCubit, SocialChatRegisterStates>(
          listener: (context, state) {
            if (state is SocialChatCreateUserSuccessState) {
              navigateAndFinish(
                context,
                SocialChatLayout(),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(50.0))),
                automaticallyImplyLeading: false,
                toolbarHeight: MediaQuery.of(context).size.height * .2,
                backgroundColor: defaultColor,
                elevation: 0,
                titleSpacing: 20.0,
                title: Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 100),
                    child: Text(
                      'Register Screen',
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
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'Name',
                          prefix: Icons.person_outlined,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'name must not be empty';
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
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
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone Number',
                          prefix: Icons.phone_outlined,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'phone number must not be empty';
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
                              SocialChatRegisterCubit.get(context).isPassword,
                          suffix: SocialChatRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            SocialChatRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          onSubmit: (value) {
                            if (formKey.currentState.validate()) {
                              SocialChatRegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                                name: nameController.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 30.0),
                        ConditionalBuilder(
                          condition: state is! SocialChatRegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                SocialChatRegisterCubit.get(context)
                                    .userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'REGISTER',
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'already have an account!',
                              style: TextStyle(color: defaultColor),
                            ),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, SocialLoginScreen());
                                },
                                text: 'LOGIN')
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
