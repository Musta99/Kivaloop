// import 'dart:convert';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:kivaloop/Features/Auth/login_screen.dart';
// import 'package:kivaloop/State-Management/user_info_state_management.dart';
// import 'package:provider/provider.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   File? profileImageFile;
//   String? profileImageUrl;
//   bool _isEditing = false;
//   TextEditingController _controller = TextEditingController();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Provider.of<UserInfoStateManagement>(
//       context,
//       listen: false,
//     ).fetchUserInformation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: Icon(Iconsax.setting),
//         actions: [
//           Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 20),
//                 child: Icon(Iconsax.notification),
//               ),
//               GestureDetector(
//                 onTap: () async {
//                   await FirebaseAuth.instance.signOut();
//                   EasyLoading.showSuccess("Successfully Logged out");
//                   Navigator.popUntil(context, (route) => route.isFirst);
//                   Navigator.pushReplacement(
//                     context,
//                     CupertinoPageRoute(builder: (context) => LoginScreen()),
//                   );
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 20),
//                   child: Icon(Iconsax.logout),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),

//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 child: Column(
//                   spacing: 15,
//                   children: [
//                     Container(
//                       height: 140,
//                       width: 120,
//                       child: Stack(
//                         children: [
//                           Container(
//                             height: 120,
//                             width: 120,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(60),
//                               border: Border.all(
//                                 color: Color(0xff745340),
//                                 width: 3,
//                               ),
//                               image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: NetworkImage(
//                                   Provider.of<UserInfoStateManagement>(
//                                             context,
//                                           ).userProfileImage !=
//                                           null
//                                       ? Provider.of<UserInfoStateManagement>(
//                                         context,
//                                       ).userProfileImage
//                                       : "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             right: 10,
//                             child: GestureDetector(
//                               onTap: () async {
//                                 String cloudName = "dypsfkqhj";
//                                 String presetName = "kivaloop_user";
//                                 final ImagePicker picker = ImagePicker();

//                                 // Pick an image.
//                                 final XFile? image = await picker.pickImage(
//                                   source: ImageSource.gallery,
//                                 );

//                                 if (image != null) {
//                                   File imageFile = File(image.path);

//                                   setState(() {
//                                     profileImageFile = imageFile;
//                                   });

//                                   final url = Uri.parse(
//                                     "https://api.cloudinary.com/v1_1/$cloudName/upload",
//                                   );
//                                   final request =
//                                       http.MultipartRequest('POST', url)
//                                         ..fields['upload_preset'] = presetName
//                                         ..files.add(
//                                           await http.MultipartFile.fromPath(
//                                             'file',
//                                             profileImageFile!.path,
//                                           ),
//                                         );

//                                   final response = await request.send();

//                                   if (response.statusCode == 200) {
//                                     final responseData =
//                                         await response.stream.toBytes();
//                                     final responseString = utf8.decode(
//                                       responseData,
//                                     );
//                                     final jsonMap = jsonDecode(responseString);

//                                     setState(() {
//                                       profileImageUrl = jsonMap['url'];
//                                       print(profileImageUrl);
//                                     });

//                                     await FirebaseFirestore.instance
//                                         .collection("UserData")
//                                         .doc(
//                                           FirebaseAuth
//                                               .instance
//                                               .currentUser!
//                                               .uid,
//                                         )
//                                         .update({
//                                           "profileImageUrl": profileImageUrl,
//                                         });
//                                   }
//                                 }
//                               },
//                               child: Container(
//                                 height: 30,
//                                 width: 30,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(30),
//                                   border: Border.all(
//                                     color: Color(0xff745340),
//                                     width: 3,
//                                   ),
//                                 ),
//                                 child: Icon(Iconsax.edit_2, size: 16),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         _isEditing
//                             ? SizedBox(
//                               width: 200,
//                               child: TextField(
//                                 controller: _controller,
//                                 autofocus: true,
//                                 onSubmitted: (value) async {
//                                   if (value.trim().isNotEmpty) {
//                                     Provider.of<UserInfoStateManagement>(
//                                       context,
//                                       listen: false,
//                                     ).updateUserName(value.trim());

//                                     await FirebaseFirestore.instance
//                                         .collection("UserData")
//                                         .doc(
//                                           FirebaseAuth
//                                               .instance
//                                               .currentUser!
//                                               .uid,
//                                         )
//                                         .update({"userName": value.trim()});
//                                   }
//                                   setState(() {
//                                     _isEditing = false;
//                                   });
//                                 },
//                                 decoration: InputDecoration(
//                                   hintText: "Enter your name",
//                                   hintStyle: GoogleFonts.roboto(fontSize: 12),
//                                   border: OutlineInputBorder(),
//                                 ),
//                                 style: GoogleFonts.roboto(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             )
//                             : GestureDetector(
//                               onTap: () {
//                                 _controller.text =
//                                     Provider.of<UserInfoStateManagement>(
//                                       context,
//                                       listen: false,
//                                     ).userName;
//                                 setState(() {
//                                   _isEditing = true;
//                                 });
//                               },
//                               child: Row(
//                                 spacing: 6,
//                                 children: [
//                                   Text(
//                                     Provider.of<UserInfoStateManagement>(
//                                               context,
//                                             ).userName !=
//                                             ""
//                                         ? Provider.of<UserInfoStateManagement>(
//                                           context,
//                                         ).userName
//                                         : "Please set your User Name",
//                                     style: GoogleFonts.roboto(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       if (_isEditing &&
//                                           _controller.text.trim().isNotEmpty) {
//                                         Provider.of<UserInfoStateManagement>(
//                                           context,
//                                           listen: false,
//                                         ).updateUserName(
//                                           _controller.text.trim(),
//                                         );
//                                       }
//                                       setState(() {
//                                         _isEditing = !_isEditing;
//                                       });
//                                     },
//                                     child: Icon(Iconsax.edit_2, size: 14),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                       ],
//                     ),

//                     Text(
//                       Provider.of<UserInfoStateManagement>(context).userEmail,
//                       style: GoogleFonts.roboto(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   spacing: 14,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Posts",
//                       style: GoogleFonts.roboto(
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),

//                     GridView.builder(
//                       padding: EdgeInsets.zero,
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         mainAxisExtent: 100,
//                         mainAxisSpacing: 10,
//                         crossAxisSpacing: 10,
//                       ),
//                       itemCount: 15,
//                       itemBuilder: (context, index) {
//                         return Container(color: Colors.grey.shade400);
//                       },
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ---------------------------------- 22222222222222222222222222222222222 -------------------------------------
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
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

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  File? profileImageFile;
  String? profileImageUrl;
  bool _isEditing = false;
  TextEditingController _controller = TextEditingController();
  late TabController _tabController;

  // Location related
  bool _locationPermissionGranted = false;
  bool _locationServiceEnabled = false;
  String? _currentLocation;
  bool _isCheckingLocation = true;

  // Stats
  final Map<String, dynamic> userStats = {
    "posts": 24,
    "followers": "1.2k",
    "following": 458,
    "coffeePoints": 850,
  };

  // Achievements
  final List<Map<String, dynamic>> achievements = [
    {
      "icon": Iconsax.medal_star,
      "label": "Coffee Expert",
      "color": Color(0xFFFFD700),
    },
    {"icon": Iconsax.cup, "label": "100 Brews", "color": Color(0xFF5C4033)},
    {"icon": Iconsax.heart, "label": "Loved", "color": Color(0xFFE91E63)},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Provider.of<UserInfoStateManagement>(
      context,
      listen: false,
    ).fetchUserInformation();
    _checkLocationPermission();
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

Future<void> _checkLocationPermission() async {
  if (!mounted) return;
  setState(() => _isCheckingLocation = true);

  try {
    // Check if location services are enabled
    _locationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!mounted) return;

    if (!_locationServiceEnabled) {
      setState(() {
        _locationPermissionGranted = false;
        _isCheckingLocation = false;
      });
      return;
    }

    // Check permission status
    LocationPermission permission = await Geolocator.checkPermission();

    if (!mounted) return;

    if (permission == LocationPermission.denied) {
      setState(() {
        _locationPermissionGranted = false;
        _isCheckingLocation = false;
      });
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationPermissionGranted = false;
        _isCheckingLocation = false;
      });
      return;
    }

    // Permission granted, get location
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      if (!mounted) return;
      setState(() {
        _locationPermissionGranted = true;
      });
      await _getCurrentLocation();
    }
  } catch (e) {
    print("Error checking location: $e");
  } finally {
    if (mounted) {
      setState(() => _isCheckingLocation = false);
    }
  }
}

Future<void> _requestLocationPermission() async {
  try {
    // First check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!mounted) return;

    if (!serviceEnabled) {
      _showLocationServiceDialog();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (!mounted) return;

    if (permission == LocationPermission.deniedForever) {
      _showOpenSettingsDialog();
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (!mounted) return;

      if (permission == LocationPermission.denied) {
        EasyLoading.showError("Location permission denied");
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        _showOpenSettingsDialog();
        return;
      }
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      if (!mounted) return;
      setState(() => _locationPermissionGranted = true);
      await _getCurrentLocation();
      EasyLoading.showSuccess("Location enabled!");
    }
  } catch (e) {
    EasyLoading.showError("Error: $e");
  }
}

Future<void> _getCurrentLocation() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (!mounted) return;

    // Here you could use reverse geocoding to get the address
    setState(() {
      _currentLocation = "Amsterdam, Netherlands"; // Placeholder
    });
  } catch (e) {
    print("Error getting location: $e");
  }
}

Future<void> _pickAndUploadImage() async {
  String cloudName = "dypsfkqhj";
  String presetName = "kivaloop_user";

  try {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      EasyLoading.show(status: "Uploading...");
      File imageFile = File(image.path);

      if (!mounted) return;

      setState(() {
        profileImageFile = imageFile;
      });

      final url = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/upload");
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = presetName
        ..files.add(await http.MultipartFile.fromPath('file', profileImageFile!.path));

      final response = await request.send();

      if (!mounted) return;

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = utf8.decode(responseData);
        final jsonMap = jsonDecode(responseString);

        if (!mounted) return;

        setState(() {
          profileImageUrl = jsonMap['url'];
        });

        await FirebaseFirestore.instance
            .collection("UserData")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({"profileImageUrl": profileImageUrl});

        if (!mounted) return;

        Provider.of<UserInfoStateManagement>(context, listen: false)
            .fetchUserInformation();

        EasyLoading.showSuccess("Profile updated!");
      } else {
        EasyLoading.showError("Upload failed");
      }
    }
  } catch (e) {
    EasyLoading.showError("Error: $e");
  }
}

Future<void> _saveName() async {
  if (_controller.text.trim().isNotEmpty) {
    try {
      await FirebaseFirestore.instance
          .collection("UserData")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"userName": _controller.text.trim()});

      if (!mounted) return;

      Provider.of<UserInfoStateManagement>(context, listen: false)
          .updateUserName(_controller.text.trim());

      EasyLoading.showSuccess("Name updated!");
    } catch (e) {
      EasyLoading.showError("Error: $e");
    }
  }

  if (!mounted) return;
  setState(() => _isEditing = false);
}

  void _showLocationServiceDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFFF9800).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Iconsax.location_slash, color: Color(0xFFFF9800)),
                ),
                SizedBox(width: 12),
                Text(
                  "Location Services",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            content: Text(
              "Location services are disabled. Please enable them in your device settings to discover nearby cafés.",
              style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[600]),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: GoogleFonts.roboto(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await Geolocator.openLocationSettings();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5C4033),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Open Settings",
                  style: GoogleFonts.roboto(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  void _showOpenSettingsDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFE91E63).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Iconsax.shield_slash, color: Color(0xFFE91E63)),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Permission Required",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            content: Text(
              "Location permission is permanently denied. Please enable it in app settings to discover amazing cafés near you.",
              style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[600]),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Not Now",
                  style: GoogleFonts.roboto(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await Geolocator.openAppSettings();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5C4033),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Open Settings",
                  style: GoogleFonts.roboto(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  void _showLogoutConfirmation() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: 24.h),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Iconsax.logout, size: 40, color: Colors.red),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Logout?",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Are you sure you want to logout?\nYou'll need to login again to access your account.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.roboto(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);
                          await FirebaseAuth.instance.signOut();
                          EasyLoading.showSuccess("Successfully Logged out");
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.red[400]!, Colors.red[600]!],
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.3),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Logout",
                              style: GoogleFonts.roboto(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF8F5),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          // Custom App Bar with Profile Header
          SliverAppBar(
            expandedHeight: 320.h,
            floating: false,
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
                    colors: [
                      Color(0xFF8B6914),
                      Color(0xFF5C4033),
                      Color(0xFF3D2817),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Stack(
                    children: [
                      // Decorative Elements
                      Positioned(
                        right: -50,
                        top: -50,
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -30,
                        bottom: 50,
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.03),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        bottom: 80,
                        child: Icon(
                          Iconsax.coffee5,
                          size: 60,
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),

                      // Content
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            SizedBox(height: 10.h),

                            // Top Bar
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Open settings
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Iconsax.setting_2,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Profile",
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Icon(
                                              Iconsax.notification,
                                              color: Colors.white,
                                              size: 22,
                                            ),
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: Container(
                                                height: 8,
                                                width: 8,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    GestureDetector(
                                      onTap: _showLogoutConfirmation,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Icon(
                                          Iconsax.logout,
                                          color: Colors.white,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: 24.h),

                            // Profile Picture
                            Consumer<UserInfoStateManagement>(
                              builder: (context, userInfo, child) {
                                return Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFFFD700),
                                            Color(0xFFFF9800),
                                            Color(0xFFFFD700),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.3,
                                            ),
                                            blurRadius: 20,
                                            offset: Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        height: 110.h,
                                        width: 110.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 3,
                                          ),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              userInfo
                                                      .userProfileImage
                                                      .isNotEmpty
                                                  ? userInfo.userProfileImage
                                                  : "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () => _pickAndUploadImage(),
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFFFD700),
                                                Color(0xFFFF9800),
                                              ],
                                            ),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 3,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.orange
                                                    .withOpacity(0.4),
                                                blurRadius: 8,
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Iconsax.camera,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),

                            SizedBox(height: 16.h),

                            // Name
                            Consumer<UserInfoStateManagement>(
                              builder: (context, userInfo, child) {
                                return _isEditing
                                    ? Container(
                                      width: 220.w,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: TextField(
                                        controller: _controller,
                                        autofocus: true,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Enter your name",
                                          hintStyle: GoogleFonts.roboto(
                                            color: Colors.white.withOpacity(
                                              0.5,
                                            ),
                                          ),
                                          border: InputBorder.none,
                                          suffixIcon: GestureDetector(
                                            onTap: () => _saveName(),
                                            child: Icon(
                                              Iconsax.tick_circle,
                                              color: Color(0xFFFFD700),
                                            ),
                                          ),
                                        ),
                                        onSubmitted: (_) => _saveName(),
                                      ),
                                    )
                                    : GestureDetector(
                                      onTap: () {
                                        _controller.text = userInfo.userName;
                                        setState(() => _isEditing = true);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            userInfo.userName.isNotEmpty
                                                ? userInfo.userName
                                                : "Set Your Name",
                                            style: GoogleFonts.playfairDisplay(
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(
                                                0.2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Icon(
                                              Iconsax.edit_2,
                                              size: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                              },
                            ),

                            SizedBox(height: 6.h),

                            // Email
                            Consumer<UserInfoStateManagement>(
                              builder: (context, userInfo, child) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Iconsax.sms,
                                      size: 14,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      userInfo.userEmail,
                                      style: GoogleFonts.roboto(
                                        fontSize: 13.sp,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),

                            SizedBox(height: 6.h),

                            // Location
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _locationPermissionGranted
                                      ? Iconsax.location5
                                      : Iconsax.location_slash,
                                  size: 14,
                                  color:
                                      _locationPermissionGranted
                                          ? Color(0xFFFFD700)
                                          : Colors.white.withOpacity(0.5),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  _locationPermissionGranted
                                      ? (_currentLocation ??
                                          "Fetching location...")
                                      : "Location disabled",
                                  style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    color: Colors.white.withOpacity(0.7),
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
            ),
          ),

          // Location Permission Banner (if not granted)
          if (!_locationPermissionGranted && !_isCheckingLocation)
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(20.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFF9800).withOpacity(0.1),
                      Color(0xFFFF5722).withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFFFF9800).withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFFF9800).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Iconsax.location_slash,
                        color: Color(0xFFFF9800),
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enable Location",
                            style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2D2D2D),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "Discover amazing cafés near you",
                            style: GoogleFonts.roboto(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _requestLocationPermission,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFFF9800), Color(0xFFFF5722)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFFF9800).withOpacity(0.3),
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          "Enable",
                          style: GoogleFonts.roboto(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Stats Section
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                    userStats["posts"].toString(),
                    "Posts",
                    Iconsax.image,
                  ),
                  _buildStatDivider(),
                  _buildStatItem(
                    userStats["followers"].toString(),
                    "Followers",
                    Iconsax.people,
                  ),
                  _buildStatDivider(),
                  _buildStatItem(
                    userStats["following"].toString(),
                    "Following",
                    Iconsax.user_add,
                  ),
                  _buildStatDivider(),
                  _buildStatItem(
                    userStats["coffeePoints"].toString(),
                    "Points",
                    Iconsax.coffee,
                  ),
                ],
              ),
            ),
          ),

          // Achievements Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
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
                              color: Color(0xFFFFD700).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Iconsax.award,
                              size: 18,
                              color: Color(0xFFFFD700),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            "Achievements",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D2D2D),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "View All",
                        style: GoogleFonts.roboto(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5C4033),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children:
                        achievements.map((achievement) {
                          return Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                right:
                                    achievement != achievements.last ? 12.w : 0,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 10,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: achievement["color"].withOpacity(
                                        0.1,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      achievement["icon"],
                                      color: achievement["color"],
                                      size: 24,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    achievement["label"],
                                    style: GoogleFonts.roboto(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF2D2D2D),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ),
            ),
          ),

          // Tab Bar Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF8B6914), Color(0xFF5C4033)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF5C4033).withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey[600],
                  labelStyle: GoogleFonts.roboto(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.grid_2, size: 18),
                          SizedBox(width: 6.w),
                          Text("Posts"),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.bookmark, size: 18),
                          SizedBox(width: 6.w),
                          Text("Saved"),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.heart, size: 18),
                          SizedBox(width: 6.w),
                          Text("Liked"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Posts Grid
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance
                        .collection('posts')
                        .where(
                          'userId',
                          isEqualTo: FirebaseAuth.instance.currentUser?.uid,
                        )
                        .orderBy('createdAt', descending: true)
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF5C4033),
                        strokeWidth: 2,
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return _buildEmptyPostsState();
                  }

                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8.w,
                      crossAxisSpacing: 8.w,
                      childAspectRatio: 1,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final post =
                          snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () {
                          // Open post detail
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  post['imageUrl'] ?? '',
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, __, ___) => Container(
                                        color: Colors.grey[200],
                                        child: Icon(
                                          Iconsax.image,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                ),
                              ),
                              // Hover Effect
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.3),
                                    ],
                                  ),
                                ),
                              ),
                              // Likes Count
                              Positioned(
                                bottom: 8,
                                left: 8,
                                child: Row(
                                  children: [
                                    Icon(
                                      Iconsax.heart5,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${(post['likes'] as List?)?.length ?? 0}",
                                      style: GoogleFonts.roboto(
                                        fontSize: 11.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
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
                  );
                },
              ),
            ),
          ),

          // Bottom Padding
          SliverToBoxAdapter(child: SizedBox(height: 100.h)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF5C4033).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: Color(0xFF5C4033)),
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D2D2D),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: GoogleFonts.roboto(fontSize: 11.sp, color: Colors.grey[500]),
        ),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(height: 40.h, width: 1, color: Colors.grey[200]);
  }

  Widget _buildEmptyPostsState() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 60.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Color(0xFF5C4033).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.camera, size: 48, color: Color(0xFF5C4033)),
          ),
          SizedBox(height: 20.h),
          Text(
            "No Posts Yet",
            style: GoogleFonts.playfairDisplay(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D2D2D),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Share your first coffee moment!",
            style: GoogleFonts.roboto(fontSize: 14.sp, color: Colors.grey[500]),
          ),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: () {
              // Navigate to add post
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Iconsax.add, size: 18, color: Colors.white),
                  SizedBox(width: 8.w),
                  Text(
                    "Create Post",
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
    );
  }




}
