//@dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chat/layout/social_app_layout/cubit/cubit.dart';
import 'package:social_chat/layout/social_app_layout/cubit/states.dart';
import 'package:social_chat/modules/notfications/notifications_screen.dart';
import 'package:social_chat/modules/on_nav_bar/new-post/new_post_screen.dart';
import 'package:social_chat/modules/search/search_screen.dart';
import 'package:social_chat/shared/components/components.dart';
import 'package:social_chat/shared/styles/icon_broken.dart';

class SocialChatLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialChatCubit, SocialChatStates>(
        listener: (context, state) {
      if (state is ShopChatNewPostState) {
        navigateTo(
          context,
          NewPostScreen(),
        );
      }
    }, builder: (context, state) {
      var cubit = SocialChatCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          elevation: 1.0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          title: Text(
            cubit.titles[cubit.currentIndex],
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  navigateTo(context, NotificationsScreen());
                },
                icon: Icon(IconBroken.Notification)),
            IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(IconBroken.Search)),
            const SizedBox(
              width: 10.0,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          onTap: (index) {
            cubit.changeBottom(index);
          },
          items: cubit.bottomItems,
        ),
        body: cubit.screens[cubit.currentIndex],
      );
    });
  }
}

/// email verfication
//  if (1 > 2)
// Padding(
//   padding: const EdgeInsets.all(5.0),
//   child: Container(
//     height: 28.0,
//     decoration: BoxDecoration(
//         color: Colors.amber.withOpacity(0.6),
//         borderRadius: BorderRadius.circular(10)),
//     width: double.infinity,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           Icons.warning_outlined,
//           size: 20,
//           color: Colors.red,
//         ),
//         const SizedBox(
//           width: 5,
//         ),
//         Text(
//           'please verify your email',
//           style: Theme.of(context).textTheme.headline6,
//         ),
//         defaultTextButton(
//           text: 'send email verfication',
//           function: () {
//             FirebaseAuth.instance.currentUser
//                 .sendEmailVerification()
//                 .then((value) {
//               showToast(
//                   text: 'check your mail',
//                   state: ToastStates.SUCCESS);
//             }).catchError((error) {
//               showToast(
//                   text: error.toString(),
//                   state: ToastStates.ERROR);
//             });
//           },
//           style:
//               Theme.of(context).textTheme.button.copyWith(
//                     color: defaultColor,
//                   ),
//         ),
//       ],
//     ),
//   ),
// )

//  ConditionalBuilder(
//               condition: SocialChatCubit.get(context).model != null,
//               builder: (context) {
//                 // ignore: unused_local_variable
//                 var model = SocialChatCubit.get(context).model;
//                 return Column(
//                   children: [],
//                 );
//               },
//               fallback: (context) => Center(child: CircularProgressIndicator()),
//             ),
