import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:kivaloop/Features/Auth/login_screen.dart';
import 'package:kivaloop/State-Management/user_info_state_management.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? profileImageFile;
  String? profileImageUrl;
  bool _isEditing = false;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserInfoStateManagement>(
      context,
      listen: false,
    ).fetchUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Iconsax.setting),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(Iconsax.notification),
              ),
              GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  EasyLoading.showSuccess("Successfully Logged out");
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(Iconsax.logout),
                ),
              ),
            ],
          ),
        ],
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  spacing: 15,
                  children: [
                    Container(
                      height: 140,
                      width: 120,
                      child: Stack(
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(
                                color: Color(0xff745340),
                                width: 3,
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  Provider.of<UserInfoStateManagement>(
                                            context,
                                          ).userProfileImage !=
                                          null
                                      ? Provider.of<UserInfoStateManagement>(
                                        context,
                                      ).userProfileImage
                                      : "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            child: GestureDetector(
                              onTap: () async {
                                String cloudName = "dypsfkqhj";
                                String presetName = "kivaloop_user";
                                final ImagePicker picker = ImagePicker();

                                // Pick an image.
                                final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery,
                                );

                                if (image != null) {
                                  File imageFile = File(image.path);

                                  setState(() {
                                    profileImageFile = imageFile;
                                  });

                                  final url = Uri.parse(
                                    "https://api.cloudinary.com/v1_1/$cloudName/upload",
                                  );
                                  final request =
                                      http.MultipartRequest('POST', url)
                                        ..fields['upload_preset'] = presetName
                                        ..files.add(
                                          await http.MultipartFile.fromPath(
                                            'file',
                                            profileImageFile!.path,
                                          ),
                                        );

                                  final response = await request.send();

                                  if (response.statusCode == 200) {
                                    final responseData =
                                        await response.stream.toBytes();
                                    final responseString = utf8.decode(
                                      responseData,
                                    );
                                    final jsonMap = jsonDecode(responseString);

                                    setState(() {
                                      profileImageUrl = jsonMap['url'];
                                      print(profileImageUrl);
                                    });

                                    await FirebaseFirestore.instance
                                        .collection("UserData")
                                        .doc(
                                          FirebaseAuth
                                              .instance
                                              .currentUser!
                                              .uid,
                                        )
                                        .update({
                                          "profileImageUrl": profileImageUrl,
                                        });
                                  }
                                }
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Color(0xff745340),
                                    width: 3,
                                  ),
                                ),
                                child: Icon(Iconsax.edit_2, size: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _isEditing
                            ? SizedBox(
                              width: 200,
                              child: TextField(
                                controller: _controller,
                                autofocus: true,
                                onSubmitted: (value) async {
                                  if (value.trim().isNotEmpty) {
                                    Provider.of<UserInfoStateManagement>(
                                      context,
                                      listen: false,
                                    ).updateUserName(value.trim());

                                    await FirebaseFirestore.instance
                                        .collection("UserData")
                                        .doc(
                                          FirebaseAuth
                                              .instance
                                              .currentUser!
                                              .uid,
                                        )
                                        .update({"userName": value.trim()});
                                  }
                                  setState(() {
                                    _isEditing = false;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter your name",
                                  hintStyle: GoogleFonts.roboto(fontSize: 12),
                                  border: OutlineInputBorder(),
                                ),
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                            : GestureDetector(
                              onTap: () {
                                _controller.text =
                                    Provider.of<UserInfoStateManagement>(
                                      context,
                                      listen: false,
                                    ).userName;
                                setState(() {
                                  _isEditing = true;
                                });
                              },
                              child: Row(
                                spacing: 6,
                                children: [
                                  Text(
                                    Provider.of<UserInfoStateManagement>(
                                              context,
                                            ).userName !=
                                            ""
                                        ? Provider.of<UserInfoStateManagement>(
                                          context,
                                        ).userName
                                        : "Please set your User Name",
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (_isEditing &&
                                          _controller.text.trim().isNotEmpty) {
                                        Provider.of<UserInfoStateManagement>(
                                          context,
                                          listen: false,
                                        ).updateUserName(
                                          _controller.text.trim(),
                                        );
                                      }
                                      setState(() {
                                        _isEditing = !_isEditing;
                                      });
                                    },
                                    child: Icon(Iconsax.edit_2, size: 14),
                                  ),
                                ],
                              ),
                            ),
                      ],
                    ),

                    Text(
                      Provider.of<UserInfoStateManagement>(context).userEmail,
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Container(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       Container(
              //         height: 85,
              //         width: 73,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(color: Color(0xff745340)),
              //         ),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           children: [
              //             Icon(Iconsax.emoji_happy),
              //             Text(
              //               "Good Mood",
              //               textAlign: TextAlign.center,
              //               style: GoogleFonts.roboto(
              //                 fontSize: 14,
              //                 color: Color(0xff745340),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Container(
              //         height: 85,
              //         width: 73,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(color: Color(0xff745340)),
              //         ),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           children: [
              //             Icon(Iconsax.shield),
              //             Text(
              //               "1st Subscribetion",
              //               textAlign: TextAlign.center,
              //               style: GoogleFonts.roboto(
              //                 fontSize: 14,
              //                 color: Color(0xff745340),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),

              //       Container(
              //         height: 85,
              //         width: 73,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(color: Color(0xff745340)),
              //         ),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           children: [
              //             Icon(Iconsax.coffee),
              //             Text(
              //               "Ice Americano",
              //               textAlign: TextAlign.center,
              //               style: GoogleFonts.roboto(
              //                 fontSize: 14,
              //                 color: Color(0xff745340),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),

              //       Container(
              //         height: 85,
              //         width: 73,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(color: Color(0xff745340)),
              //         ),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           children: [
              //             Icon(Iconsax.star),
              //             Text(
              //               "5 Cafe Reviews",
              //               textAlign: TextAlign.center,
              //               style: GoogleFonts.roboto(
              //                 fontSize: 14,
              //                 color: Color(0xff745340),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 40),

              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 26),
              //   child: Column(
              //     spacing: 20,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Drink of the day",
              //         style: GoogleFonts.roboto(
              //           fontSize: 20,
              //           fontWeight: FontWeight.w700,
              //         ),
              //       ),

              //       Row(
              //         children: [
              //           Container(
              //             width: 170,
              //             height: 90,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               image: DecorationImage(
              //                 fit: BoxFit.cover,
              //                 image: NetworkImage(
              //                   "https://images.unsplash.com/photo-1620360289986-d9e73a6f475b?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              //                 ),
              //               ),
              //             ),
              //           ),
              //           SizedBox(width: 20),

              //           Expanded(
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   "Affogato",
              //                   style: GoogleFonts.roboto(
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w600,
              //                   ),
              //                 ),

              //                 Text(
              //                   "ordered 5 times in a row",
              //                   style: GoogleFonts.roboto(
              //                     fontSize: 12,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                 ),

              //                 Row(
              //                   mainAxisAlignment: MainAxisAlignment.end,
              //                   children: [
              //                     Text(
              //                       "Order again",
              //                       style: GoogleFonts.roboto(
              //                         fontSize: 12,
              //                         fontWeight: FontWeight.w700,
              //                         color: Color(0xff745340),
              //                       ),
              //                     ),
              //                     Icon(Iconsax.arrow_right_1),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  spacing: 14,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Posts",
                      style: GoogleFonts.roboto(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    GridView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 100,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return Container(color: Colors.grey.shade400);
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
