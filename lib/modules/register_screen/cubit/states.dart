//@dart=2.9

abstract class SocialChatRegisterStates {}

class SocialChatRegisterInitialState extends SocialChatRegisterStates {}

class SocialChatRegisterLoadingState extends SocialChatRegisterStates {}

class SocialChatRegisterSuccessState extends SocialChatRegisterStates {

}

class SocialChatRegisterErrorState extends SocialChatRegisterStates {
  final String error;

  SocialChatRegisterErrorState(this.error);
}
class SocialChatCreateUserSuccessState extends SocialChatRegisterStates {

}

class SocialChatCreateUserErrorState extends SocialChatRegisterStates {
  final String error;

  SocialChatCreateUserErrorState(this.error);
}

class SocialChatRegisterChangePasswordVisibilityState extends SocialChatRegisterStates {}
