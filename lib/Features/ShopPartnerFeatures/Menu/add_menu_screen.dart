import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:kivaloop/Features/ShopPartnerFeatures/shop_partner_bottom_navbar_screen.dart';
import 'package:kivaloop/State-Management/ShopPartnerStateManagement/add_menu_item_state_management.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddMenuScreen extends StatefulWidget {
  const AddMenuScreen({super.key});

  @override
  State<AddMenuScreen> createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

  Future addMenuItem(BuildContext context) async {
    var provider = Provider.of<AddMenuItemStateManagement>(
      context,
      listen: false,
    );
    try {
      EasyLoading.show();
      String cloudName = "dypsfkqhj";
      String presetName = "kivaloop_story";
      if (provider.menuItemImageFile != null) {
        final url = Uri.parse(
          "https://api.cloudinary.com/v1_1/$cloudName/upload",
        );
        final request =
            http.MultipartRequest('POST', url)
              ..fields['upload_preset'] = presetName
              ..fields['folder'] = 'menu_items'
              ..files.add(
                await http.MultipartFile.fromPath(
                  'file',
                  provider.menuItemImageFile!.path,
                ),
              );

        final response = await request.send();
        if (response.statusCode == 200) {
          final responseData = await response.stream.toBytes();
          final responseString = utf8.decode(responseData);
          final jsonMap = jsonDecode(responseString);

          QuerySnapshot querySnapshot =
              await FirebaseFirestore.instance
                  .collection("shops")
                  .where(
                    "ownerId",
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                  )
                  .get();

          final shopId = querySnapshot.docs.first.id;

          if (shopId != null) {
            await FirebaseFirestore.instance
                .collection('shops')
                .doc(shopId)
                .collection("menus")
                .doc(Uuid().v1())
                .set({
                  'ownerId': FirebaseAuth.instance.currentUser!.uid,
                  'shopId': shopId,
                  'itemName': itemNameController.text.trim(),
                  'itemDescription': itemDescriptionController.text.trim(),
                  'itemImage': jsonMap['url'],
                  'itemPrice': itemPriceController.text.trim(),
                  'comments': commentsController.text.trim(),
                  'sizes': "",
                  'available': true,

                  // Initially empty
                });

            Provider.of<AddMenuItemStateManagement>(context, listen: false)
                .menuItemImageFile = null;

            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ShopPartnerBottomNavbarScreen(),
              ),
            );
          }
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
    itemNameController.dispose();
    itemDescriptionController.dispose();
    itemPriceController.dispose();
    commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Menu Items"),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          spacing: 5.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Item Photo",
                              style: GoogleFonts.roboto(fontSize: 12.sp),
                            ),
                            Container(
                              height: 150.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Consumer<AddMenuItemStateManagement>(
                                builder: (context, provider, child) {
                                  return provider.menuItemImageFile != null
                                      ? Image.file(
                                        provider.menuItemImageFile!,
                                        height: 150.h,
                                        fit: BoxFit.cover,
                                      )
                                      : GestureDetector(
                                        onTap: () {
                                          provider.selectMenuItem();
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Iconsax.camera, size: 25.sp),
                                            Text(
                                              "Upload Menu",
                                              style: GoogleFonts.roboto(
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                },
                              ),
                            ),
                          ],
                        ),

                        Column(
                          spacing: 5.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Item Name",
                              style: GoogleFonts.roboto(fontSize: 12.sp),
                            ),
                            TextFormField(
                              controller: itemNameController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.key),
                                hintText: "Item name",
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
                              "item Description",
                              style: GoogleFonts.roboto(fontSize: 12.sp),
                            ),
                            TextFormField(
                              controller: itemDescriptionController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.key),
                                hintText: "Item Description",
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
                              "Item Price",
                              style: GoogleFonts.roboto(fontSize: 12.sp),
                            ),
                            TextFormField(
                              controller: itemPriceController,
                              decoration: InputDecoration(
                                hintText: "Item price",
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
                              "Comments",
                              style: GoogleFonts.roboto(fontSize: 12.sp),
                            ),
                            TextFormField(
                              controller: commentsController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.key),
                                hintText: "Comments",
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

                        // Submit Button
                        ElevatedButton(
                          child: const Text('Save'),
                          onPressed: () async {
                            if (itemNameController.text.isEmpty ||
                                itemDescriptionController.text.isEmpty ||
                                itemPriceController.text.isEmpty) {
                              EasyLoading.showError(
                                "Please fill all the fields",
                              );
                            } else {
                              await addMenuItem(context);
                            }
                          },
                        ),

                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
