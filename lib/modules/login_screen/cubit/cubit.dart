//@dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chat/modules/login_screen/cubit/states.dart';

class SocialChatLoginCubit extends Cubit<SocialChatLoginStates> {
  SocialChatLoginCubit() : super(SocialChatLoginInitialState());

  static SocialChatLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(SocialChatLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(SocialChatLoginSuccessState(value.user.uid));
    }).catchError((error) {
      emit(SocialChatLoginErrorState(error.toString()));
      print(error.toString());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialChatChangePasswordVisibilityState());
  }
}
