import 'dart:io';

import 'package:assignment_test/res/consts/consts.dart';
import 'package:assignment_test/view_model/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:assignment_test/view_model/user.dart' as userModel;
import 'package:image_picker/image_picker.dart';

import '../routes/routes_name.dart';

class AuthenticationController extends GetxController{

  late Rx<File?> _pickedFile;
  var isLoading = false.obs;

  // File? get profileImage => _pickedFile.value;
  File? get profileImage => _pickedFile.value;

  //for the fetch data of user
  final _db = FirebaseFirestore.instance;

  void chooseImageFromGallery() async{

    final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(pickedImageFile != null){
      Get.snackbar(
          "Profile Image",
          "You have successfully"
      );
    }

    _pickedFile = Rx<File?>(File(pickedImageFile!.path));

  }

  void captureImageWithCamera()async{

    final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if(pickedImageFile != null){
      Get.snackbar(
          "Profile Image",
          "You have successfully"
      );
    }

    _pickedFile = Rx<File?>(File(pickedImageFile!.path));

  }

  void saveUserDataToStorage(File imageFile, String userName,BuildContext context) async{

    try{
      isLoading(true);
      //get user instance
      final userCredential = FirebaseAuth.instance.currentUser;

      //save the user profile images
      String imageDownloadUrl = await uploadImageToStorage(imageFile);

      //save user data to firestore

      userModel.User user = userModel.User(
        name: userName,
        image: imageDownloadUrl,
        uid: userCredential!.uid,
      );

      await FirebaseFirestore.instance.collection("users")
          .doc(userCredential.uid)
          .set(user.toJson());

      Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false);
      isLoading(false);
    }catch(e){
      Get.snackbar("Error", "Failed to save the data");
    }

  }

  Future<String> uploadImageToStorage(File imageFile) async{
    Reference reference = FirebaseStorage.instance.ref()
        .child("Profile Images")
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrlOfUploadImage = await taskSnapshot.ref.getDownloadURL();

    return downloadUrlOfUploadImage;
  }


  // Fetch all users details
  // final videoInfo = FirebaseFirestore.instance.collection('videos').snapshots();
  //
  // Future getUserList() async{
  //   try{
  //     await videoInfo.get()
  //   }catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }

}