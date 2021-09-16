// @dart=2.9
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chat/layout/social_app_layout/cubit/cubit.dart';
import 'package:social_chat/layout/social_app_layout/cubit/states.dart';
import 'package:social_chat/models/social_chat/social_chat_message_model.dart';
import 'package:social_chat/models/social_chat/social_chat_user_model.dart';
import 'package:social_chat/shared/styles/colors.dart';
import 'package:social_chat/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  final UserModel userModel;
  ChatDetailsScreen({this.userModel});
  TextEditingController messageController = TextEditingController();
  var textKey = GlobalKey<EditableTextState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialChatCubit.get(context).getMessages(
          receiverId: userModel.uId,
        );
        return BlocConsumer<SocialChatCubit, SocialChatStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                elevation: 0.5,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    IconBroken.Arrow___Left_2,
                  ),
                ),
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 15.0,
                      backgroundImage: NetworkImage(
                        '${userModel.image}',
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      '${userModel.name}',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        height: 1.4,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialChatCubit.get(context).messages.length > 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message =
                                SocialChatCubit.get(context).messages[index];
                            if (SocialChatCubit.get(context).userModel.uId ==
                                message.senderId)
                              return buildMyMessage(message);
                            return buildMessage(message);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15.0,
                          ),
                          itemCount:
                              SocialChatCubit.get(context).messages.length,
                        ),
                      ),
                      if (SocialChatCubit.get(context).messageImage != null)
                        const SizedBox(height: 20.0),
                      if (SocialChatCubit.get(context).messageImage != null)
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
                                  image: FileImage(SocialChatCubit.get(context)
                                      .messageImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialChatCubit.get(context)
                                    .removeMessageImage();
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
                      if (state is SocialChatMessageImageLoadingState)
                        LinearProgressIndicator(),
                      if (state is SocialChatMessageImageLoadingState)
                        const SizedBox(height: 5.0),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey[300], width: 1.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: TextField(
                                key: textKey,
                                keyboardType: TextInputType.text,
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type a message ...',
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      SocialChatCubit.get(context)
                                          .getMessageImage();
                                    },
                                    icon: Icon(
                                      IconBroken.Image,
                                      color: Colors.grey,
                                      size: 18.0,
                                    ),
                                    iconSize: 10,
                                  ),
                                ),
                                Container(
                                  width: 30,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      SocialChatCubit.get(context)
                                          .getMessageImageCamera();
                                    },
                                    icon: Icon(
                                      IconBroken.Camera,
                                      color: Colors.grey,
                                      size: 18.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Container(
                                  width: 50,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {

                                      if (SocialChatCubit.get(context)
                                              .messageImage ==
                                          null) {
                                        SocialChatCubit.get(context)
                                            .sendMessages(
                                          receiverId: userModel.uId,
                                          text: messageController.text,
                                          dateTime: DateTime.now().toString(),
                                        );
                                        clearText();
                                        SocialChatCubit.get(context)
                                            .removeMessageImage();
                                      }
                                      else {
                                        SocialChatCubit.get(context)
                                            .uploadMessageImage(
                                          receiverId: userModel.uId,
                                          dateTime: DateTime.now().toString(),
                                        );
                                        SocialChatCubit.get(context)
                                            .sendMessages(
                                          receiverId: userModel.uId,
                                          text: messageController.text,
                                          dateTime: DateTime.now().toString(),
                                        );
                                        clearText();
                                        SocialChatCubit.get(context)
                                            .removeMessageImage();
                                      }
                                    },
                                    icon: Icon(
                                      IconBroken.Send,
                                      color: Colors.grey,
                                      size: 26.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey[300], width: 1.0),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: messageController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'type a message ...'),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 30,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            SocialChatCubit.get(context)
                                                .getMessageImage();
                                          },
                                          icon: Icon(
                                            IconBroken.Image,
                                            color: Colors.grey,
                                            size: 18.0,
                                          ),
                                          iconSize: 10,
                                        ),
                                      ),
                                      Container(
                                        width: 30,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            SocialChatCubit.get(context)
                                                .getMessageImageCamera();
                                          },
                                          icon: Icon(
                                            IconBroken.Camera,
                                            color: Colors.grey,
                                            size: 18.0,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Container(
                                        width: 50,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            if (SocialChatCubit.get(context)
                                                    .messageImage ==
                                                null) {
                                              SocialChatCubit.get(context)
                                                  .sendMessages(
                                                receiverId: userModel.uId,
                                                text: messageController.text,
                                                dateTime:
                                                    DateTime.now().toString(),
                                              );
                                              clearText();
                                              SocialChatCubit.get(context)
                                                  .removeMessageImage();
                                            } else {
                                              SocialChatCubit.get(context)
                                                  .uploadMessageImage(
                                                receiverId: userModel.uId,
                                                dateTime:
                                                    DateTime.now().toString(),
                                              );
                                              SocialChatCubit.get(context)
                                                  .sendMessages(
                                                receiverId: userModel.uId,
                                                text: messageController.text,
                                                dateTime:
                                                    DateTime.now().toString(),
                                              );
                                              clearText();
                                              SocialChatCubit.get(context)
                                                  .removeMessageImage();
                                            }
                                          },
                                          icon: Icon(
                                            IconBroken.Send,
                                            color: Colors.grey,
                                            size: 26.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void clearText() {
    messageController.clear();
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Column(
          children: [
            if (model.text != '')
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                child: Text(
                  model.text,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            if (model.messageImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 10.0,
                ),
                child: Container(
                  height: 200,
                  width: 300,
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.grey[300], width: 5.0),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${model.messageImage}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Column(
          children: [
            if (model.text != '')
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                child: Text(
                  model.text,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            if (model.messageImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 10.0,
                ),
                child: Container(
                  height: 200,
                  width: 300,
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[100], width: 5.0),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${model.messageImage}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
}
