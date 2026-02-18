import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kivaloop/Features/Screens/shop-partner/shop_partner_dashboard.dart';
import 'package:kivaloop/Features/ShopPartnerFeatures/Profile/add_shop_details_screen.dart';
import 'package:kivaloop/Features/ShopPartnerFeatures/shop_partner_bottom_navbar_screen.dart';
import 'package:kivaloop/Services/Validators/login_form_validator.dart';
import 'package:kivaloop/State-Management/AuthenticationState/select_usertype_state_management.dart';
import 'package:kivaloop/bottom_navbar.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List userType = ["Customer", "Shop Partner"];

  Future userAuthentication(String email, String password) async {
    try {
      EasyLoading.show();
      // First check if that user Email contains in UserData or not
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
              "userType":
                  userType[Provider.of<SelectUsertypeStateManagement>(
                    context,
                    listen: false,
                  ).selectedUserIndex],
              "favoriteCafeField": {
                "cafeName": "",
                "cafeImage": "",
                "cafeId": "",
              },
              "drinkOfTheDay": {"drinkName": "", "drinkImage": ""},
              "rewardPoints": "",
              "location": {"lat": "", "long": ""},
              "password": passwordController.text.trim(),
              "createdAt": DateTime.now().toIso8601String(),
              "userId": userCredential.user!.uid,
              "profileImageUrl": "",
              "userName": "",
            });

        EasyLoading.showSuccess("Successfully Signed in");
      }

      if (Provider.of<SelectUsertypeStateManagement>(
            context,
            listen: false,
          ).selectedUserIndex ==
          0) {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => BottomNavbarScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => AddShopDetailsScreen()),
        );
      }
    } catch (err) {
      EasyLoading.showError(err.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 55,
                    width: 165,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/logo/logo_kivaloop.png"),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Text(
                    "Brew local, Sip mindful, Join the loop",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 37),

                  //Toggle switch or Segmented Button
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: userType.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Provider.of<SelectUsertypeStateManagement>(
                              context,
                              listen: false,
                            ).chooseUserType(index);
                          },
                          child: Consumer<SelectUsertypeStateManagement>(
                            builder: (context, state, child) {
                              return Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                decoration: BoxDecoration(
                                  color:
                                      state.selectedUserIndex == index
                                          ? Colors.black
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    userType[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          state.selectedUserIndex == index
                                              ? Colors.white
                                              : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  Column(
                    children: [
                      // Email Field
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: LoginFormValidator().emailValidator,
                              controller: emailController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.sms),
                                hintText: "Write your email",
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
                            SizedBox(height: 20),

                            // Password Field
                            TextFormField(
                              validator: LoginFormValidator().passwordValidator,
                              controller: passwordController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.key),
                                hintText: "Write your password",
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
                      ),
                      SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot password?",
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        // ✅ All fields are valid, proceed
                        print(
                          'Form is valid. Proceed with login or next step.',
                        );
                        await userAuthentication(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                      } else {
                        // ❌ Some fields are invalid
                        print('Validation failed. Show errors.');
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "Sign With Email",
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
                  SizedBox(height: 39),

                  Row(
                    spacing: 6,
                    children: [
                      Expanded(child: Divider()),
                      Text(
                        "Or",
                        style: GoogleFonts.roboto(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: 35),

                  Column(
                    spacing: 15,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons.google, size: 12),
                              Text(
                                "Continue with Google",
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(color: Color(0xff395185)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.facebookF,
                                size: 12,
                                color: Colors.white,
                              ),
                              Text(
                                "Continue with Facebook",
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
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
      ),
    );
  }
}
