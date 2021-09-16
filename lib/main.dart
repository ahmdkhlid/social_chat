//@dart=2.9
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chat/layout/social_app_layout/cubit/cubit.dart';
import 'package:social_chat/layout/social_app_layout/social_app_layout.dart';
import 'package:social_chat/modules/login_screen/login_screen.dart';
import 'package:social_chat/shared/bloc_observer.dart';
import 'package:social_chat/shared/components/components.dart';
import 'package:social_chat/shared/components/constants.dart';
import 'package:social_chat/shared/network/local/cache_helper.dart';
import 'package:social_chat/shared/network/remote/dio_helper.dart';
import 'package:social_chat/shared/styles/themes.dart';
import 'layout/social_app_layout/cubit/states.dart';
//  "/topics/topicName"
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print('on background message');

  showToast(
    text: 'on background message',
    state: ToastStates.SUCCESS,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  //foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    print('on message');
    showToast(
      text: 'on message',
      state: ToastStates.SUCCESS,
    );
  });
  //when click notification to open app

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    print('on message opened app');

    showToast(
      text: 'on message opened app',
      state: ToastStates.SUCCESS,
    );
  });
  //background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;

  bool isDark = CacheHelper.getData(key: 'isDark');
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = SocialChatLayout();
  } else {
    widget = SocialLoginScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SocialChatCubit()
              ..getUserData()
              ..getPosts())
      ],
      child: BlocConsumer<SocialChatCubit, SocialChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: SocialChatCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
