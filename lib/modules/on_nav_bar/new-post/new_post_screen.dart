//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_chat/layout/social_app_layout/cubit/cubit.dart';
import 'package:social_chat/layout/social_app_layout/cubit/states.dart';
import 'package:social_chat/layout/social_app_layout/social_app_layout.dart';
import 'package:social_chat/modules/on_nav_bar/feeds/feeds_screen.dart';
import 'package:social_chat/shared/components/components.dart';
import 'package:social_chat/shared/styles/colors.dart';
import 'package:social_chat/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  TextEditingController textController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialChatCubit, SocialChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              defaultTextButton(
                function: () {
                  var now = DateTime.now();
                  String formattedDate = DateFormat('yyyy-MM-dd ').format(now);
                  if (SocialChatCubit.get(context).postImage == null) {
                    SocialChatCubit.get(context).createPost(
                      dateTime: formattedDate.toString(),
                      text: textController.text,
                    );
                    navigateTo(context, SocialChatLayout());
                    SocialChatGetPostsLoadingState();
                    SocialChatCubit.get(context).getPosts();
                  } else {
                    SocialChatCubit.get(context).uploadPostImage(
                      dateTime: formattedDate.toString(),
                      text: textController.text,
                    );
                  }
                },
                text: 'Post',
                style:
                    Theme.of(context).textTheme.button.copyWith(fontSize: 18),
              ),
              const SizedBox(width: 5.0),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialChatCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialChatCreatePostLoadingState)
                  const SizedBox(height: 10.0),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/half-length-shot-curly-haired-afro-american-woman-good-physical-shape-wears-cropped-top-makes-peace-gesture-eye-smiles-broadly-isolated-orange-wall_273609-47770.jpg?size=338&ext=jpg'),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Ahmed Khaleld Belal',
                                style: TextStyle(
                                  color: Colors.black,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Icon(
                                Icons.verified,
                                color: Colors.blue,
                                size: 16.0,
                              )
                            ],
                          ),
                          Text(
                            'Public',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  height: 1.4,
                                  fontSize: 14,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'what is on your mind ...',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(fontSize: 18.0),
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 20.0),
                if (SocialChatCubit.get(context).postImage != null)
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 160.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                          image: DecorationImage(
                            image: FileImage(
                                SocialChatCubit.get(context).postImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          SocialChatCubit.get(context).removePostImage();
                        },
                        icon: CircleAvatar(
                          backgroundColor: defaultColor,
                          radius: 15.0,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocialChatCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              const SizedBox(width: 5.0),
                              Text('add photo')
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.User1),
                              const SizedBox(width: 5.0),
                              Text('#tags'),
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
