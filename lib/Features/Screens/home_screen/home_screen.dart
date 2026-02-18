import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:kivaloop/State-Management/AddStories/add_stories_state_management.dart';
import 'package:kivaloop/State-Management/GetUserLocation/user_location_state_management.dart';
import 'package:kivaloop/State-Management/user_info_state_management.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserLocationStateManagement>(
      context,
      listen: false,
    ).determinePosition(context);

    Provider.of<UserInfoStateManagement>(
      context,
      listen: false,
    ).fetchSelfStory();
    Provider.of<UserInfoStateManagement>(
      context,
      listen: false,
    ).fetchUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset("assets/logo/logo_kivaloop.png", width: 120),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Iconsax.message_2),
          ),
        ],
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // // Story Section
              // Row(
              //   spacing: 10,
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.only(left: 20),
              //       child: Container(
              //         height: 180,
              //         width: 99,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(16),
              //           color: Color(0xff745340).withOpacity(0.5),
              //           image:
              //               Provider.of<UserInfoStateManagement>(
              //                         context,
              //                       ).finalStoryImageUrl !=
              //                       null
              //                   ? DecorationImage(
              //                     opacity: 0.3,
              //                     fit: BoxFit.cover,
              //                     image: NetworkImage(
              //                       Provider.of<UserInfoStateManagement>(
              //                         context,
              //                       ).finalStoryImageUrl!,
              //                     ),
              //                   )
              //                   : null,
              //         ),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           children: [
              //             Visibility(
              //               visible: true,

              //               child: Icon(
              //                 Iconsax.add_circle5,
              //                 size: 30,
              //                 color: Colors.transparent,
              //               ),
              //             ),
              //             Container(
              //               height: 60,
              //               width: 60,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(40),
              //                 border: Border.all(color: Color(0xff745340)),
              //                 image: DecorationImage(
              //                   fit: BoxFit.cover,
              //                   image: NetworkImage(
              //                     Provider.of<UserInfoStateManagement>(
              //                       context,
              //                       listen: false,
              //                     ).userProfileImage,
              //                   ),
              //                 ),
              //               ),
              //             ),

              //             Visibility(
              //               visible: true,
              //               child: GestureDetector(
              //                 onTap: () async {
              //                   await Provider.of<AddStoriesStateManagement>(
              //                     context,
              //                     listen: false,
              //                   ).selectAndUploadStoryImage();
              //                 },
              //                 child: Icon(
              //                   Iconsax.add_circle5,
              //                   size: 30,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         height: 180,
              //         width: double.infinity,
              //         child: FutureBuilder(
              //           future:
              //               FirebaseFirestore.instance
              //                   .collection("userData")
              //                   .where(
              //                     "userId",
              //                     isNotEqualTo:
              //                         FirebaseAuth.instance.currentUser!.uid,
              //                   )
              //                   .get(),
              //           builder: (context, snapshots) {
              //             if (snapshots.connectionState ==
              //                 ConnectionState.waiting) {
              //               return Center(child: CircularProgressIndicator());
              //             } else if (snapshots.connectionState ==
              //                 ConnectionState.none) {
              //               return Text("No stories to show");
              //             } else {
              //               return ListView.builder(
              //                 itemCount: snapshots.data!.docs.length,
              //                 scrollDirection: Axis.horizontal,
              //                 itemBuilder: (context, index) {
              //                   return Padding(
              //                     padding: const EdgeInsets.only(right: 10),
              //                     child: Container(
              //                       height: 177,
              //                       width: 99,
              //                       decoration: BoxDecoration(
              //                         borderRadius: BorderRadius.circular(16),
              //                         color: Color(0xff745340).withOpacity(0.5),
              //                         image: DecorationImage(
              //                           opacity: 0.3,
              //                           fit: BoxFit.cover,
              //                           image: NetworkImage(
              //                             snapshots
              //                                 .data!
              //                                 .docs[index]["imageUrl"],
              //                           ),
              //                         ),
              //                       ),
              //                       child: Column(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.center,
              //                         children: [
              //                           Container(
              //                             height: 60,
              //                             width: 60,
              //                             decoration: BoxDecoration(
              //                               borderRadius: BorderRadius.circular(
              //                                 40,
              //                               ),
              //                               border: Border.all(
              //                                 color: Color(0xff745340),
              //                               ),
              //                               image: DecorationImage(
              //                                 fit: BoxFit.cover,
              //                                 image: NetworkImage(
              //                                   snapshots
              //                                       .data!
              //                                       .docs[index]["profileImageUrl"],
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   );
              //                 },
              //               );
              //             }
              //           },
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Color(0xff9c5d29),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.h,
                    horizontal: 20.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Morning, User!",
                        style: GoogleFonts.roboto(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Ready for your coffee adventure?",
                        style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        child: Row(
                          spacing: 15.w,
                          children: [
                            Icon(Iconsax.coffee),
                            Text(
                              'Order Now',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),

              // Featured cafe Lists
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Featured Cafe",
                          style: GoogleFonts.roboto(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Row(
                          children: [
                            Text(
                              "See All",
                              style: GoogleFonts.roboto(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff9c5d29),
                              ),
                            ),
                            Icon(
                              Iconsax.arrow_right_4,
                              color: Color(0xff9c5d29),
                            ),
                          ],
                        ),
                      ],
                    ),

                    ListView.builder(
                      itemCount: 3,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Container(
                            child: Row(
                              spacing: 10.w,
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 80.w,
                                  color: Colors.grey.shade500,
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name of the Cafe",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Text(
                                      "Item name",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Recent Activities Section
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Activities",
                      style: GoogleFonts.roboto(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StreamBuilder(
                      stream:
                          FirebaseFirestore.instance
                              .collection("posts")
                              .snapshots(),
                      builder: (context, snapshots) {
                        if (snapshots.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshots.connectionState ==
                            ConnectionState.none) {
                          return Center(child: Text("No data"));
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: snapshots.data!.docs.length,
                            itemBuilder: (context, index) {
                              final doc = snapshots.data!.docs[index];
                              final postId =
                                  doc.id; // 👈 Use document ID directly, not a 'postId' field
                              final data = doc.data() as Map<String, dynamic>;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            spacing: 6,
                                            children: [
                                              Container(
                                                height: 24,
                                                width: 24,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade400,
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                              ),
                                              Text(
                                                "User name",

                                                style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Expanded(
                                          child: Row(
                                            spacing: 6,
                                            children: [
                                              Icon(
                                                Iconsax.location5,
                                                size: 12,
                                                color: Color(0xff745340),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  snapshots
                                                      .data!
                                                      .docs[index]["location"],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),

                                    Container(
                                      height: 393,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            snapshots
                                                .data!
                                                .docs[index]["imageUrl"],
                                          ),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 20,
                                            bottom: 20,
                                            child: Container(
                                              width: 289,
                                              height: 70,
                                              child: Text(
                                                snapshots
                                                    .data!
                                                    .docs[index]["description"]
                                                    .toString(),
                                                style: GoogleFonts.roboto(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                          ),

                                          Positioned(
                                            right: 20,
                                            bottom: 20,
                                            child: Container(
                                              width: 24,
                                              height: 126,
                                              child: Column(
                                                spacing: 10,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      print(
                                                        snapshots
                                                            .data!
                                                            .docs[index]["likes"],
                                                      );

                                                      if (data["likes"]
                                                          .contains(
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid,
                                                          )) {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('posts')
                                                            .doc(postId)
                                                            .update({
                                                              'likes': FieldValue.arrayRemove([
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid,
                                                              ]),
                                                            });
                                                      } else {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('posts')
                                                            .doc(postId)
                                                            .update({
                                                              'likes': FieldValue.arrayUnion([
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid,
                                                              ]),
                                                            });
                                                      }
                                                    },
                                                    child:
                                                        data['likes'] != null &&
                                                                data['likes'].contains(
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid,
                                                                )
                                                            ? Icon(
                                                              Iconsax.heart5,
                                                              color: Colors.red,
                                                            )
                                                            : Icon(
                                                              Iconsax.heart,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Icon(
                                                      Iconsax.message,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Icon(
                                                      Iconsax.bookmark,
                                                      color: Colors.white,
                                                    ),
                                                  ),

                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Icon(
                                                      Iconsax.more,
                                                      color: Colors.white,
                                                    ),
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
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
