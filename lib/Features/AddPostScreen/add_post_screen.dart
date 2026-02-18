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
                'likes': [], // Initially empty
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
    // TODO: implement dispose
    descripptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Image.asset("assets/logo/logo_kivaloop.png", width: 150.w),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.symmetric(horizontal: 20.w),

        child: SingleChildScrollView(
          child: Column(
            spacing: 10.h,
            children: [
              Container(
                height: 50.h,
                color: Color(0xff6F4E37),
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Share Your Coffee Moments",
                    style: GoogleFonts.roboto(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              Card(
                color: Colors.white,
                elevation: 4,
                child: ListTile(
                  leading: CircleAvatar(radius: 22.r),
                  title: Text(
                    "UserName",
                    style: GoogleFonts.roboto(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Share your coffee moments",
                    style: GoogleFonts.roboto(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              Card(
                elevation: 4,
                color: Colors.white,
                child: GestureDetector(
                  onTap: () {
                    Provider.of<AddStatusStateManegement>(
                      context,
                      listen: false,
                    ).selectStatusImage();
                  },
                  child:
                      Provider.of<AddStatusStateManegement>(
                                context,
                                listen: false,
                              ).statusImageFile !=
                              null
                          ? Image.file(
                            Provider.of<AddStatusStateManegement>(
                              context,
                              listen: false,
                            ).statusImageFile!,
                            height: 230.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                          : Container(
                            height: 230.h,
                            width: double.infinity,
                            child: Column(
                              spacing: 10.h,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Iconsax.camera,
                                  size: 45.sp,
                                  color: Color(0xff6F4E37),
                                ),
                                Text(
                                  "Add your moments",
                                  style: GoogleFonts.roboto(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff6F4E37),
                                  ),
                                ),
                                Text(
                                  "Tap to upload",
                                  style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    color: Color(0xff6F4E37),
                                  ),
                                ),
                              ],
                            ),
                          ),
                ),
              ),

              Card(
                elevation: 4,
                color: Colors.white,
                child: TextFormField(
                  controller: descripptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15.w, top: 15.h),
                    hintText: "Write something about your experience",
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),

              Card(
                color: Colors.white,
                elevation: 4,
                child: ListTile(
                  leading: Icon(Iconsax.location),
                  title:
                      Provider.of<AddStatusStateManegement>(
                            context,
                            listen: false,
                          ).isEditing
                          ? Column(
                            children: [
                              TextFormField(
                                onChanged: (value) {
                                  var provider =
                                      Provider.of<AddStatusStateManegement>(
                                        context,
                                        listen: false,
                                      );
                                  provider.setSearchedText(value);
                                  provider.searchCoffeeShops(
                                    provider.searchedText!,
                                  );
                                },
                                decoration: InputDecoration(
                                  hintText: "Add cafe name",
                                  hintStyle: GoogleFonts.roboto(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),

                              Container(
                                height:
                                    Provider.of<AddStatusStateManegement>(
                                          context,
                                        ).searchedResult.isEmpty
                                        ? 2
                                        : 250,
                                child: ListView.builder(
                                  itemCount:
                                      Provider.of<AddStatusStateManegement>(
                                        context,
                                      ).searchedResult.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        Provider.of<AddStatusStateManegement>(
                                          context,
                                        ).searchedResult[index],
                                        style: GoogleFonts.roboto(fontSize: 13),
                                      ),
                                      onTap: () {
                                        var provider = Provider.of<
                                          AddStatusStateManegement
                                        >(context, listen: false);

                                        provider.changeCoffeeShop(
                                          provider.searchedResult[index],
                                        );
                                        provider.changeEditability();
                                        provider.searchedResult.clear();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                          : Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    Provider.of<AddStatusStateManegement>(
                                          context,
                                          listen: false,
                                        ).selectedCoffeeShop ??
                                        "",
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    Provider.of<AddStatusStateManegement>(
                                      context,
                                      listen: false,
                                    ).changeEditability();
                                  },
                                  child: Icon(Iconsax.edit_2, size: 16),
                                ),
                              ],
                            ),
                          ),
                ),
              ),

              GestureDetector(
                onTap: () async {
                  await postStatus();
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Text(
                        "Post",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
