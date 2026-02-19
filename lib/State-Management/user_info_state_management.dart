import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoStateManagement extends ChangeNotifier {
  String userName = "";
  String userProfileImage = "";
  String userEmail = "";

void fetchUserInformation() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    print("User not logged in");
    return;
  }

  DocumentSnapshot documentSnapshot =
      await FirebaseFirestore.instance
          .collection("UserData")
          .doc(user.uid)
          .get();

  if (documentSnapshot.exists) {
    userName = documentSnapshot["userName"] ?? "";
    userProfileImage = documentSnapshot["profileImageUrl"] ?? "";
    userEmail = documentSnapshot["email"] ?? "";
    notifyListeners();
  }
}

  String name = "";

  void updateUserName(String newName) {
    name = newName;
    notifyListeners();
    // Optionally update Firestore here if it's connected
  }

  // Fetching User's Own Story
  String? finalStoryImageUrl;

Future fetchSelfStory() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    print("User not logged in");
    return;
  }

  DocumentSnapshot documentSnapshot =
      await FirebaseFirestore.instance
          .collection("stories")
          .doc(user.uid)
          .get();

  if (documentSnapshot.exists) {
    finalStoryImageUrl = documentSnapshot["imageUrl"] ?? "";
  } else {
    finalStoryImageUrl = "";
  }

  notifyListeners();
}
}
