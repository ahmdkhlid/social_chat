//@dart=2.9

abstract class SocialChatStates {}

//appStates
class SocialChatInitialState extends SocialChatStates {}

class SocialChatLoadingState extends SocialChatStates {}

class SocialChatSuccessState extends SocialChatStates {}

class SocialChatErrorState extends SocialChatStates {
  final String error;
  SocialChatErrorState(this.error);
}

// GetUser
class SocialChatGetUserLoadingState extends SocialChatStates {}

class SocialChatGetUserSuccessState extends SocialChatStates {}

class SocialChatGetUserErrorState extends SocialChatStates {
  final String error;
  SocialChatGetUserErrorState(this.error);
}
// GetAllUsers
class SocialChatGetAllUsersLoadingState extends SocialChatStates {}

class SocialChatGetAllUsersSuccessState extends SocialChatStates {}

class SocialChatGetAllUsersErrorState extends SocialChatStates {
  final String error;
  SocialChatGetAllUsersErrorState(this.error);
}


// GetPost
class SocialChatGetPostsLoadingState extends SocialChatStates {}

class SocialChatGetPostsSuccessState extends SocialChatStates {}

class SocialChatGetPostsErrorState extends SocialChatStates {
  final String error;
  SocialChatGetPostsErrorState(this.error);
}

// LikePost
class SocialChatLikePostsLoadingState extends SocialChatStates {}

class SocialChatLikePostsSuccessState extends SocialChatStates {}

class SocialChatLikePostsErrorState extends SocialChatStates {
  final String error;
  SocialChatLikePostsErrorState(this.error);
}
// CommentPost
class SocialChatCommentPostsLoadingState extends SocialChatStates {}

class SocialChatCommentPostsSuccessState extends SocialChatStates {}

class SocialChatCommentPostsErrorState extends SocialChatStates {
  final String error;
  SocialChatCommentPostsErrorState(this.error);
}

// upload profile
class SocialChatProfileImagePickedSuccessState extends SocialChatStates {}

class SocialChatProfileImagePickedErrorState extends SocialChatStates {}

class SocialChatUploadProfileImageSuccessState extends SocialChatStates {}

class SocialChatUploadProfileImageErrorState extends SocialChatStates {}

// upload cover
class SocialChatCoverImagePickedSuccessState extends SocialChatStates {}

class SocialChatCoverImagePickedErrorState extends SocialChatStates {}

class SocialChatUploadCoverImageSuccessState extends SocialChatStates {}

class SocialChatUploadCoverImageErrorState extends SocialChatStates {}

// UserUpdate
class SocialChatUserUpdateLoadingState extends SocialChatStates {}

class SocialChatUserUpdateErrorState extends SocialChatStates {}

//create post
class ShopChatNewPostState extends SocialChatStates {}

class SocialChatCreatePostLoadingState extends SocialChatStates {}

class SocialChatCreatePostSuccessState extends SocialChatStates {}

class SocialChatCreatePostErrorState extends SocialChatStates {}

class SocialChatPostImagePickedSuccessState extends SocialChatStates {}

class SocialChatRemovePostImageState extends SocialChatStates {}

class SocialChatPostImagePickedErrorState extends SocialChatStates {}

// navBar
class SocialChatChangeBottomNavState extends SocialChatStates {}

//appMode
class SocialChatChangeAppMode extends SocialChatStates {}

//chat
class SocialChatSendMessageSuccessState extends SocialChatStates {}

class SocialChatSendMessageErrorState extends SocialChatStates {}

class SocialChatGetMessageSuccessState extends SocialChatStates {}

class SocialChatGetMessageErrorState extends SocialChatStates {}
class SocialChatMessageImageLoadingState extends SocialChatStates {}
class SocialChatMessageImageSuccessState extends SocialChatStates {}
class SocialChatMessageImageErrorState extends SocialChatStates {}
class SocialChatRemoveMessageImageState extends SocialChatStates {}


