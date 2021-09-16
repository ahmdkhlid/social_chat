//https://newsapi.org/everything?q=tesla&apiKey=da745ac90cbc4106a8fa6fe501087179
//@dart=2.9

import 'package:social_chat/modules/login_screen/login_screen.dart';
import 'package:social_chat/shared/components/components.dart';
import 'package:social_chat/shared/network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(
        context,
        SocialLoginScreen(),
      );
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach(
        (match) => print(
          match.group(0),
        ),
      );
}


String token = '';
String uId = '';