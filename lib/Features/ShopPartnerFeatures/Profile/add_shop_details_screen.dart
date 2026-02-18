import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:kivaloop/Features/ShopPartnerFeatures/shop_partner_bottom_navbar_screen.dart';
import 'package:kivaloop/State-Management/GetUserLocation/user_location_state_management.dart';
import 'package:kivaloop/State-Management/ShopPartnerStateManagement/add_shop_details_state_management.dart';
import 'package:kivaloop/State-Management/user_info_state_management.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddShopDetailsScreen extends StatefulWidget {
  AddShopDetailsScreen({super.key});

  @override
  State<AddShopDetailsScreen> createState() => _AddShopDetailsScreenState();
}

class _AddShopDetailsScreenState extends State<AddShopDetailsScreen> {
  TextEditingController shopNameController = TextEditingController();

  TextEditingController shopDescriptionController = TextEditingController();

  TextEditingController shopAddressController = TextEditingController();

  TextEditingController shopPhoneController = TextEditingController();

  TextEditingController shopEmailController = TextEditingController();

  TextEditingController shopOpHourController = TextEditingController();

  Future postStatus(BuildContext context) async {
    var provider = Provider.of<AddShopDetailsStateManagement>(
      context,
      listen: false,
    );
    try {
      EasyLoading.show();
      String cloudName = "dypsfkqhj";
      String presetName = "kivaloop_story";
      if (provider.shopLogoImageFile != null) {
        final url = Uri.parse(
          "https://api.cloudinary.com/v1_1/$cloudName/upload",
        );
        final request =
            http.MultipartRequest('POST', url)
              ..fields['upload_preset'] = presetName
              ..fields['folder'] = 'shop_logos'
              ..files.add(
                await http.MultipartFile.fromPath(
                  'file',
                  provider.shopLogoImageFile!.path,
                ),
              );

        final response = await request.send();
        if (response.statusCode == 200) {
          final responseData = await response.stream.toBytes();
          final responseString = utf8.decode(responseData);
          final jsonMap = jsonDecode(responseString);

          await FirebaseFirestore.instance
              .collection('shops')
              .doc(Uuid().v1())
              .set({
                'ownerId': FirebaseAuth.instance.currentUser!.uid,
                'shopId': Uuid().v1(),
                'shopname': shopNameController.text.trim(),
                'shopDescription': shopDescriptionController.text.trim(),
                'shopLogo': jsonMap['url'],
                'shopAddress':
                    shopAddressController.text.isEmpty
                        ? provider.shopAddress
                        : shopAddressController.text.trim(),
                'latitude': provider.latitude,
                'longitude': provider.longitude,
                'shopPhone': shopPhoneController.text.trim(),
                'shopEmail': shopEmailController.text.trim(),
                'shopOpHour': shopOpHourController.text.trim(),
                'createdAt': Timestamp.now(),
                // Initially empty
              });

          Provider.of<AddShopDetailsStateManagement>(context, listen: false)
              .shopLogoImageFile = null;

          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ShopPartnerBottomNavbarScreen(),
            ),
          );
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
    shopNameController.dispose();
    shopDescriptionController.dispose();
    shopAddressController.dispose();
    shopPhoneController.dispose();
    shopEmailController.dispose();
    shopOpHourController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Shop Details"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Iconsax.arrow_left),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            spacing: 15.h,
            children: [
              // Basic Information
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 20.h,
                    ),
                    child: Column(
                      spacing: 12.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Basic Information",
                          style: GoogleFonts.roboto(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),

                        Column(
                          spacing: 5.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shop Name",
                              style: GoogleFonts.roboto(fontSize: 12.sp),
                            ),

                            TextFormField(
                              controller: shopNameController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.key),
                                hintText: "Shop name",
                                hintStyle: GoogleFonts.roboto(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Column(
                          spacing: 5.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shop Description",
                              style: GoogleFonts.roboto(fontSize: 12.sp),
                            ),
                            TextFormField(
                              controller: shopDescriptionController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.key),
                                hintText: "Shop description",
                                hintStyle: GoogleFonts.roboto(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Column(
                          spacing: 5.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shop Logo",
                              style: GoogleFonts.roboto(fontSize: 12.sp),
                            ),
                            Container(
                              height: 150.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Colors.black),
                              ),
                              child:
                                  Provider.of<AddShopDetailsStateManagement>(
                                            context,
                                            listen: false,
                                          ).shopLogoImageFile !=
                                          null
                                      ? Image.file(
                                        Provider.of<
                                          AddShopDetailsStateManagement
                                        >(
                                          context,
                                          listen: false,
                                        ).shopLogoImageFile!,
                                        height: 150.h,
                                        fit: BoxFit.cover,
                                      )
                                      : GestureDetector(
                                        onTap: () {
                                          Provider.of<
                                            AddShopDetailsStateManagement
                                          >(
                                            context,
                                            listen: false,
                                          ).selectShopLogo();
                                        },
                                        child: Column(
                                          spacing: 5.h,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Iconsax.camera, size: 25.sp),
                                            Text(
                                              "Upload Logo",
                                              style: GoogleFonts.roboto(
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Contact Information
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 20.h,
                    ),
                    child: Column(
                      spacing: 12.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact Information",
                          style: GoogleFonts.roboto(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),

                        Column(
                          spacing: 5.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shop Address",
                              style: GoogleFonts.roboto(fontSize: 12.sp),
                            ),

                            TextFormField(
                              controller: shopNameController,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () async {
                                    await Provider.of<
                                      AddShopDetailsStateManagement
                                    >(
                                      context,
                                      listen: false,
                                    ).determineShopAddress();
                                  },
                                  child: Icon(Iconsax.key),
                                ),
                                hintText:
                                    Provider.of<AddShopDetailsStateManagement>(
                                      context,
                                    ).shopAddress,
                                hintStyle: GoogleFonts.roboto(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Column(
                          spacing: 5.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shop Phone",
                              style: GoogleFonts.roboto(fontSize: 12.sp),
                            ),
                            TextFormField(
                              controller: shopPhoneController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.key),
                                hintText: "Shop Phone",
                                hintStyle: GoogleFonts.roboto(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Column(
                          spacing: 5.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shop Email",
                              style: GoogleFonts.roboto(fontSize: 12.sp),
                            ),
                            TextFormField(
                              controller: shopEmailController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.key),
                                hintText: "Write your shop email",
                                hintStyle: GoogleFonts.roboto(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Column(
                          spacing: 5.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Operating Hour",
                              style: GoogleFonts.roboto(fontSize: 12.sp),
                            ),
                            TextFormField(
                              controller: shopOpHourController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.key),
                                hintText: "Shop Operating hour",
                                hintStyle: GoogleFonts.roboto(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Submit Button
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () async {
                  if (shopNameController.text.isEmpty ||
                      shopDescriptionController.text.isEmpty ||
                      shopPhoneController.text.isEmpty ||
                      shopEmailController.text.isEmpty ||
                      shopOpHourController.text.isEmpty) {
                    EasyLoading.showError("Please fill all the fields");
                  } else {
                    await postStatus(context);
                  }
                },
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
