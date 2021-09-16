//@dart=2.9
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_chat/layout/social_app_layout/cubit/cubit.dart';
import 'package:social_chat/layout/social_app_layout/cubit/states.dart';
import 'package:social_chat/models/social_chat/social_chat_post_model.dart';
import 'package:social_chat/modules/on_nav_bar/settings/settings_screen.dart';
import 'package:social_chat/shared/components/components.dart';
import 'package:social_chat/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialChatCubit, SocialChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialChatCubit.get(context).posts.length > 0 &&
              SocialChatCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10.0,
                  margin: EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        fit: BoxFit.cover,
                        height: 200.0,
                        image: NetworkImage(
                            'https://image.freepik.com/free-photo/beautiful-stylish-asian-woman-takes-selfie-mobile-phone-makes-v-sign-smiles-has-positive-face-wears-orange-sunglasses-jacket-isolated-white-wall-modern-lifestyle_273609-49554.jpg'),
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.6),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                topLeft: Radius.circular(15.0),
                              )),
                          child: Text(
                            'communicate with friends',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(
                    SocialChatCubit.get(context).posts[index],
                    context,
                    index,
                  ),
                  itemCount: SocialChatCubit.get(context).posts.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10.0),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 4.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('${model.image}'),
                    ),
                    borderRadius: BorderRadius.circular(25.0),
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
                            InkWell(
                              borderRadius: BorderRadius.circular(25.0),
                              enableFeedback: false,focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {},
                              child: Text(
                                '${model.name}',
                                style: TextStyle(
                                  color: Colors.black,
                                  height: 1.4,
                                ),
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
                          '${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      size: 16.0,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Container(
                  height: 1.0,
                  color: Colors.black45,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${model.text}',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.black38),
                ),
              ),
              Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 0.0,
                      ),
                      child: Container(
                        height: 25.0,
                        child: MaterialButton(
                          onPressed: () {},
                          height: 25.0,
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#software',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.blue,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 0.0,
                      ),
                      child: Container(
                        height: 25.0,
                        child: MaterialButton(
                          onPressed: () {},
                          height: 25.0,
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#flutter',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.blue,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 10.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 160.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          '${model.postImage}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 18.0,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${SocialChatCubit.get(context).likes[index] + 1} Like',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.black45,
                                      fontSize: 12.0,
                                    ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 18.0,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                '${SocialChatCubit.get(context).comment[index] + 1} Comment',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.black45,
                                    ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: Container(
                  height: 1.0,
                  color: Colors.black45,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(
                                '${SocialChatCubit.get(context).userModel.image}'),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            'write a comment ...',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(height: 1.4, color: Colors.black45),
                          ),
                        ],
                      ),
                      onTap: () {
                        SocialChatCubit.get(context).commentPost(
                            SocialChatCubit.get(context).postsId[index]);
                        Fluttertoast.showToast(
                          msg: 'thanks for comment',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Colors.pink,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 18.0,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          'like',
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Colors.black45,
                              ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                      ],
                    ),
                    onTap: () {
                      SocialChatCubit.get(context).likePost(
                          SocialChatCubit.get(context).postsId[index]);
                      Fluttertoast.showToast(
                        msg: 'thanks for like ',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
