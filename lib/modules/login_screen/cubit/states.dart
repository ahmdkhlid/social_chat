//@dart=2.9

abstract class SocialChatLoginStates {}

class SocialChatLoginInitialState extends SocialChatLoginStates {}

class SocialChatLoginLoadingState extends SocialChatLoginStates {}

class SocialChatLoginSuccessState extends SocialChatLoginStates {
  final String uId;

  SocialChatLoginSuccessState(this.uId);
}

class SocialChatLoginErrorState extends SocialChatLoginStates {
  final String error;

  SocialChatLoginErrorState(this.error);
}

class SocialChatChangePasswordVisibilityState extends SocialChatLoginStates {}
