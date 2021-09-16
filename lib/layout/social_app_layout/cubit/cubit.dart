//@dart=2.9
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_chat/layout/social_app_layout/cubit/states.dart';
import 'package:social_chat/models/social_chat/social_chat_message_model.dart';
import 'package:social_chat/models/social_chat/social_chat_post_model.dart';
import 'package:social_chat/models/social_chat/social_chat_user_model.dart';
import 'package:social_chat/modules/on_nav_bar/chats/chats_screen.dart';
import 'package:social_chat/modules/on_nav_bar/feeds/feeds_screen.dart';
import 'package:social_chat/modules/on_nav_bar/new-post/new_post_screen.dart';
import 'package:social_chat/modules/on_nav_bar/settings/settings_screen.dart';
import 'package:social_chat/modules/on_nav_bar/users/users_screen.dart';
import 'package:social_chat/shared/components/constants.dart';
import 'package:social_chat/shared/network/local/cache_helper.dart';
import 'package:social_chat/shared/styles/icon_broken.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialChatCubit extends Cubit<SocialChatStates> {
  SocialChatCubit() : super(SocialChatInitialState());
  static SocialChatCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  ThemeMode appTheme = ThemeMode.dark;
  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;

      emit(SocialChatChangeAppMode());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(SocialChatChangeAppMode());
      });
    }
  }

  int currentIndex = 0;
  List<String> titles = [
    'Home',
    'Chats',
    'New Post',
    'Users',
    'Profile',
  ];
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    ProfileScreen(),
  ];
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Home),
      label: 'Feeds',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Chat),
      label: 'Chats',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Plus),
      label: 'Post',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Location),
      label: 'Users',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Profile),
      label: 'Profile',
    ),
  ];

  void changeBottom(int index) {
    if (index == 1) {
      getAllUsers();
      getMessages(receiverId: userModel.uId);
    }
    if (index == 2)
      emit(ShopChatNewPostState());
    else {
      currentIndex = index;
      emit(SocialChatChangeBottomNavState());
    }
  }

  UserModel userModel;

  void getUserData() {
    emit(SocialChatGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(SocialChatGetUserSuccessState());
      print(userModel.uId);
    }).catchError((error) {
      emit(SocialChatGetUserErrorState(error.toString()));
    });
  }

  var imagePicker = ImagePicker();

  File profileImage;
  Future<void> getProfileImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialChatProfileImagePickedSuccessState());
    } else {
      emit(SocialChatProfileImagePickedErrorState());
      return 'no image selected';
    }
  }

  File coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(pickedFile.path.toString());

      emit(SocialChatCoverImagePickedSuccessState());
    } else {
      emit(SocialChatCoverImagePickedErrorState());
      return 'no image selected';
    }
  }

  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(SocialChatUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'users/${Uri.file(profileImage.path).pathSegments.last}',
        )
        .putFile(profileImage)
        .then((value) {
      print(value);
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
        emit(SocialChatUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialChatUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialChatUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(SocialChatUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'users/${Uri.file(coverImage.path).pathSegments.last}',
        )
        .putFile(coverImage)
        .then((value) {
      print(value);
      value.ref.getDownloadURL().then((value) {
        print(value);

        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
        emit(SocialChatUploadCoverImageSuccessState());
      }).catchError((error) {
        // emit(SocialChatUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialChatUploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   @required String name,
  //   @required String phone,
  //   @required String bio,
  // }) {
  //   print(userModel.uId);
  //
  //   emit(SocialChatUserUpdateLoadingState());
  //   if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null && coverImage != null) {
  //     uploadProfileImage();
  //     uploadCoverImage();
  //   } else {
  //    updateUser(
  //      name: name,
  //      phone: phone,
  //      bio: bio,
  //    );
  //   }
  // }

  void updateUser({
    @required String name,
    @required String phone,
    @required String bio,
    String image,
    String cover,
  }) {
    emit(SocialChatUploadCoverImageSuccessState());
    emit(SocialChatUploadProfileImageSuccessState());
    emit(SocialChatUserUpdateLoadingState());
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      uId: userModel.uId,
      cover: cover ?? userModel.cover,
      image: image ?? userModel.image,
      email: userModel.email,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialChatUserUpdateErrorState());
    });
  }

  File postImage;
  Future<void> getPostImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialChatPostImagePickedSuccessState());
    } else {
      emit(SocialChatPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialChatRemovePostImageState());
  }

  void uploadPostImage({
    @required String dateTime,
    @required String text,
  }) {
    emit(SocialChatCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'posts/${Uri.file(postImage.path).pathSegments.last}',
        )
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialChatCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialChatCreatePostErrorState());
    });
  }

  PostModel postModel;
  void createPost({
    @required String dateTime,
    @required String text,
    String postImage,
  }) {
    emit(SocialChatCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel.name,
      uId: userModel.uId,
      image: userModel.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialChatCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialChatCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comment = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          comment.add(value.docs.length);
          postsId.add(element.id);

          posts.add(
            PostModel.fromJson(element.data()),
          );
        }).catchError((error) {});
      });
      emit(SocialChatGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialChatGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialChatLikePostsSuccessState());
    }).catchError((error) {
      emit(SocialChatLikePostsErrorState(error.toString()));
    });
  }

  void commentPost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel.uId)
        .set({
      'comment': true,
    }).then((value) {
      emit(SocialChatCommentPostsSuccessState());
    }).catchError((error) {
      emit(SocialChatCommentPostsErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];
  void getAllUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel.uId)
            users.add(UserModel.fromJson(element.data()));
        });
        emit(SocialChatGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialChatGetAllUsersErrorState(error.toString()));
      });
  }

  MessageModel messageModel;

  void sendMessages({
    @required String receiverId,
    String text,
    @required String dateTime,
    String messageImage,
  }) {
    MessageModel model = MessageModel(
      text: text ?? '',
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: userModel.uId,
      messageImage: messageImage ?? '',
    );
//set my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialChatSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialChatSendMessageErrorState());
    });
//set other chat

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialChatSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialChatSendMessageErrorState());
    });
  }

  List<MessageModel> messages;

  void getMessages({
    @required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialChatGetMessageSuccessState());
    });
  }

//camera image
  Future<void> getMessageImageCamera() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      messageImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialChatMessageImageSuccessState());
    } else {
      emit(SocialChatMessageImageErrorState());
    }
  }

  File messageImage;
  Future<void> getMessageImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      messageImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialChatPostImagePickedSuccessState());
    } else {
      emit(SocialChatPostImagePickedErrorState());
    }
  }

  void uploadMessageImage({
    @required String receiverId,
    @required String dateTime,
    String text,
  }) {
    emit(SocialChatMessageImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'users/${Uri.file(messageImage.path).pathSegments.last}',
        )
        .putFile(messageImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        sendMessages(
          text: text,
          receiverId: receiverId,
          dateTime: dateTime,
          messageImage: value,
        );
        emit(SocialChatMessageImageLoadingState());
      }).catchError((error) {
        emit(SocialChatMessageImageErrorState());
      });
    }).catchError((error) {
      emit(SocialChatMessageImageErrorState());
    });
  }

  void removeMessageImage() {
    messageImage = null;
    emit(SocialChatRemoveMessageImageState());
  }
}
