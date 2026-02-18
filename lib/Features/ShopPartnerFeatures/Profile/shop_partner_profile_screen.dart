import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ShopPartnerProfileScreen extends StatefulWidget {
  const ShopPartnerProfileScreen({super.key});

  @override
  State<ShopPartnerProfileScreen> createState() =>
      _ShopPartnerProfileScreenState();
}

class _ShopPartnerProfileScreenState extends State<ShopPartnerProfileScreen> {
  Future fetchShopInformation() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance
            .collection("shops")
            .where("ownerId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchShopInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset("assets/logo/logo_kivaloop.png", width: 120),
      ),
      body: Container(
        child: FutureBuilder(
          future: fetchShopInformation(),
          builder: (context, snappshots) {
            if (snappshots.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (!snappshots.hasData) {
                return Center(child: Text("No data to show"));
              } else {
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xff9c5d29),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.h,
                          horizontal: 20.w,
                        ),
                        child: Row(
                          spacing: 8.w,
                          children: [
                            CircleAvatar(
                              radius: 40.sp,
                              backgroundImage: NetworkImage(
                                snappshots.data["shopLogo"],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snappshots.data["shopname"],
                                    style: GoogleFonts.roboto(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    snappshots.data["shopDescription"],
                                    style: GoogleFonts.roboto(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // --------------------------------------------------------------------
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
                                "Shop Information",
                                style: GoogleFonts.roboto(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.h),

                              Row(
                                spacing: 15.w,
                                children: [
                                  Icon(Iconsax.location),
                                  Expanded(
                                    child: Text(snappshots.data["shopAddress"]),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: 15.w,
                                children: [
                                  Icon(Iconsax.call),
                                  Expanded(
                                    child: Text(snappshots.data["shopPhone"]),
                                  ),
                                ],
                              ),

                              Row(
                                spacing: 15.w,
                                children: [
                                  Icon(Iconsax.sms),
                                  Expanded(
                                    child: Text(snappshots.data["shopEmail"]),
                                  ),
                                ],
                              ),

                              Row(
                                spacing: 15.w,
                                children: [
                                  Icon(Iconsax.clock),
                                  Expanded(
                                    child: Text(snappshots.data["shopOpHour"]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
