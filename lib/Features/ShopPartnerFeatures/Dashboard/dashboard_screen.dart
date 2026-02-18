import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kivaloop/Features/ShopPartnerFeatures/Profile/add_shop_details_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<bool> isShopAvailable() async {
    final querySnapshot =
        await FirebaseFirestore.instance
            .collection("shops")
            .where("ownerId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get();

    return querySnapshot.docs.isNotEmpty;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // isShopAvailable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset("assets/logo/logo_kivaloop.png", width: 120),
      ),
      body: FutureBuilder<bool>(
        future: isShopAvailable(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final isShopRegistered = snapshot.data ?? false;
          if (isShopRegistered) {
            return Center(child: Text("Dashboard Screen"));
          } else {
            return Center(
              child: Container(
                padding: EdgeInsets.all(24.h),
                margin: EdgeInsets.symmetric(horizontal: 24.w),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.store_mall_directory_rounded,
                      size: 64.sp,
                      color: Color(0xFF745340),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "No Cafe Registered",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "You haven't added your café yet. Add your cafe to manage your menu and see your dashboard.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                    ),
                    SizedBox(height: 24.h),
                    ElevatedButton(
                      child: const Text('Add Cafe'),
                      onPressed: () {
                        // Navigate to Add Shop Screen
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => AddShopDetailsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
