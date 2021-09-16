//@dart=2.9
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chat/layout/social_app_layout/cubit/cubit.dart';
import 'package:social_chat/layout/social_app_layout/cubit/states.dart';
import 'package:social_chat/shared/components/components.dart';
import 'package:social_chat/shared/styles/colors.dart';
import 'package:social_chat/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialChatCubit, SocialChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // void updateUserProfile() {
        //   SocialChatCubit.get(context).uploadCoverImage(
        //       name: nameController.text,
        //       phone: phoneController.text,
        //       bio: bioController.text);
        //   SocialChatCubit.get(context).uploadProfileImage(
        //       name: nameController.text,
        //       phone: phoneController.text,
        //       bio: bioController.text);
        //   SocialChatCubit.get(context).updateUser(
        //       name: nameController.text,
        //       phone: phoneController.text,
        //       bio: bioController.text);
        // }

        var userModel = SocialChatCubit.get(context).userModel;
        var profileImage = SocialChatCubit.get(context).profileImage;
        var coverImage = SocialChatCubit.get(context).coverImage;
        nameController.text = userModel.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                function: () {
                  SocialChatCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                  SocialChatCubit.get(context).uploadProfileImage(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                  SocialChatCubit.get(context).uploadCoverImage(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                text: 'UPDATE',
                style:
                    Theme.of(context).textTheme.button.copyWith(fontSize: 18),
              ),
              const SizedBox(width: 5.0),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialChatUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if (state is SocialChatUserUpdateLoadingState)
                    const SizedBox(height: 20.0),
                  Container(
                    height: 220,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 160.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage(
                                            '${userModel.cover}',
                                          )
                                        : FileImage(coverImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialChatCubit.get(context).getCoverImage();
                                },
                                icon: CircleAvatar(
                                  backgroundColor: defaultColor,
                                  radius: 15.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              radius: 66.0,
                              child: CircleAvatar(
                                radius: 62.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profileImage),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialChatCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                backgroundColor: defaultColor,
                                radius: 15.0,
                                child: Icon(
                                  IconBroken.Camera,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (SocialChatCubit.get(context).profileImage != null ||
                      SocialChatCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialChatCubit.get(context).profileImage != null &&
                            SocialChatCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    SocialChatCubit.get(context)
                                        .uploadCoverImage(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            bio: bioController.text);
                                    SocialChatCubit.get(context)
                                        .uploadProfileImage(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            bio: bioController.text);
                                    SocialChatCubit.get(context).updateUser(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  text: 'UPDATE ',
                                ),
                                if (state is SocialChatUserUpdateLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is SocialChatUserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        if (SocialChatCubit.get(context).profileImage != null &&
                            SocialChatCubit.get(context).coverImage == null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    SocialChatCubit.get(context)
                                        .uploadProfileImage(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            bio: bioController.text);
                                    SocialChatCubit.get(context).updateUser(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  text: 'UPDATE PROFILE',
                                ),
                                if (state is SocialChatUserUpdateLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is SocialChatUserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (SocialChatCubit.get(context).coverImage != null &&
                            SocialChatCubit.get(context).profileImage == null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    SocialChatCubit.get(context)
                                        .uploadCoverImage(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            bio: bioController.text);

                                    SocialChatCubit.get(context).updateUser(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  text: 'UPDATE COVER',
                                ),
                                if (state is SocialChatUserUpdateLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is SocialChatUserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (SocialChatCubit.get(context).profileImage != null ||
                      SocialChatCubit.get(context).coverImage != null)
                    const SizedBox(height: 20.0),
                  defaultTextField(
                    controller: nameController,
                    radius: 10.0,
                    type: TextInputType.name,
                    label: 'Name',
                    prefix: IconBroken.Profile,
                    validate: (String value) {
                      if (value.isEmpty) return 'please type something';
                    },
                  ),
                  const SizedBox(height: 10.0),
                  defaultTextField(
                    controller: bioController,
                    radius: 10.0,
                    type: TextInputType.text,
                    label: 'Bio',
                    prefix: IconBroken.Info_Square,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'please type something';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  defaultTextField(
                    controller: phoneController,
                    radius: 10.0,
                    type: TextInputType.text,
                    label: 'Phone',
                    prefix: IconBroken.Call,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'please type something';
                      }
                      return null;
                    },
                  ),

                  // if (state is SocialChatUserUpdateLoadingState &&
                  //     (SocialChatCubit.get(context).profileImage != null ||
                  //         SocialChatCubit.get(context).profileImage != null))
                  //   defaultButton(
                  //       text: 'Update Profile',
                  //       function: () {
                  //         SocialChatCubit.get(context).uploadProfileImage(
                  //             name: nameController.text,
                  //             phone: phoneController.text,
                  //             bio: bioController.text);
                  //       }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
