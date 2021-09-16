//@dart=2.9
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chat/layout/social_app_layout/cubit/cubit.dart';
import 'package:social_chat/layout/social_app_layout/cubit/states.dart';
import 'package:social_chat/models/social_chat/social_chat_post_model.dart';
import 'package:social_chat/models/social_chat/social_chat_user_model.dart';
import 'package:social_chat/modules/on_nav_bar/chat_details/chat_details_screen.dart';
import 'package:social_chat/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialChatCubit, SocialChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        UserModel model;
        return ConditionalBuilder(
          condition: SocialChatCubit.get(context).users.length > 0,
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem(
                      SocialChatCubit.get(context).users[index],
                      context,
                    ),
                separatorBuilder: (context, index) => SizedBox(height: 0.0),
                itemCount: SocialChatCubit.get(context).users.length),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(UserModel model, context) => InkWell(
        onTap: () {
          navigateTo(context, ChatDetailsScreen(userModel: model,));
        },
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('${model.image}'),
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
                                '${model.name}',
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
                            '${model.uId}',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(height: 1.4),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        size: 18.0,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
