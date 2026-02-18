// import 'dart:convert';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:kivaloop/State-Management/AddStories/add_stories_state_management.dart';
// import 'package:kivaloop/State-Management/GetUserLocation/user_location_state_management.dart';
// import 'package:kivaloop/State-Management/user_info_state_management.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int? selectedIndex;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // Provider.of<UserLocationStateManagement>(
//     //   context,
//     //   listen: false,
//     // ).determinePosition(context);

//     Provider.of<UserInfoStateManagement>(
//       context,
//       listen: false,
//     ).fetchSelfStory();
//     Provider.of<UserInfoStateManagement>(
//       context,
//       listen: false,
//     ).fetchUserInformation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Image.asset("assets/logo/logo_kivaloop.png", width: 120),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Icon(Iconsax.message_2),
//           ),
//         ],
//       ),

//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // // Story Section
//               // Row(
//               //   spacing: 10,
//               //   children: [
//               //     Padding(
//               //       padding: EdgeInsets.only(left: 20),
//               //       child: Container(
//               //         height: 180,
//               //         width: 99,
//               //         decoration: BoxDecoration(
//               //           borderRadius: BorderRadius.circular(16),
//               //           color: Color(0xff745340).withOpacity(0.5),
//               //           image:
//               //               Provider.of<UserInfoStateManagement>(
//               //                         context,
//               //                       ).finalStoryImageUrl !=
//               //                       null
//               //                   ? DecorationImage(
//               //                     opacity: 0.3,
//               //                     fit: BoxFit.cover,
//               //                     image: NetworkImage(
//               //                       Provider.of<UserInfoStateManagement>(
//               //                         context,
//               //                       ).finalStoryImageUrl!,
//               //                     ),
//               //                   )
//               //                   : null,
//               //         ),
//               //         child: Column(
//               //           mainAxisAlignment: MainAxisAlignment.spaceAround,
//               //           children: [
//               //             Visibility(
//               //               visible: true,

//               //               child: Icon(
//               //                 Iconsax.add_circle5,
//               //                 size: 30,
//               //                 color: Colors.transparent,
//               //               ),
//               //             ),
//               //             Container(
//               //               height: 60,
//               //               width: 60,
//               //               decoration: BoxDecoration(
//               //                 borderRadius: BorderRadius.circular(40),
//               //                 border: Border.all(color: Color(0xff745340)),
//               //                 image: DecorationImage(
//               //                   fit: BoxFit.cover,
//               //                   image: NetworkImage(
//               //                     Provider.of<UserInfoStateManagement>(
//               //                       context,
//               //                       listen: false,
//               //                     ).userProfileImage,
//               //                   ),
//               //                 ),
//               //               ),
//               //             ),

//               //             Visibility(
//               //               visible: true,
//               //               child: GestureDetector(
//               //                 onTap: () async {
//               //                   await Provider.of<AddStoriesStateManagement>(
//               //                     context,
//               //                     listen: false,
//               //                   ).selectAndUploadStoryImage();
//               //                 },
//               //                 child: Icon(
//               //                   Iconsax.add_circle5,
//               //                   size: 30,
//               //                   color: Colors.white,
//               //                 ),
//               //               ),
//               //             ),
//               //           ],
//               //         ),
//               //       ),
//               //     ),
//               //     Expanded(
//               //       child: Container(
//               //         height: 180,
//               //         width: double.infinity,
//               //         child: FutureBuilder(
//               //           future:
//               //               FirebaseFirestore.instance
//               //                   .collection("userData")
//               //                   .where(
//               //                     "userId",
//               //                     isNotEqualTo:
//               //                         FirebaseAuth.instance.currentUser!.uid,
//               //                   )
//               //                   .get(),
//               //           builder: (context, snapshots) {
//               //             if (snapshots.connectionState ==
//               //                 ConnectionState.waiting) {
//               //               return Center(child: CircularProgressIndicator());
//               //             } else if (snapshots.connectionState ==
//               //                 ConnectionState.none) {
//               //               return Text("No stories to show");
//               //             } else {
//               //               return ListView.builder(
//               //                 itemCount: snapshots.data!.docs.length,
//               //                 scrollDirection: Axis.horizontal,
//               //                 itemBuilder: (context, index) {
//               //                   return Padding(
//               //                     padding: const EdgeInsets.only(right: 10),
//               //                     child: Container(
//               //                       height: 177,
//               //                       width: 99,
//               //                       decoration: BoxDecoration(
//               //                         borderRadius: BorderRadius.circular(16),
//               //                         color: Color(0xff745340).withOpacity(0.5),
//               //                         image: DecorationImage(
//               //                           opacity: 0.3,
//               //                           fit: BoxFit.cover,
//               //                           image: NetworkImage(
//               //                             snapshots
//               //                                 .data!
//               //                                 .docs[index]["imageUrl"],
//               //                           ),
//               //                         ),
//               //                       ),
//               //                       child: Column(
//               //                         mainAxisAlignment:
//               //                             MainAxisAlignment.center,
//               //                         children: [
//               //                           Container(
//               //                             height: 60,
//               //                             width: 60,
//               //                             decoration: BoxDecoration(
//               //                               borderRadius: BorderRadius.circular(
//               //                                 40,
//               //                               ),
//               //                               border: Border.all(
//               //                                 color: Color(0xff745340),
//               //                               ),
//               //                               image: DecorationImage(
//               //                                 fit: BoxFit.cover,
//               //                                 image: NetworkImage(
//               //                                   snapshots
//               //                                       .data!
//               //                                       .docs[index]["profileImageUrl"],
//               //                                 ),
//               //                               ),
//               //                             ),
//               //                           ),
//               //                         ],
//               //                       ),
//               //                     ),
//               //                   );
//               //                 },
//               //               );
//               //             }
//               //           },
//               //         ),
//               //       ),
//               //     ),
//               //   ],
//               // ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 color: Color(0xff9c5d29),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                     vertical: 15.h,
//                     horizontal: 20.w,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Good Morning, User!",
//                         style: GoogleFonts.roboto(
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       Text(
//                         "Ready for your coffee adventure?",
//                         style: GoogleFonts.roboto(
//                           fontSize: 14.sp,
//                           color: Colors.white,
//                         ),
//                       ),
//                       SizedBox(height: 20.h),
//                       ElevatedButton(
//                         child: Row(
//                           spacing: 15.w,
//                           children: [
//                             Icon(Iconsax.coffee),
//                             Text(
//                               'Order Now',
//                               style: GoogleFonts.roboto(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Featured cafe Lists
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Featured Cafe",
//                           style: GoogleFonts.roboto(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),

//                         Row(
//                           children: [
//                             Text(
//                               "See All",
//                               style: GoogleFonts.roboto(
//                                 fontSize: 12.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xff9c5d29),
//                               ),
//                             ),
//                             Icon(
//                               Iconsax.arrow_right_4,
//                               color: Color(0xff9c5d29),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),

//                     ListView.builder(
//                       itemCount: 3,
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       padding: EdgeInsets.zero,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: 10.h),
//                           child: Container(
//                             child: Row(
//                               spacing: 10.w,
//                               children: [
//                                 Container(
//                                   height: 60.h,
//                                   width: 80.w,
//                                   color: Colors.grey.shade500,
//                                 ),

//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Name of the Cafe",
//                                       style: GoogleFonts.roboto(
//                                         fontSize: 14.sp,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),

//                                     Text(
//                                       "Item name",
//                                       style: GoogleFonts.roboto(
//                                         fontSize: 14.sp,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),

//               // Recent Activities Section
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Recent Activities",
//                       style: GoogleFonts.roboto(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     StreamBuilder(
//                       stream:
//                           FirebaseFirestore.instance
//                               .collection("posts")
//                               .snapshots(),
//                       builder: (context, snapshots) {
//                         if (snapshots.connectionState ==
//                             ConnectionState.waiting) {
//                           return Center(child: CircularProgressIndicator());
//                         } else if (snapshots.connectionState ==
//                             ConnectionState.none) {
//                           return Center(child: Text("No data"));
//                         } else {
//                           return ListView.builder(
//                             shrinkWrap: true,
//                             physics: NeverScrollableScrollPhysics(),
//                             padding: EdgeInsets.zero,
//                             itemCount: snapshots.data!.docs.length,
//                             itemBuilder: (context, index) {
//                               final doc = snapshots.data!.docs[index];
//                               final postId =
//                                   doc.id; // 👈 Use document ID directly, not a 'postId' field
//                               final data = doc.data() as Map<String, dynamic>;
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 10,
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Expanded(
//                                           child: Row(
//                                             spacing: 6,
//                                             children: [
//                                               Container(
//                                                 height: 24,
//                                                 width: 24,
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.grey.shade400,
//                                                   borderRadius:
//                                                       BorderRadius.circular(40),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 "User name",

//                                                 style: GoogleFonts.roboto(
//                                                   fontSize: 12,
//                                                   fontWeight: FontWeight.w400,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),

//                                         Expanded(
//                                           child: Row(
//                                             spacing: 6,
//                                             children: [
//                                               Icon(
//                                                 Iconsax.location5,
//                                                 size: 12,
//                                                 color: Color(0xff745340),
//                                               ),
//                                               Expanded(
//                                                 child: Text(
//                                                   snapshots
//                                                       .data!
//                                                       .docs[index]["location"],
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   style: GoogleFonts.roboto(
//                                                     fontSize: 12,
//                                                     fontWeight: FontWeight.w400,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(height: 10),

//                                     Container(
//                                       height: 393,
//                                       width: double.infinity,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(16),
//                                         image: DecorationImage(
//                                           fit: BoxFit.cover,
//                                           image: NetworkImage(
//                                             snapshots
//                                                 .data!
//                                                 .docs[index]?["imageUrl"] ?? "",
//                                           ),
//                                         ),
//                                       ),
//                                       child: Stack(
//                                         children: [
//                                           Positioned(
//                                             left: 20,
//                                             bottom: 20,
//                                             child: Container(
//                                               width: 289,
//                                               height: 70,
//                                               child: Text(
//                                                 snapshots
//                                                     .data!
//                                                     .docs[index]["description"]
//                                                     .toString(),
//                                                 style: GoogleFonts.roboto(
//                                                   color: Colors.white,
//                                                   fontSize: 11,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),

//                                           Positioned(
//                                             right: 20,
//                                             bottom: 20,
//                                             child: Container(
//                                               width: 24,
//                                               height: 126,
//                                               child: Column(
//                                                 spacing: 10,
//                                                 children: [
//                                                   GestureDetector(
//                                                     onTap: () async {
//                                                       print(
//                                                         snapshots
//                                                             .data!
//                                                             .docs[index]["likes"],
//                                                       );

//                                                       if (data["likes"]
//                                                           .contains(
//                                                             FirebaseAuth
//                                                                 .instance
//                                                                 .currentUser!
//                                                                 .uid,
//                                                           )) {
//                                                         await FirebaseFirestore
//                                                             .instance
//                                                             .collection('posts')
//                                                             .doc(postId)
//                                                             .update({
//                                                               'likes': FieldValue.arrayRemove([
//                                                                 FirebaseAuth
//                                                                     .instance
//                                                                     .currentUser!
//                                                                     .uid,
//                                                               ]),
//                                                             });
//                                                       } else {
//                                                         await FirebaseFirestore
//                                                             .instance
//                                                             .collection('posts')
//                                                             .doc(postId)
//                                                             .update({
//                                                               'likes': FieldValue.arrayUnion([
//                                                                 FirebaseAuth
//                                                                     .instance
//                                                                     .currentUser!
//                                                                     .uid,
//                                                               ]),
//                                                             });
//                                                       }
//                                                     },
//                                                     child:
//                                                         data['likes'] != null &&
//                                                                 data['likes'].contains(
//                                                                   FirebaseAuth
//                                                                       .instance
//                                                                       .currentUser!
//                                                                       .uid,
//                                                                 )
//                                                             ? Icon(
//                                                               Iconsax.heart5,
//                                                               color: Colors.red,
//                                                             )
//                                                             : Icon(
//                                                               Iconsax.heart,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                   ),
//                                                   GestureDetector(
//                                                     onTap: () {},
//                                                     child: Icon(
//                                                       Iconsax.message,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                   GestureDetector(
//                                                     onTap: () {},
//                                                     child: Icon(
//                                                       Iconsax.bookmark,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),

//                                                   GestureDetector(
//                                                     onTap: () {},
//                                                     child: Icon(
//                                                       Iconsax.more,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ----------------------------------- 2222222222222222222222 ---------------------------------

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kivaloop/State-Management/AddStories/add_stories_state_management.dart';
import 'package:kivaloop/State-Management/user_info_state_management.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedIndex;
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  // Sample featured cafes data
  final List<Map<String, dynamic>> featuredCafes = [
    {
      "name": "Brew & Bloom",
      "item": "Signature Latte",
      "rating": 4.8,
      "distance": "0.5 km",
      "image":
          "https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=400",
    },
    {
      "name": "The Coffee House",
      "item": "Caramel Macchiato",
      "rating": 4.6,
      "distance": "1.2 km",
      "image":
          "https://images.unsplash.com/photo-1493857671505-72967e2e2760?w=400",
    },
    {
      "name": "Urban Roast",
      "item": "Cold Brew",
      "rating": 4.9,
      "distance": "0.8 km",
      "image":
          "https://images.unsplash.com/photo-1445116572660-236099ec97a0?w=400",
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Provider.of<UserInfoStateManagement>(
      context,
      listen: false,
    ).fetchSelfStory();
    Provider.of<UserInfoStateManagement>(
      context,
      listen: false,
    ).fetchUserInformation();
  }

  void _onScroll() {
    if (_scrollController.offset > 50 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 50 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    return "Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF8F5),
      body: CustomScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        slivers: [
          // Custom Animated App Bar
          SliverAppBar(
            expandedHeight: 70.h,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: _isScrolled ? Colors.white : Color(0xFFFAF8F5),
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFAF8F5), Color(0xFFF5F0EB)],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Logo Section
                        Row(
                          children: [
                            Container(
                              height: 45.h,
                              width: 45.w,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFB8860B),
                                    Color(0xFF8B6914),
                                    Color(0xFF5C4033),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF5C4033).withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  Iconsax.coffee5,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Kivaloop",
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2D2D2D),
                                  ),
                                ),
                                Text(
                                  "Brew mindfully",
                                  style: GoogleFonts.roboto(
                                    fontSize: 11.sp,
                                    color: Color(0xFF8B6914),
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Action Icons
                        Row(
                          children: [
                            _buildAppBarIcon(
                              Iconsax.search_normal,
                              onTap: () {},
                            ),
                            SizedBox(width: 12.w),
                            _buildAppBarIcon(
                              Iconsax.notification,
                              badge: 3,
                              onTap: () {},
                            ),
                            SizedBox(width: 12.w),
                            _buildAppBarIcon(
                              Iconsax.message,
                              badge: 5,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Hero Welcome Section
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF8B6914),
                    Color(0xFF5C4033),
                    Color(0xFF3D2817),
                  ],
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF5C4033).withOpacity(0.4),
                    blurRadius: 25,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Decorative Elements
                  Positioned(
                    right: -30,
                    top: -30,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.05),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: -40,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.03),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -20,
                    bottom: -20,
                    child: Icon(
                      Iconsax.coffee5,
                      size: 80,
                      color: Colors.white.withOpacity(0.05),
                    ),
                  ),

                  // Content
                  Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.sun_15,
                                    size: 14,
                                    color: Color(0xFFFFD700),
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    _getGreeting(),
                                    style: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      color: Colors.white.withOpacity(0.9),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Consumer<UserInfoStateManagement>(
                          builder: (context, userInfo, child) {
                            return Text(
                              "Hello, ${userInfo.userName.isNotEmpty ? userInfo.userName.split(' ')[0] : 'Coffee Lover'}! ☕",
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Ready for your next coffee adventure?",
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            color: Colors.white.withOpacity(0.8),
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Iconsax.coffee,
                                        size: 20,
                                        color: Color(0xFF5C4033),
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        'Order Now',
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
                                          color: Color(0xFF5C4033),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                ),
                                child: Icon(
                                  Iconsax.scan_barcode,
                                  color: Colors.white,
                                  size: 22,
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
          ),

          // Quick Actions
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickAction(
                    icon: Iconsax.location,
                    label: "Nearby",
                    color: Color(0xFF4CAF50),
                  ),
                  _buildQuickAction(
                    icon: Iconsax.heart,
                    label: "Favorites",
                    color: Color(0xFFE91E63),
                  ),
                  _buildQuickAction(
                    icon: Iconsax.discount_shape,
                    label: "Offers",
                    color: Color(0xFFFF9800),
                  ),
                  _buildQuickAction(
                    icon: Iconsax.medal_star,
                    label: "Rewards",
                    color: Color(0xFF9C27B0),
                  ),
                ],
              ),
            ),
          ),

          // Stories Section
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 28.h, 20.w, 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFF5C4033).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Iconsax.story,
                              size: 18,
                              color: Color(0xFF5C4033),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            "Coffee Stories",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D2D2D),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF5C4033).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "View All",
                          style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF5C4033),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Stories List
                Container(
                  height: 200.h,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    children: [
                      // Your Story
                      _buildYourStoryCard(),
                      SizedBox(width: 12.w),

                      // Other Stories
                      FutureBuilder(
                        future:
                            FirebaseFirestore.instance
                                .collection("userData")
                                .where(
                                  "userId",
                                  isNotEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid,
                                )
                                .limit(10)
                                .get(),
                        builder: (context, snapshots) {
                          if (snapshots.connectionState ==
                              ConnectionState.waiting) {
                            return Row(
                              children: List.generate(
                                3,
                                (index) => Padding(
                                  padding: EdgeInsets.only(right: 12.w),
                                  child: _buildStoryShimmer(),
                                ),
                              ),
                            );
                          } else if (!snapshots.hasData ||
                              snapshots.data!.docs.isEmpty) {
                            return SizedBox();
                          }
                          return Row(
                            children:
                                snapshots.data!.docs.map((doc) {
                                  return Padding(
                                    padding: EdgeInsets.only(right: 12.w),
                                    child: _buildStoryCard(
                                      name: doc["userName"] ?? "User",
                                      profileImage:
                                          doc["profileImageUrl"] ?? "",
                                      storyImage: doc["imageUrl"] ?? "",
                                    ),
                                  );
                                }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Featured Cafes Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 28.h, 20.w, 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFFF9800).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Iconsax.shop,
                              size: 18,
                              color: Color(0xFFFF9800),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            "Featured Cafés",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D2D2D),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text(
                              "See All",
                              style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF5C4033),
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Iconsax.arrow_right_3,
                              size: 18,
                              color: Color(0xFF5C4033),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Featured Cafes Horizontal List
                  Container(
                    height: 180.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: featuredCafes.length,
                      itemBuilder: (context, index) {
                        final cafe = featuredCafes[index];
                        return _buildFeaturedCafeCard(cafe, index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Recent Activities Section Header
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFF2196F3).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Iconsax.activity,
                      size: 18,
                      color: Color(0xFF2196F3),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "Recent Activities",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Posts Stream
          StreamBuilder(
            stream:
                FirebaseFirestore.instance
                    .collection("posts")
                    .orderBy("createdAt", descending: true)
                    .snapshots(),
            builder: (context, snapshots) {
              if (snapshots.connectionState == ConnectionState.waiting) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: CircularProgressIndicator(
                        color: Color(0xFF5C4033),
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                );
              } else if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
                return SliverToBoxAdapter(child: _buildEmptyState());
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final doc = snapshots.data!.docs[index];
                  final postId = doc.id;
                  final data = doc.data() as Map<String, dynamic>;
                  return _buildPostCard(data, postId, index);
                }, childCount: snapshots.data!.docs.length),
              );
            },
          ),

          // Bottom Padding
          SliverToBoxAdapter(child: SizedBox(height: 100.h)),
        ],
      ),
    );
  }

  Widget _buildAppBarIcon(
    IconData icon, {
    int badge = 0,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 44.h,
            width: 44.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, size: 22, color: Color(0xFF2D2D2D)),
          ),
          if (badge > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                height: 18.h,
                width: 18.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE91E63), Color(0xFFC2185B)],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFFFAF8F5), width: 2),
                ),
                child: Center(
                  child: Text(
                    badge > 9 ? "9+" : badge.toString(),
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            height: 60.h,
            width: 60.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2D2D2D),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYourStoryCard() {
    return Consumer<UserInfoStateManagement>(
      builder: (context, userInfo, child) {
        return GestureDetector(
          onTap: () async {
            await Provider.of<AddStoriesStateManagement>(
              context,
              listen: false,
            ).selectAndUploadStoryImage();
          },
          child: Container(
            width: 110.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Background
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF8B6914).withOpacity(0.8),
                        Color(0xFF5C4033),
                      ],
                    ),
                    image:
                        userInfo.finalStoryImageUrl != null
                            ? DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(userInfo.finalStoryImageUrl!),
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.3),
                                BlendMode.darken,
                              ),
                            )
                            : null,
                  ),
                ),

                // Gradient Overlay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),

                // Content
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 65.h,
                        width: 65.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          image:
                              userInfo.userProfileImage.isNotEmpty
                                  ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      userInfo.userProfileImage,
                                    ),
                                  )
                                  : null,
                          color: Colors.grey[300],
                        ),
                        child:
                            userInfo.userProfileImage.isEmpty
                                ? Icon(Iconsax.user, color: Colors.grey[600])
                                : null,
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 28.h,
                        width: 28.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xFFFFD700), Color(0xFFFF9800)],
                          ),
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFFF9800).withOpacity(0.4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Icon(Icons.add, size: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),

                // Label
                Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: Text(
                    "Your Story",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStoryCard({
    required String name,
    required String profileImage,
    required String storyImage,
  }) {
    return GestureDetector(
      onTap: () {
        // View story
      },
      child: Container(
        width: 110.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Story Image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image:
                    storyImage.isNotEmpty
                        ? DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(storyImage),
                        )
                        : null,
                color: Colors.grey[300],
              ),
            ),

            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),

            // Profile Ring
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFFD700),
                      Color(0xFFFF9800),
                      Color(0xFF5C4033),
                    ],
                  ),
                ),
                child: Container(
                  height: 38.h,
                  width: 38.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    image:
                        profileImage.isNotEmpty
                            ? DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(profileImage),
                            )
                            : null,
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ),

            // Name
            Positioned(
              bottom: 12,
              left: 10,
              right: 10,
              child: Text(
                name.split(' ')[0],
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryShimmer() {
    return Container(
      width: 110.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
      ),
    );
  }

  Widget _buildFeaturedCafeCard(Map<String, dynamic> cafe, int index) {
    final List<Color> gradients = [
      Color(0xFF5C4033),
      Color(0xFF8B6914),
      Color(0xFF2E7D32),
    ];

    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 280.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: gradients[index % 3].withOpacity(0.3),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background Image
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(cafe["image"]),
                  ),
                ),
              ),

              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.transparent,
                      gradients[index % 3].withOpacity(0.9),
                    ],
                  ),
                ),
              ),

              // Content
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                size: 14,
                                color: Color(0xFFFFB300),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                cafe["rating"].toString(),
                                style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2D2D2D),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Iconsax.location,
                                size: 12,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                cafe["distance"],
                                style: GoogleFonts.roboto(
                                  fontSize: 11.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      cafe["name"],
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Iconsax.coffee,
                          size: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          cafe["item"],
                          style: GoogleFonts.roboto(
                            fontSize: 13.sp,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Favorite Button
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  height: 36.h,
                  width: 36.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.heart,
                    size: 18,
                    color: Color(0xFF5C4033),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> data, String postId, int index) {
    final isLiked =
        data['likes'] != null &&
        data['likes'].contains(FirebaseAuth.instance.currentUser!.uid);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            // Post Header
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFFFFD700), Color(0xFF5C4033)],
                      ),
                    ),
                    child: Container(
                      height: 44.h,
                      width: 44.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        color: Colors.grey[300],
                      ),
                      child: ClipOval(
                        child:
                            data["userProfileImage"] != null &&
                                    data["userProfileImage"].isNotEmpty
                                ? Image.network(
                                  data["userProfileImage"],
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, __, ___) => Icon(
                                        Iconsax.user,
                                        color: Colors.grey[600],
                                      ),
                                )
                                : Icon(Iconsax.user, color: Colors.grey[600]),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data["userName"] ?? "Coffee Lover",
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D2D2D),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Icon(
                              Iconsax.location5,
                              size: 12,
                              color: Color(0xFF5C4033),
                            ),
                            SizedBox(width: 4.w),
                            Flexible(
                              child: Text(
                                data["location"] ?? "Unknown Location",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showPostOptions(context),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.more_horiz,
                        size: 20,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Post Image
            GestureDetector(
              onDoubleTap: () async {
                if (!isLiked) {
                  await FirebaseFirestore.instance
                      .collection('posts')
                      .doc(postId)
                      .update({
                        'likes': FieldValue.arrayUnion([
                          FirebaseAuth.instance.currentUser!.uid,
                        ]),
                      });
                }
              },
              child: Container(
                height: 380.h,
                width: double.infinity,
                child: Stack(
                  children: [
                    // Image
                    Container(
                      decoration: BoxDecoration(
                        image:
                            data["imageUrl"] != null &&
                                    data["imageUrl"].isNotEmpty
                                ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(data["imageUrl"]),
                                )
                                : null,
                        color: Colors.grey[200],
                      ),
                    ),

                    // Bottom Gradient
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 150.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Caption
                    Positioned(
                      left: 16.w,
                      right: 70.w,
                      bottom: 16.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data["description"] ?? "",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 13.sp,
                              height: 1.4,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              _buildHashtag("#CoffeeLovers"),
                              SizedBox(width: 6.w),
                              _buildHashtag("#Kivaloop"),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Action Buttons
                    Positioned(
                      right: 12.w,
                      bottom: 16.h,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 10.w,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            _buildPostAction(
                              icon: isLiked ? Iconsax.heart5 : Iconsax.heart,
                              color: isLiked ? Colors.redAccent : Colors.white,
                              label: "${(data['likes'] as List?)?.length ?? 0}",
                              onTap: () async {
                                if (isLiked) {
                                  await FirebaseFirestore.instance
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
                                  await FirebaseFirestore.instance
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
                            ),
                            SizedBox(height: 16.h),
                            _buildPostAction(
                              icon: Iconsax.message,
                              color: Colors.white,
                              label: "24",
                              onTap: () {},
                            ),
                            SizedBox(height: 16.h),
                            _buildPostAction(
                              icon: Iconsax.bookmark,
                              color: Colors.white,
                              label: "",
                              onTap: () {},
                            ),
                            SizedBox(height: 16.h),
                            _buildPostAction(
                              icon: Iconsax.send_2,
                              color: Colors.white,
                              label: "",
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Post Footer
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  // Liked by avatars
                  if ((data['likes'] as List?)?.isNotEmpty ?? false)
                    Container(
                      width: 70.w,
                      height: 28.h,
                      child: Stack(
                        children: List.generate(
                          ((data['likes'] as List).length).clamp(0, 3),
                          (i) => Positioned(
                            left: i * 18.0,
                            child: Container(
                              height: 28.h,
                              width: 28.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                color:
                                    [
                                      Color(0xFF5C4033),
                                      Color(0xFFFF9800),
                                      Color(0xFF4CAF50),
                                    ][i % 3],
                              ),
                              child: Center(
                                child: Text(
                                  i == 2 && (data['likes'] as List).length > 3
                                      ? "+${(data['likes'] as List).length - 2}"
                                      : "",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      "${(data['likes'] as List?)?.length ?? 0} likes",
                      style: GoogleFonts.roboto(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                  ),
                  Text(
                    _formatTime(data['createdAt']),
                    style: GoogleFonts.roboto(
                      fontSize: 12.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHashtag(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        tag,
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPostAction({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          if (label.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                label,
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(40.w),
      child: Column(
        children: [
          Container(
            height: 100.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: Color(0xFF5C4033).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.coffee, size: 50, color: Color(0xFF5C4033)),
          ),
          SizedBox(height: 20.h),
          Text(
            "No posts yet",
            style: GoogleFonts.playfairDisplay(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D2D2D),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Be the first to share your coffee moment!",
            style: GoogleFonts.roboto(fontSize: 14.sp, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatTime(dynamic timestamp) {
    if (timestamp == null) return "";
    try {
      DateTime dateTime;
      if (timestamp is Timestamp) {
        dateTime = timestamp.toDate();
      } else {
        return "";
      }
      final difference = DateTime.now().difference(dateTime);
      if (difference.inMinutes < 60) {
        return "${difference.inMinutes}m ago";
      } else if (difference.inHours < 24) {
        return "${difference.inHours}h ago";
      } else {
        return "${difference.inDays}d ago";
      }
    } catch (e) {
      return "";
    }
  }

  void _showPostOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 20.h),
              _buildOptionTile(Iconsax.link, "Copy Link"),
              _buildOptionTile(Iconsax.share, "Share to..."),
              _buildOptionTile(Iconsax.flag, "Report"),
              _buildOptionTile(Iconsax.user_minus, "Unfollow"),
              SizedBox(height: 30.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionTile(IconData icon, String title) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFF5C4033).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Color(0xFF5C4033), size: 20),
      ),
      title: Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: Color(0xFF2D2D2D),
        ),
      ),
      onTap: () => Navigator.pop(context),
    );
  }
}
