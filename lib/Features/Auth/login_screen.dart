// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:kivaloop/Features/ShopPartnerFeatures/Profile/add_shop_details_screen.dart';
// import 'package:kivaloop/Services/Validators/login_form_validator.dart';
// import 'package:kivaloop/State-Management/AuthenticationState/select_usertype_state_management.dart';
// import 'package:kivaloop/bottom_navbar.dart';
// import 'package:provider/provider.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   List userType = ["Customer", "Shop Partner"];

//   Future userAuthentication(String email, String password) async {
//     try {
//       EasyLoading.show();
//       // First check if that user Email contains in UserData or not
//       QuerySnapshot querySnapshot =
//           await FirebaseFirestore.instance
//               .collection("UserData")
//               .where("email", isEqualTo: email)
//               .get();

//       if (querySnapshot.docs.isNotEmpty) {
//         print("User with this email exists.");
//         print(querySnapshot.docs.first["email"]);
//         await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//         EasyLoading.showSuccess("Successfully Logged in");
//       } else {
//         print("No user found with this email.");
//         UserCredential userCredential = await FirebaseAuth.instance
//             .createUserWithEmailAndPassword(email: email, password: password);
//         print(userCredential.user!.uid);

//         await FirebaseFirestore.instance
//             .collection("UserData")
//             .doc(userCredential.user!.uid)
//             .set({
//               "email": emailController.text.trim(),
//               "userType":
//                   userType[Provider.of<SelectUsertypeStateManagement>(
//                     context,
//                     listen: false,
//                   ).selectedUserIndex],
//               "favoriteCafeField": {
//                 "cafeName": "",
//                 "cafeImage": "",
//                 "cafeId": "",
//               },
//               "drinkOfTheDay": {"drinkName": "", "drinkImage": ""},
//               "rewardPoints": "",
//               "location": {"lat": "", "long": ""},
//               "password": passwordController.text.trim(),
//               "createdAt": DateTime.now().toIso8601String(),
//               "userId": userCredential.user!.uid,
//               "profileImageUrl": "",
//               "userName": "",
//             });

//         EasyLoading.showSuccess("Successfully Signed in");
//       }

//       if (Provider.of<SelectUsertypeStateManagement>(
//             context,
//             listen: false,
//           ).selectedUserIndex ==
//           0) {
//         Navigator.pushReplacement(
//           context,
//           CupertinoPageRoute(builder: (context) => BottomNavbarScreen()),
//         );
//       } else {
//         Navigator.pushReplacement(
//           context,
//           CupertinoPageRoute(builder: (context) => AddShopDetailsScreen()),
//         );
//       }
//     } catch (err) {
//       EasyLoading.showError(err.toString());
//     } finally {
//       EasyLoading.dismiss();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     height: 55,
//                     width: 165,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: AssetImage("assets/logo/logo_kivaloop.png"),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),

//                   Text(
//                     "Brew local, Sip mindful, Join the loop",
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.roboto(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 37),

//                   //Toggle switch or Segmented Button
//                   Container(
//                     height: 40,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: userType.length,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             Provider.of<SelectUsertypeStateManagement>(
//                               context,
//                               listen: false,
//                             ).chooseUserType(index);
//                           },
//                           child: Consumer<SelectUsertypeStateManagement>(
//                             builder: (context, state, child) {
//                               return Container(
//                                 width:
//                                     MediaQuery.of(context).size.width / 2 - 20,
//                                 decoration: BoxDecoration(
//                                   color:
//                                       state.selectedUserIndex == index
//                                           ? Colors.black
//                                           : Colors.transparent,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     userType[index],
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       color:
//                                           state.selectedUserIndex == index
//                                               ? Colors.white
//                                               : Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     ),
//                   ),

//                   const SizedBox(height: 24),

//                   Column(
//                     children: [
//                       // Email Field
//                       Form(
//                         key: formKey,
//                         child: Column(
//                           children: [
//                             TextFormField(
//                               validator: LoginFormValidator().emailValidator,
//                               controller: emailController,
//                               decoration: InputDecoration(
//                                 prefixIcon: Icon(Iconsax.sms),
//                                 hintText: "Write your email",
//                                 hintStyle: GoogleFonts.roboto(
//                                   color: Colors.black.withOpacity(0.5),
//                                   fontSize: 14,
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 20),

//                             // Password Field
//                             TextFormField(
//                               validator: LoginFormValidator().passwordValidator,
//                               controller: passwordController,
//                               decoration: InputDecoration(
//                                 prefixIcon: Icon(Iconsax.key),
//                                 hintText: "Write your password",
//                                 hintStyle: GoogleFonts.roboto(
//                                   color: Colors.black.withOpacity(0.5),
//                                   fontSize: 14,
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 10),

//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           "Forgot password?",
//                           style: GoogleFonts.roboto(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),

//                   GestureDetector(
//                     onTap: () async {
//                       if (formKey.currentState!.validate()) {
//                         // ✅ All fields are valid, proceed
//                         print(
//                           'Form is valid. Proceed with login or next step.',
//                         );
//                         await userAuthentication(
//                           emailController.text.trim(),
//                           passwordController.text.trim(),
//                         );
//                       } else {
//                         // ❌ Some fields are invalid
//                         print('Validation failed. Show errors.');
//                       }
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Center(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(vertical: 15),
//                           child: Text(
//                             "Sign With Email",
//                             style: GoogleFonts.roboto(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 39),

//                   Row(
//                     spacing: 6,
//                     children: [
//                       Expanded(child: Divider()),
//                       Text(
//                         "Or",
//                         style: GoogleFonts.roboto(
//                           color: Colors.black.withOpacity(0.5),
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       Expanded(child: Divider()),
//                     ],
//                   ),
//                   SizedBox(height: 35),

//                   Column(
//                     spacing: 15,
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(vertical: 15),
//                           child: Row(
//                             spacing: 10,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(FontAwesomeIcons.google, size: 12),
//                               Text(
//                                 "Continue with Google",
//                                 style: GoogleFonts.roboto(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(color: Color(0xff395185)),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(vertical: 15),
//                           child: Row(
//                             spacing: 10,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 FontAwesomeIcons.facebookF,
//                                 size: 12,
//                                 color: Colors.white,
//                               ),
//                               Text(
//                                 "Continue with Facebook",
//                                 style: GoogleFonts.roboto(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ------------------------ 22222222222222222222222222222222 --------------------------------------
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kivaloop/Features/Screens/shop-partner/shop_partner_dashboard.dart';
import 'package:kivaloop/Services/Validators/login_form_validator.dart';
import 'package:kivaloop/bottom_navbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isUser = true;
  bool _obscurePassword = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future userAuthentication(String email, String password) async {
    try {
      EasyLoading.show();
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance
              .collection("UserData")
              .where("email", isEqualTo: email)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        print("User with this email exists.");
        print(querySnapshot.docs.first["email"]);
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        EasyLoading.showSuccess("Successfully Logged in");
      } else {
        print("No user found with this email.");
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential.user!.uid);

        await FirebaseFirestore.instance
            .collection("UserData")
            .doc(userCredential.user!.uid)
            .set({
              "email": emailController.text.trim(),
              "password": passwordController.text.trim(),
              "createdAt": DateTime.now().toIso8601String(),
              "userId": userCredential.user!.uid,
              "isUser": true,
              "profileImageUrl": "",
              "userName": "",
            });

        EasyLoading.showSuccess("Successfully Signed in");
      }
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => BottomNavbarScreen()),
      );
    } catch (err) {
      EasyLoading.showError(err.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8F6F4), Color(0xFFEDE8E3), Colors.white],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 20),

                  // Logo with subtle shadow
                  Container(
                    height: 60,
                    width: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/logo/logo_kivaloop.png"),
                      ),
                    ),
                  ),

                  // Tagline with gradient text effect
                  ShaderMask(
                    shaderCallback:
                        (bounds) => LinearGradient(
                          colors: [Color(0xFF2D2D2D), Color(0xFF5C4033)],
                        ).createShader(bounds),
                    child: Text(
                      "Brew local, Sip mindful,\nJoin the loop",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),

                  // Subtitle
                  Text(
                    "Your sustainable coffee journey starts here",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Toggle switch with glass morphism effect
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white.withOpacity(0.8),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => isUser = true),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                gradient:
                                    isUser
                                        ? LinearGradient(
                                          colors: [
                                            Color(0xFF3D3D3D),
                                            Color(0xFF1A1A1A),
                                          ],
                                        )
                                        : null,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow:
                                    isUser
                                        ? [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.2,
                                            ),
                                            blurRadius: 8,
                                            offset: Offset(0, 2),
                                          ),
                                        ]
                                        : null,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.user,
                                    size: 18,
                                    color:
                                        isUser ? Colors.white : Colors.black54,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'User',
                                    style: GoogleFonts.roboto(
                                      color:
                                          isUser
                                              ? Colors.white
                                              : Colors.black54,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => isUser = false),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                gradient:
                                    !isUser
                                        ? LinearGradient(
                                          colors: [
                                            Color(0xFF3D3D3D),
                                            Color(0xFF1A1A1A),
                                          ],
                                        )
                                        : null,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow:
                                    !isUser
                                        ? [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.2,
                                            ),
                                            blurRadius: 8,
                                            offset: Offset(0, 2),
                                          ),
                                        ]
                                        : null,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.shop,
                                    size: 18,
                                    color:
                                        !isUser ? Colors.white : Colors.black54,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Shop Partner',
                                    style: GoogleFonts.roboto(
                                      color:
                                          !isUser
                                              ? Colors.white
                                              : Colors.black54,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Form Container with glass effect
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 30,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Email Label
                          Text(
                            "Email Address",
                            style: GoogleFonts.roboto(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 10),

                          // Email Field
                          TextFormField(
                            validator: LoginFormValidator().emailValidator,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Container(
                                padding: EdgeInsets.all(12),
                                child: Icon(
                                  Iconsax.sms,
                                  color: Color(0xFF5C4033),
                                  size: 22,
                                ),
                              ),
                              hintText: "Enter your email",
                              hintStyle: GoogleFonts.roboto(
                                color: Colors.black38,
                                fontSize: 14,
                              ),
                              filled: true,
                              fillColor: Color(0xFFF8F6F4),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF5C4033),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Password Label
                          Text(
                            "Password",
                            style: GoogleFonts.roboto(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 10),

                          // Password Field
                          TextFormField(
                            validator: LoginFormValidator().passwordValidator,
                            controller: passwordController,
                            obscureText: _obscurePassword,
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Container(
                                padding: EdgeInsets.all(12),
                                child: Icon(
                                  Iconsax.lock,
                                  color: Color(0xFF5C4033),
                                  size: 22,
                                ),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  child: Icon(
                                    _obscurePassword
                                        ? Iconsax.eye_slash
                                        : Iconsax.eye,
                                    color: Colors.black45,
                                    size: 20,
                                  ),
                                ),
                              ),
                              hintText: "Enter your password",
                              hintStyle: GoogleFonts.roboto(
                                color: Colors.black38,
                                fontSize: 14,
                              ),
                              filled: true,
                              fillColor: Color(0xFFF8F6F4),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF5C4033),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),

                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                // Handle forgot password
                              },
                              child: Text(
                                "Forgot password?",
                                style: GoogleFonts.roboto(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF5C4033),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),

                          // Sign In Button
                          GestureDetector(
                            onTap: () async {
                              if (isUser) {
                                if (formKey.currentState!.validate()) {
                                  print(
                                    'Form is valid. Proceed with login or next step.',
                                  );
                                  await userAuthentication(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                                } else {
                                  print('Validation failed. Show errors.');
                                }
                              } else {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder:
                                        (context) => ShopPartnerDashboard(),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF3D3D3D),
                                    Color(0xFF1A1A1A),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.login,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Sign In",
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
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
                  SizedBox(height: 20),

                  // Divider
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black26],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Text(
                            "or continue with",
                            style: GoogleFonts.roboto(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black26, Colors.transparent],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Social Login Buttons
                  Row(
                    children: [
                      // Google Button
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Handle Google sign in
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 15,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  'https://www.google.com/favicon.ico',
                                  height: 20,
                                  width: 20,
                                  errorBuilder:
                                      (context, error, stackTrace) => Icon(
                                        FontAwesomeIcons.google,
                                        size: 18,
                                        color: Colors.red,
                                      ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Google",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),

                      // Facebook Button
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Handle Facebook sign in
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF4267B2), Color(0xFF395185)],
                              ),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF395185).withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.facebookF,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Facebook",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to sign up
                        },
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF5C4033),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
