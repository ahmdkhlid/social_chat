//@dart=2.9
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chat/models/social_chat/social_chat_user_model.dart';
import 'package:social_chat/modules/register_screen/cubit/states.dart';

class SocialChatRegisterCubit extends Cubit<SocialChatRegisterStates> {
  SocialChatRegisterCubit() : super(SocialChatRegisterInitialState());

  static SocialChatRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String name,
    @required String email,
    @required String phone,
    @required String password,
  }) {
    emit(SocialChatRegisterLoadingState());
    FirebaseAuth.instance
      ..createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) {
        print(value.user.uid);
        userCreate(
          name: name,
          email: email,
          phone: phone,
          uId: value.user.uid,
        );
      }).catchError((error) {
        emit(SocialChatRegisterErrorState(error.toString()));
      });
  }

  void userCreate({
    @required String name,
    @required String email,
    @required String phone,
    @required String uId,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write your bio ...',
      image:
          'https://avatars.githubusercontent.com/u/79060943?v=4',
      cover:
      'https://image.freepik.com/free-photo/businessmen-working-strategic-planning_53876-97634.jpg',
      isEmailVerified: false,
    );
    emit(SocialChatRegisterLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialChatCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialChatCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialChatRegisterChangePasswordVisibilityState());
  }
}
