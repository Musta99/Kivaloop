import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kivaloop/Features/Auth/login_screen.dart';
import 'package:kivaloop/Features/ShopPartnerFeatures/shop_partner_bottom_navbar_screen.dart';
import 'package:kivaloop/State-Management/AddPostState/add_status_state_manegement.dart';
import 'package:kivaloop/State-Management/AddStories/add_stories_state_management.dart';
import 'package:kivaloop/State-Management/AuthenticationState/select_usertype_state_management.dart';
import 'package:kivaloop/State-Management/BottomNavbarState/bottom_navbar_state_management.dart';
import 'package:kivaloop/State-Management/GetUserLocation/user_location_state_management.dart';
import 'package:kivaloop/State-Management/ShopPartnerStateManagement/add_menu_item_state_management.dart';
import 'package:kivaloop/State-Management/ShopPartnerStateManagement/add_shop_details_state_management.dart';
import 'package:kivaloop/State-Management/ShopPartnerStateManagement/shop_partner_bottom_navbar_state.dart';
import 'package:kivaloop/State-Management/user_info_state_management.dart';
import 'package:kivaloop/bottom_navbar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? user = FirebaseAuth.instance.currentUser;

  Widget initialScreen;

  if (user == null) {
    // User not logged in
    initialScreen = LoginScreen();
  } else {
    // Fetch role
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("UserData")
        .doc(user.uid)
        .get();

    final userRole = snapshot["userType"];

    initialScreen = userRole == "Customer"
        ? BottomNavbarScreen()
        : ShopPartnerBottomNavbarScreen();
  }

  runApp(MyApp(initialScreen: BottomNavbarScreen()));
}

class MyApp extends StatelessWidget {
  Widget initialScreen;
  MyApp({super.key, required this.initialScreen});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Customer State Management
        ChangeNotifierProvider(
          create: (context) => BottomNavbarStateManagement(),
        ),
        ChangeNotifierProvider(create: (context) => UserInfoStateManagement()),
        ChangeNotifierProvider(
          create: (context) => SelectUsertypeStateManagement(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserLocationStateManagement(),
        ),
        ChangeNotifierProvider(create: (context) => AddStatusStateManegement()),
        ChangeNotifierProvider(
          create: (context) => AddStoriesStateManagement(),
        ),

        // Shop Partner State Management
        ChangeNotifierProvider(
          create: (context) => ShopPartnerBottomNavbarState(),
        ),

        ChangeNotifierProvider(
          create: (context) => AddShopDetailsStateManagement(),
        ),

        ChangeNotifierProvider(
          create: (context) => AddMenuItemStateManagement(),
        ),
      ],

      builder: (context, child) {
        return ScreenUtilInit(
          designSize: Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              builder: EasyLoading.init(),
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(scaffoldBackgroundColor: Color(0xffFCFCFC)),
              home:
              FirebaseAuth.instance.currentUser != null
                  ? initialScreen
                  : LoginScreen(),
            );

            // ShadApp(
            //   debugShowCheckedModeBanner: false,
            //   builder: EasyLoading.init(),
            //   home:
            //       FirebaseAuth.instance.currentUser != null
            //           ? initialScreen
            //           : LoginScreen(),
            // );
          },
        );
      },
    );
  }
}
