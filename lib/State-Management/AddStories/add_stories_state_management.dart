import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class AddStoriesStateManagement extends ChangeNotifier {
  File? storyImageFile;
  String cloudName = "dypsfkqhj";
  String presetName = "kivaloop_story";
  String? storyImageUrl;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  Future selectAndUploadStoryImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);
      storyImageFile = imageFile;
      notifyListeners();

      final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/$cloudName/upload",
      );
      final request =
          http.MultipartRequest('POST', url)
            ..fields['upload_preset'] = presetName
            ..files.add(
              await http.MultipartFile.fromPath('file', storyImageFile!.path),
            );

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = utf8.decode(responseData);
        final jsonMap = jsonDecode(responseString);
        storyImageUrl = jsonMap['url'];
        print(storyImageUrl);
        FirebaseFirestore.instance.collection("stories").doc(uid).set({
          "createdAt": Timestamp.now(),
          "expiresAt": Timestamp.now().toDate().add(Duration(hours: 24)),
          "imageUrl": storyImageUrl,
          "userId": uid,
        });
      }
    }
  }
}
