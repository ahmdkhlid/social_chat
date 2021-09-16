// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:udemy_flutter/layout/social_app/cubit/cubit.dart';
// import 'package:udemy_flutter/layout/social_app/cubit/states.dart';
// import 'package:udemy_flutter/shared/components/components.dart';
// import 'package:udemy_flutter/shared/styles/icon_broken.dart';
//
// class EditProfileScreen extends StatelessWidget {
//   var nameController = TextEditingController();
//   var phoneController = TextEditingController();
//   var bioController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SocialCubit, SocialStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var userModel = SocialCubit.get(context).userModel;
//         var profileImage = SocialCubit.get(context).profileImage;
//         var coverImage = SocialCubit.get(context).coverImage;
//
//         nameController.text = userModel.name;
//         phoneController.text = userModel.phone;
//         bioController.text = userModel.bio;
//
//         return Scaffold(
//           appBar: defaultAppBar(
//             context: context,
//             title: 'Edit Profile',
//             actions: [
//               defaultTextButton(
//                 function: () {
//                   SocialCubit.get(context).updateUser(
//                       name: nameController.text,
//                       phone: phoneController.text,
//                       bio: bioController.text);
//                 },
//                 text: 'Update',
//               ),
//               SizedBox(
//                 width: 15.0,
//               ),
//             ],
//           ),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   if (state is SocialUserUpdateLoadingState)
//                     LinearProgressIndicator(),
//                   if (state is SocialUserUpdateLoadingState)
//                     SizedBox(
//                       height: 10.0,
//                     ),
//                   Container(
//                     height: 190.0,
//                     child: Stack(
//                       alignment: AlignmentDirectional.bottomCenter,
//                       children: [
//                         Align(
//                           child: Stack(
//                             alignment: AlignmentDirectional.topEnd,
//                             children: [
//                               Container(
//                                 height: 140.0,
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(
//                                       4.0,
//                                     ),
//                                     topRight: Radius.circular(
//                                       4.0,
//                                     ),
//                                   ),
//                                   image: DecorationImage(
//                                     image: coverImage == null
//                                         ? NetworkImage(
//                                       '${userModel.cover}',
//                                     )
//                                         : FileImage(coverImage),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               IconButton(
//                                 icon: CircleAvatar(
//                                   radius: 20.0,
//                                   child: Icon(
//                                     IconBroken.Camera,
//                                     size: 16.0,
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   SocialCubit.get(context).getCoverImage();
//                                 },
//                               ),
//                             ],
//                           ),
//                           alignment: AlignmentDirectional.topCenter,
//                         ),
//                         Stack(
//                           alignment: AlignmentDirectional.bottomEnd,
//                           children: [
//                             CircleAvatar(
//                               radius: 64.0,
//                               backgroundColor:
//                               Theme.of(context).scaffoldBackgroundColor,
//                               child: CircleAvatar(
//                                 radius: 60.0,
//                                 backgroundImage: profileImage == null
//                                     ? NetworkImage(
//                                   '${userModel.image}',
//                                 )
//                                     : FileImage(profileImage),
//                               ),
//                             ),
//                             IconButton(
//                               icon: CircleAvatar(
//                                 radius: 20.0,
//                                 child: Icon(
//                                   IconBroken.Camera,
//                                   size: 16.0,
//                                 ),
//                               ),
//                               onPressed: () {
//                                 SocialCubit.get(context).getProfileImage();
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   if (SocialCubit.get(context).profileImage != null ||
//                       SocialCubit.get(context).coverImage != null)
//                     Row(
//                       children: [
//                         if (SocialCubit.get(context).profileImage != null)
//                           Expanded(
//                             child: Column(
//                               children: [
//                                 defaultButton(
//                                   function: () {
//                                     SocialCubit.get(context).uploadProfileImage(
//                                       name: nameController.text,
//                                       phone: phoneController.text,
//                                       bio: bioController.text,
//                                     );
//                                   },
//                                   text: 'upload profile',
//                                 ),
//                                 if (state is SocialUserUpdateLoadingState)
//                                   SizedBox(
//                                     height: 5.0,
//                                   ),
//                                 if (state is SocialUserUpdateLoadingState)
//                                   LinearProgressIndicator(),
//                               ],
//                             ),
//                           ),
//                         SizedBox(
//                           width: 5.0,
//                         ),
//                         if (SocialCubit.get(context).coverImage != null)
//                           Expanded(
//                             child: Column(
//                               children: [
//                                 defaultButton(
//                                   function: ()
//                                   {
//                                     SocialCubit.get(context).uploadCoverImage(
//                                       name: nameController.text,
//                                       phone: phoneController.text,
//                                       bio: bioController.text,
//                                     );
//                                   },
//                                   text: 'upload cover',
//                                 ),
//                                 if (state is SocialUserUpdateLoadingState)
//                                   SizedBox(
//                                     height: 5.0,
//                                   ),
//                                 if (state is SocialUserUpdateLoadingState)
//                                   LinearProgressIndicator(),
//                               ],
//                             ),
//                           ),
//                       ],
//                     ),
//                   if (SocialCubit.get(context).profileImage != null ||
//                       SocialCubit.get(context).coverImage != null)
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                   defaultFormField(
//                     controller: nameController,
//                     type: TextInputType.name,
//                     validate: (String value) {
//                       if (value.isEmpty) {
//                         return 'name must not be empty';
//                       }
//
//                       return null;
//                     },
//                     label: 'Name',
//                     prefix: IconBroken.User,
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   defaultFormField(
//                     controller: bioController,
//                     type: TextInputType.text,
//                     validate: (String value) {
//                       if (value.isEmpty) {
//                         return 'bio must not be empty';
//                       }
//
//                       return null;
//                     },
//                     label: 'Bio',
//                     prefix: IconBroken.Info_Circle,
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   defaultFormField(
//                     controller: phoneController,
//                     type: TextInputType.phone,
//                     validate: (String value) {
//                       if (value.isEmpty) {
//                         return 'phone number must not be empty';
//                       }
//
//                       return null;
//                     },
//                     label: 'Phone',
//                     prefix: IconBroken.Call,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// // import 'dart:ui';
// // import 'package:conditional_builder/conditional_builder.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:udemy_flutter/layout/social_app/cubit/cubit.dart';
// // import 'package:udemy_flutter/layout/social_app/cubit/states.dart';
// // import 'package:udemy_flutter/models/social_app/post_model.dart';
// // import 'package:udemy_flutter/shared/styles/colors.dart';
// // import 'package:udemy_flutter/shared/styles/icon_broken.dart';
// //
// // class FeedsScreen extends StatelessWidget
// // {
// //   @override
// //   Widget build(BuildContext context)
// //   {
// //     return BlocConsumer<SocialCubit, SocialStates>(
// //       listener: (context, state) {},
// //       builder: (context, state)
// //       {
// //         return ConditionalBuilder(
// //           condition: SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).userModel != null,
// //           builder: (context) => SingleChildScrollView(
// //             physics: BouncingScrollPhysics(),
// //             child: Column(
// //               children:
// //               [
// //                 Card(
// //                   clipBehavior: Clip.antiAliasWithSaveLayer,
// //                   elevation: 5.0,
// //                   margin: EdgeInsets.all(
// //                     8.0,
// //                   ),
// //                   child: Stack(
// //                     alignment: AlignmentDirectional.bottomEnd,
// //                     children: [
// //                       Image(
// //                         image: NetworkImage(
// //                           'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
// //                         ),
// //                         fit: BoxFit.cover,
// //                         height: 200.0,
// //                         width: double.infinity,
// //                       ),
// //                       Padding(
// //                         padding: const EdgeInsets.all(8.0),
// //                         child: Text(
// //                           'communicate with friends',
// //                           style: Theme.of(context).textTheme.subtitle1.copyWith(
// //                             color: Colors.white,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 ListView.separated(
// //                   shrinkWrap: true,
// //                   physics: NeverScrollableScrollPhysics(),
// //                   itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context, index),
// //                   separatorBuilder: (context, index) => SizedBox(
// //                     height: 8.0,
// //                   ),
// //                   itemCount: SocialCubit.get(context).posts.length,
// //                 ),
// //                 SizedBox(
// //                   height: 8.0,
// //                 ),
// //               ],
// //             ),
// //           ),
// //           fallback: (context) => Center(child: CircularProgressIndicator()),
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget buildPostItem(PostModel model, context, index) => Card(
// //     clipBehavior: Clip.antiAliasWithSaveLayer,
// //     elevation: 5.0,
// //     margin: EdgeInsets.symmetric(
// //       horizontal: 8.0,
// //     ),
// //     child: Padding(
// //       padding: const EdgeInsets.all(10.0),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             children: [
// //               CircleAvatar(
// //                 radius: 25.0,
// //                 backgroundImage: NetworkImage(
// //                   '${model.image}',
// //                 ),
// //               ),
// //               SizedBox(
// //                 width: 15.0,
// //               ),
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Row(
// //                       children: [
// //                         Text(
// //                           '${model.name}',
// //                           style: TextStyle(
// //                             height: 1.4,
// //                           ),
// //                         ),
// //                         SizedBox(
// //                           width: 5.0,
// //                         ),
// //                         Icon(
// //                           Icons.check_circle,
// //                           color: defaultColor,
// //                           size: 16.0,
// //                         ),
// //                       ],
// //                     ),
// //                     Text(
// //                       '${model.dateTime}',
// //                       style: Theme.of(context).textTheme.caption.copyWith(
// //                         height: 1.4,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               SizedBox(
// //                 width: 15.0,
// //               ),
// //               IconButton(
// //                 icon: Icon(
// //                   Icons.more_horiz,
// //                   size: 16.0,
// //                 ),
// //                 onPressed: () {},
// //               ),
// //             ],
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.symmetric(
// //               vertical: 15.0,
// //             ),
// //             child: Container(
// //               width: double.infinity,
// //               height: 1.0,
// //               color: Colors.grey[300],
// //             ),
// //           ),
// //           Text(
// //             '${model.text}',
// //             style: Theme.of(context).textTheme.subtitle1,
// //           ),
// //           // Padding(
// //           //   padding: const EdgeInsets.only(
// //           //     bottom: 10.0,
// //           //     top: 5.0,
// //           //   ),
// //           //   child: Container(
// //           //     width: double.infinity,
// //           //     child: Wrap(
// //           //       children: [
// //           //         Padding(
// //           //           padding: const EdgeInsetsDirectional.only(
// //           //             end: 6.0,
// //           //           ),
// //           //           child: Container(
// //           //             height: 25.0,
// //           //             child: MaterialButton(
// //           //               onPressed: () {},
// //           //               minWidth: 1.0,
// //           //               padding: EdgeInsets.zero,
// //           //               child: Text(
// //           //                 '#software',
// //           //                 style:
// //           //                     Theme.of(context).textTheme.caption.copyWith(
// //           //                           color: defaultColor,
// //           //                         ),
// //           //               ),
// //           //             ),
// //           //           ),
// //           //         ),
// //           //         Padding(
// //           //           padding: const EdgeInsetsDirectional.only(
// //           //             end: 6.0,
// //           //           ),
// //           //           child: Container(
// //           //             height: 25.0,
// //           //             child: MaterialButton(
// //           //               onPressed: () {},
// //           //               minWidth: 1.0,
// //           //               padding: EdgeInsets.zero,
// //           //               child: Text(
// //           //                 '#flutter',
// //           //                 style:
// //           //                     Theme.of(context).textTheme.caption.copyWith(
// //           //                           color: defaultColor,
// //           //                         ),
// //           //               ),
// //           //             ),
// //           //           ),
// //           //         ),
// //           //       ],
// //           //     ),
// //           //   ),
// //           // ),
// //           if(model.postImage != '')
// //             Padding(
// //               padding: const EdgeInsetsDirectional.only(
// //                   top: 15.0
// //               ),
// //               child: Container(
// //                 height: 140.0,
// //                 width: double.infinity,
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(
// //                     4.0,
// //                   ),
// //                   image: DecorationImage(
// //                     image: NetworkImage(
// //                       '${model.postImage}',
// //                     ),
// //                     fit: BoxFit.cover,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           Padding(
// //             padding: const EdgeInsets.symmetric(
// //               vertical: 5.0,
// //             ),
// //             child: Row(
// //               children: [
// //                 Expanded(
// //                   child: InkWell(
// //                     child: Padding(
// //                       padding: const EdgeInsets.symmetric(
// //                         vertical: 5.0,
// //                       ),
// //                       child: Row(
// //                         children: [
// //                           Icon(
// //                             IconBroken.Heart,
// //                             size: 16.0,
// //                             color: Colors.red,
// //                           ),
// //                           SizedBox(
// //                             width: 5.0,
// //                           ),
// //                           Text(
// //                             '${SocialCubit.get(context).likes[index]}',
// //                             style: Theme.of(context).textTheme.caption,
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     onTap: () {},
// //                   ),
// //                 ),
// //                 Expanded(
// //                   child: InkWell(
// //                     child: Padding(
// //                       padding: const EdgeInsets.symmetric(
// //                         vertical: 5.0,
// //                       ),
// //                       child: Row(
// //                         mainAxisAlignment: MainAxisAlignment.end,
// //                         children: [
// //                           Icon(
// //                             IconBroken.Chat,
// //                             size: 16.0,
// //                             color: Colors.amber,
// //                           ),
// //                           SizedBox(
// //                             width: 5.0,
// //                           ),
// //                           Text(
// //                             '0 comment',
// //                             style: Theme.of(context).textTheme.caption,
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     onTap: () {},
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.only(
// //               bottom: 10.0,
// //             ),
// //             child: Container(
// //               width: double.infinity,
// //               height: 1.0,
// //               color: Colors.grey[300],
// //             ),
// //           ),
// //           Row(
// //             children: [
// //               Expanded(
// //                 child: InkWell(
// //                   child: Row(
// //                     children: [
// //                       CircleAvatar(
// //                         radius: 18.0,
// //                         backgroundImage: NetworkImage(
// //                           '${SocialCubit.get(context).userModel.image}',
// //                         ),
// //                       ),
// //                       SizedBox(
// //                         width: 15.0,
// //                       ),
// //                       Text(
// //                         'write a comment ...',
// //                         style:
// //                         Theme.of(context).textTheme.caption.copyWith(),
// //                       ),
// //                     ],
// //                   ),
// //                   onTap: () {},
// //                 ),
// //               ),
// //               InkWell(
// //                 child: Row(
// //                   children: [
// //                     Icon(
// //                       IconBroken.Heart,
// //                       size: 16.0,
// //                       color: Colors.red,
// //                     ),
// //                     SizedBox(
// //                       width: 5.0,
// //                     ),
// //                     Text(
// //                       'Like',
// //                       style: Theme.of(context).textTheme.caption,
// //                     ),
// //                   ],
// //                 ),
// //                 onTap: ()
// //                 {
// //                   SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
// //                 },
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     ),
// //   );
// // }