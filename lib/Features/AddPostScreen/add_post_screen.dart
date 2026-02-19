// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:kivaloop/State-Management/AddPostState/add_status_state_manegement.dart';
// import 'package:kivaloop/State-Management/BottomNavbarState/bottom_navbar_state_management.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:uuid/uuid.dart';

// class AddPostScreen extends StatefulWidget {
//   const AddPostScreen({super.key});

//   @override
//   State<AddPostScreen> createState() => _AddPostScreenState();
// }

// class _AddPostScreenState extends State<AddPostScreen> {
//   TextEditingController descripptionController = TextEditingController();

//   Future postStatus() async {
//     var provider = Provider.of<AddStatusStateManegement>(
//       context,
//       listen: false,
//     );
//     try {
//       EasyLoading.show();
//       String cloudName = "dypsfkqhj";
//       String presetName = "kivaloop_story";
//       if (provider.statusImageFile != null) {
//         final url = Uri.parse(
//           "https://api.cloudinary.com/v1_1/$cloudName/upload",
//         );
//         final request =
//             http.MultipartRequest('POST', url)
//               ..fields['upload_preset'] = presetName
//               ..files.add(
//                 await http.MultipartFile.fromPath(
//                   'file',
//                   provider.statusImageFile!.path,
//                 ),
//               );

//         final response = await request.send();
//         if (response.statusCode == 200) {
//           final responseData = await response.stream.toBytes();
//           final responseString = utf8.decode(responseData);
//           final jsonMap = jsonDecode(responseString);

//           await FirebaseFirestore.instance
//               .collection('posts')
//               .doc(Uuid().v1())
//               .set({
//                 'userId': FirebaseAuth.instance.currentUser!.uid,
//                 "postId": Uuid().v1(),
//                 'description':
//                     descripptionController.text.isNotEmpty
//                         ? descripptionController.text
//                         : null,
//                 'imageUrl': jsonMap['url'],
//                 'location': provider.selectedCoffeeShop,
//                 'createdAt': Timestamp.now(),
//                 'likes': [], // Initially empty
//               });

//           Provider.of<AddStatusStateManegement>(context, listen: false)
//               .statusImageFile = null;
//           Provider.of<AddStatusStateManegement>(
//             context,
//             listen: false,
//           ).changeEditability();

//           Provider.of<BottomNavbarStateManagement>(
//             context,
//             listen: false,
//           ).changeBottomNavbar(0);
//         }
//       }
//     } catch (err) {
//       EasyLoading.showError(err.toString());
//     } finally {
//       EasyLoading.dismiss();
//     }
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     descripptionController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: Image.asset("assets/logo/logo_kivaloop.png", width: 150.w),
//       ),
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         margin: EdgeInsets.symmetric(horizontal: 20.w),

//         child: SingleChildScrollView(
//           child: Column(
//             spacing: 10.h,
//             children: [
//               Container(
//                 height: 50.h,
//                 color: Color(0xff6F4E37),
//                 width: double.infinity,
//                 child: Center(
//                   child: Text(
//                     "Share Your Coffee Moments",
//                     style: GoogleFonts.roboto(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),

//               Card(
//                 color: Colors.white,
//                 elevation: 4,
//                 child: ListTile(
//                   leading: CircleAvatar(radius: 22.r),
//                   title: Text(
//                     "UserName",
//                     style: GoogleFonts.roboto(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                     "Share your coffee moments",
//                     style: GoogleFonts.roboto(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),

//               Card(
//                 elevation: 4,
//                 color: Colors.white,
//                 child: GestureDetector(
//                   onTap: () {
//                     Provider.of<AddStatusStateManegement>(
//                       context,
//                       listen: false,
//                     ).selectStatusImage();
//                   },
//                   child:
//                       Provider.of<AddStatusStateManegement>(
//                                 context,
//                                 listen: false,
//                               ).statusImageFile !=
//                               null
//                           ? Image.file(
//                             Provider.of<AddStatusStateManegement>(
//                               context,
//                               listen: false,
//                             ).statusImageFile!,
//                             height: 230.h,
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                           )
//                           : Container(
//                             height: 230.h,
//                             width: double.infinity,
//                             child: Column(
//                               spacing: 10.h,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Iconsax.camera,
//                                   size: 45.sp,
//                                   color: Color(0xff6F4E37),
//                                 ),
//                                 Text(
//                                   "Add your moments",
//                                   style: GoogleFonts.roboto(
//                                     fontSize: 15.sp,
//                                     fontWeight: FontWeight.w500,
//                                     color: Color(0xff6F4E37),
//                                   ),
//                                 ),
//                                 Text(
//                                   "Tap to upload",
//                                   style: GoogleFonts.roboto(
//                                     fontSize: 12.sp,
//                                     color: Color(0xff6F4E37),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                 ),
//               ),

//               Card(
//                 elevation: 4,
//                 color: Colors.white,
//                 child: TextFormField(
//                   controller: descripptionController,
//                   maxLines: 5,
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.only(left: 15.w, top: 15.h),
//                     hintText: "Write something about your experience",
//                     hintStyle: GoogleFonts.roboto(
//                       color: Colors.black.withOpacity(0.5),
//                       fontSize: 14,
//                     ),
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),

//               Card(
//                 color: Colors.white,
//                 elevation: 4,
//                 child: ListTile(
//                   leading: Icon(Iconsax.location),
//                   title:
//                       Provider.of<AddStatusStateManegement>(
//                             context,
//                             listen: false,
//                           ).isEditing
//                           ? Column(
//                             children: [
//                               TextFormField(
//                                 onChanged: (value) {
//                                   var provider =
//                                       Provider.of<AddStatusStateManegement>(
//                                         context,
//                                         listen: false,
//                                       );
//                                   provider.setSearchedText(value);
//                                   provider.searchCoffeeShops(
//                                     provider.searchedText!,
//                                   );
//                                 },
//                                 decoration: InputDecoration(
//                                   hintText: "Add cafe name",
//                                   hintStyle: GoogleFonts.roboto(
//                                     color: Colors.black.withOpacity(0.5),
//                                     fontSize: 14,
//                                   ),
//                                   border: InputBorder.none,
//                                 ),
//                               ),

//                               Container(
//                                 height:
//                                     Provider.of<AddStatusStateManegement>(
//                                           context,
//                                         ).searchedResult.isEmpty
//                                         ? 2
//                                         : 250,
//                                 child: ListView.builder(
//                                   itemCount:
//                                       Provider.of<AddStatusStateManegement>(
//                                         context,
//                                       ).searchedResult.length,
//                                   itemBuilder: (context, index) {
//                                     return ListTile(
//                                       title: Text(
//                                         Provider.of<AddStatusStateManegement>(
//                                           context,
//                                         ).searchedResult[index],
//                                         style: GoogleFonts.roboto(fontSize: 13),
//                                       ),
//                                       onTap: () {
//                                         var provider = Provider.of<
//                                           AddStatusStateManegement
//                                         >(context, listen: false);

//                                         provider.changeCoffeeShop(
//                                           provider.searchedResult[index],
//                                         );
//                                         provider.changeEditability();
//                                         provider.searchedResult.clear();
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ],
//                           )
//                           : Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 10,
//                               vertical: 15,
//                             ),
//                             decoration: BoxDecoration(
//                               border: Border.all(),
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     Provider.of<AddStatusStateManegement>(
//                                           context,
//                                           listen: false,
//                                         ).selectedCoffeeShop ??
//                                         "",
//                                     style: GoogleFonts.roboto(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 12,
//                                     ),
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),

//                                 GestureDetector(
//                                   onTap: () {
//                                     Provider.of<AddStatusStateManegement>(
//                                       context,
//                                       listen: false,
//                                     ).changeEditability();
//                                   },
//                                   child: Icon(Iconsax.edit_2, size: 16),
//                                 ),
//                               ],
//                             ),
//                           ),
//                 ),
//               ),

//               GestureDetector(
//                 onTap: () async {
//                   await postStatus();
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(vertical: 10.h),
//                       child: Text(
//                         "Post",
//                         style: GoogleFonts.roboto(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               SizedBox(height: 20.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ---------------------------------- 2222222222222222222222222222222 ------------------------------------
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kivaloop/State-Management/AddPostState/add_status_state_manegement.dart';
import 'package:kivaloop/State-Management/BottomNavbarState/bottom_navbar_state_management.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController descripptionController = TextEditingController();
  final FocusNode _descriptionFocus = FocusNode();

  Future postStatus() async {
    var provider = Provider.of<AddStatusStateManegement>(
      context,
      listen: false,
    );
    try {
      EasyLoading.show();
      String cloudName = "dypsfkqhj";
      String presetName = "kivaloop_story";
      if (provider.statusImageFile != null) {
        final url = Uri.parse(
          "https://api.cloudinary.com/v1_1/$cloudName/upload",
        );
        final request =
            http.MultipartRequest('POST', url)
              ..fields['upload_preset'] = presetName
              ..files.add(
                await http.MultipartFile.fromPath(
                  'file',
                  provider.statusImageFile!.path,
                ),
              );

        final response = await request.send();
        if (response.statusCode == 200) {
          final responseData = await response.stream.toBytes();
          final responseString = utf8.decode(responseData);
          final jsonMap = jsonDecode(responseString);

          await FirebaseFirestore.instance
              .collection('posts')
              .doc(Uuid().v1())
              .set({
                'userId': FirebaseAuth.instance.currentUser!.uid,
                "postId": Uuid().v1(),
                'description':
                    descripptionController.text.isNotEmpty
                        ? descripptionController.text
                        : null,
                'imageUrl': jsonMap['url'],
                'location': provider.selectedCoffeeShop,
                'createdAt': Timestamp.now(),
                'likes': [],
              });

          Provider.of<AddStatusStateManegement>(context, listen: false)
              .statusImageFile = null;
          Provider.of<AddStatusStateManegement>(
            context,
            listen: false,
          ).changeEditability();

          Provider.of<BottomNavbarStateManagement>(
            context,
            listen: false,
          ).changeBottomNavbar(0);
        }
      }
    } catch (err) {
      EasyLoading.showError(err.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void dispose() {
    descripptionController.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF8F5),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 80.h,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: Color(0xFF5C4033),
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
                        // Back Button & Title
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Provider.of<BottomNavbarStateManagement>(
                                  context,
                                  listen: false,
                                ).changeBottomNavbar(0);
                              },
                              child: Container(
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
                                child: Icon(
                                  Iconsax.arrow_left,
                                  size: 22,
                                  color: Color(0xFF2D2D2D),
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Create Post",
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2D2D2D),
                                  ),
                                ),
                                Text(
                                  "Share your coffee moments",
                                  style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Post Button in AppBar
                        GestureDetector(
                          onTap: () async {
                            await postStatus();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF8B6914), Color(0xFF5C4033)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF5C4033).withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Iconsax.send_1,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  "Post",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
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
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  // Hero Banner
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
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
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF5C4033).withOpacity(0.3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Decorative Elements
                        Positioned(
                          right: -20,
                          top: -20,
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.05),
                            ),
                          ),
                        ),
                        Positioned(
                          left: -10,
                          bottom: -10,
                          child: Icon(
                            Iconsax.coffee5,
                            size: 60,
                            color: Colors.white.withOpacity(0.08),
                          ),
                        ),

                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                Iconsax.camera,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Share Your Coffee Moments ☕",
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "Let the world see your perfect brew",
                                    style: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // User Info Card
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Color(0xFFFFD700), Color(0xFF5C4033)],
                            ),
                          ),
                          child: Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Icon(
                              Iconsax.user,
                              color: Colors.grey[500],
                              size: 24,
                            ),
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Coffee Lover",
                                style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2D2D2D),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 3.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF5C4033).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Iconsax.global,
                                          size: 12,
                                          color: Color(0xFF5C4033),
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          "Public",
                                          style: GoogleFonts.roboto(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF5C4033),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(
                                    Iconsax.arrow_down_1,
                                    size: 14,
                                    color: Colors.grey[500],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F0EB),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Iconsax.setting_4,
                            size: 20,
                            color: Color(0xFF5C4033),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Image Upload Section
                  GestureDetector(
                    onTap: () {
                      Provider.of<AddStatusStateManegement>(
                        context,
                        listen: false,
                      ).selectStatusImage();
                    },
                    child: Consumer<AddStatusStateManegement>(
                      builder: (context, provider, child) {
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child:
                              provider.statusImageFile != null
                                  ? Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: Image.file(
                                          provider.statusImageFile!,
                                          height: 280.h,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      // Gradient Overlay
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          height: 80.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.vertical(
                                              bottom: Radius.circular(24),
                                            ),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.transparent,
                                                Colors.black.withOpacity(0.5),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Edit/Change Button
                                      Positioned(
                                        top: 16,
                                        right: 16,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 14.w,
                                            vertical: 8.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(
                                              0.5,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Iconsax.edit_2,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 6.w),
                                              Text(
                                                "Change",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Image Info
                                      Positioned(
                                        bottom: 16,
                                        left: 16,
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 6.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(
                                                  0.2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Iconsax.image,
                                                    size: 14,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 6.w),
                                                  Text(
                                                    "Photo ready",
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 11.sp,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                  : Container(
                                    height: 240.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(
                                        color: Color(
                                          0xFF5C4033,
                                        ).withOpacity(0.2),
                                        width: 2,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 80.h,
                                          width: 80.w,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(
                                                  0xFF5C4033,
                                                ).withOpacity(0.1),
                                                Color(
                                                  0xFF8B6914,
                                                ).withOpacity(0.1),
                                              ],
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Iconsax.camera,
                                            size: 36,
                                            color: Color(0xFF5C4033),
                                          ),
                                        ),
                                        SizedBox(height: 20.h),
                                        Text(
                                          "Add Your Coffee Moment",
                                          style: GoogleFonts.playfairDisplay(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2D2D2D),
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          "Tap to upload a photo",
                                          style: GoogleFonts.roboto(
                                            fontSize: 13.sp,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                        SizedBox(height: 16.h),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20.w,
                                            vertical: 10.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Color(
                                              0xFF5C4033,
                                            ).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Iconsax.gallery_add,
                                                size: 18,
                                                color: Color(0xFF5C4033),
                                              ),
                                              SizedBox(width: 8.w),
                                              Text(
                                                "Choose from gallery",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF5C4033),
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
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Description Input
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
                          child: Row(
                            children: [
                              Icon(
                                Iconsax.edit,
                                size: 18,
                                color: Color(0xFF5C4033),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "What's brewing?",
                                style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2D2D2D),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: descripptionController,
                          focusNode: _descriptionFocus,
                          maxLines: 4,
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            color: Color(0xFF2D2D2D),
                            height: 1.5,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20.w),
                            hintText:
                                "Share your coffee experience, the aroma, the taste, the vibe... ☕✨",
                            hintStyle: GoogleFonts.roboto(
                              color: Colors.grey[400],
                              fontSize: 14.sp,
                              height: 1.5,
                            ),
                            border: InputBorder.none,
                          ),
                        ),

                        // Quick Tags
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                          child: Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: [
                              _buildQuickTag("☕ Coffee"),
                              _buildQuickTag("🌅 Morning Vibes"),
                              _buildQuickTag("📖 Work Mode"),
                              _buildQuickTag("💬 Catching up"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Location Section
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Consumer<AddStatusStateManegement>(
                      builder: (context, provider, child) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE91E63).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Iconsax.location,
                                      size: 20,
                                      color: Color(0xFFE91E63),
                                    ),
                                  ),
                                  SizedBox(width: 14.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Add Location",
                                          style: GoogleFonts.roboto(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF2D2D2D),
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          "Where are you enjoying your coffee?",
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

                            Divider(height: 1, color: Colors.grey[100]),

                            provider.isEditing
                                ? Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                      ),
                                      child: TextFormField(
                                        onChanged: (value) {
                                          provider.setSearchedText(value);
                                          provider.searchCoffeeShops(
                                            provider.searchedText!,
                                          );
                                        },
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.sp,
                                          color: Color(0xFF2D2D2D),
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Search for a café...",
                                          hintStyle: GoogleFonts.roboto(
                                            color: Colors.grey[400],
                                            fontSize: 14.sp,
                                          ),
                                          prefixIcon: Icon(
                                            Iconsax.search_normal,
                                            size: 20,
                                            color: Colors.grey[400],
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16.w,
                                            vertical: 14.h,
                                          ),
                                        ),
                                      ),
                                    ),

                                    if (provider.searchedResult.isNotEmpty)
                                      Container(
                                        constraints: BoxConstraints(
                                          maxHeight: 200.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFAF8F5),
                                          borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(20),
                                          ),
                                        ),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8.h,
                                          ),
                                          itemCount:
                                              provider.searchedResult.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                provider.changeCoffeeShop(
                                                  provider
                                                      .searchedResult[index],
                                                );
                                                provider.changeEditability();
                                                provider.searchedResult.clear();
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 16.w,
                                                  vertical: 12.h,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(
                                                        8,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Color(
                                                          0xFF5C4033,
                                                        ).withOpacity(0.1),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                      ),
                                                      child: Icon(
                                                        Iconsax.coffee,
                                                        size: 16,
                                                        color: Color(
                                                          0xFF5C4033,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 12.w),
                                                    Expanded(
                                                      child: Text(
                                                        provider
                                                            .searchedResult[index],
                                                        style:
                                                            GoogleFonts.roboto(
                                                              fontSize: 14.sp,
                                                              color: Color(
                                                                0xFF2D2D2D,
                                                              ),
                                                            ),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Iconsax.arrow_right_3,
                                                      size: 16,
                                                      color: Colors.grey[400],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                  ],
                                )
                                : provider.selectedCoffeeShop != null
                                ? Padding(
                                  padding: EdgeInsets.all(16.w),
                                  child: Container(
                                    padding: EdgeInsets.all(14.w),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF5C4033).withOpacity(0.05),
                                          Color(0xFF8B6914).withOpacity(0.05),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Color(
                                          0xFF5C4033,
                                        ).withOpacity(0.2),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF5C4033),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Icon(
                                            Iconsax.location5,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                provider.selectedCoffeeShop!,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF2D2D2D),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "Tap to change location",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 11.sp,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            provider.changeEditability();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.05),
                                                  blurRadius: 8,
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              Iconsax.edit_2,
                                              size: 16,
                                              color: Color(0xFF5C4033),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                : Padding(
                                  padding: EdgeInsets.all(16.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      provider.changeEditability();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(14.w),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFAF8F5),
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: Colors.grey[200]!,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Iconsax.add,
                                            size: 18,
                                            color: Color(0xFF5C4033),
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            "Add café location",
                                            style: GoogleFonts.roboto(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF5C4033),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                          ],
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Additional Options
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildOptionRow(
                          icon: Iconsax.tag_user,
                          iconColor: Color(0xFF2196F3),
                          title: "Tag People",
                          subtitle: "Who are you with?",
                        ),
                        Divider(height: 24.h, color: Colors.grey[100]),
                        _buildOptionRow(
                          icon: Iconsax.music,
                          iconColor: Color(0xFF9C27B0),
                          title: "Add Music",
                          subtitle: "What's playing?",
                        ),
                        Divider(height: 24.h, color: Colors.grey[100]),
                        _buildOptionRow(
                          icon: Iconsax.emoji_happy,
                          iconColor: Color(0xFFFF9800),
                          title: "Feeling/Activity",
                          subtitle: "Share your mood",
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Post Button (Bottom)
                  GestureDetector(
                    onTap: () async {
                      await postStatus();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
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
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF5C4033).withOpacity(0.4),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.send_1, size: 22, color: Colors.white),
                          SizedBox(width: 12.w),
                          Text(
                            "Share Your Moment",
                            style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickTag(String text) {
    return GestureDetector(
      onTap: () {
        if (descripptionController.text.isNotEmpty) {
          descripptionController.text = "${descripptionController.text} $text";
        } else {
          descripptionController.text = text;
        }
        descripptionController.selection = TextSelection.fromPosition(
          TextPosition(offset: descripptionController.text.length),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Color(0xFF5C4033).withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xFF5C4033).withOpacity(0.15)),
        ),
        child: Text(
          text,
          style: GoogleFonts.roboto(
            fontSize: 12.sp,
            color: Color(0xFF5C4033),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildOptionRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.roboto(
                  fontSize: 12.sp,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        Icon(Iconsax.arrow_right_3, size: 18, color: Colors.grey[400]),
      ],
    );
  }
}
