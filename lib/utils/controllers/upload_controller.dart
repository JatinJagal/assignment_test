import 'package:assignment_test/res/consts/consts.dart';
import 'package:assignment_test/screen_view/homepages/bottom_nav.dart';
import 'package:assignment_test/view_model/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_compress/video_compress.dart';

import '../routes/routes_name.dart';

class UploadController extends GetxController{

  compressVideoFile(String videoFilePath) async{

    final compressVideoFile = await VideoCompress.compressVideo(videoFilePath, quality: VideoQuality.LowQuality);

    return compressVideoFile!.file;

  }

  uploadCompressVideoFileToFirebaseStorage(String videoId,String videoFilePath) async{
    UploadTask videoUploadTask = FirebaseStorage.instance.ref()
        .child("All Videos")
        .child(videoId)
        .putFile(await compressVideoFile(videoFilePath));

    TaskSnapshot snapshot = await videoUploadTask;

    String downloadUrlOfUploadedVideo = await snapshot.ref.getDownloadURL();

    return downloadUrlOfUploadedVideo;
  }

  getThumbnailImage(String videoFilePath) async{

    final thumbnailImage = await VideoCompress.getFileThumbnail(videoFilePath);

    return thumbnailImage;

  }

  uploadThumbnailImageFirebaseStorage(String videoId,String videoFilePath) async{
    UploadTask thumbnailUploadTask = FirebaseStorage.instance.ref()
        .child("All Thumbnail")
        .child(videoId)
        .putFile(await getThumbnailImage(videoFilePath));

    TaskSnapshot snapshot = await thumbnailUploadTask;

    String downloadUrlOfUploadedThumbnail = await snapshot.ref.getDownloadURL();

    return downloadUrlOfUploadedThumbnail;
  }

  //upload location
  // uploadLocationToFirebaseStorage(String location) async{
  //
  // }

  saveVideoInformationToFirebaseDatabase(
      String titleName,String description,String location,String videoFilePath,BuildContext context) async{
    try{

      DocumentSnapshot userDocumentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      String videoId = DateTime.now().microsecondsSinceEpoch.toString();

      //1. uploaded video to storage
      String videoDownloadUrl = await uploadCompressVideoFileToFirebaseStorage(videoId, videoFilePath);

      //2.upload thumbnail to storage
      String thumbnailDownloadUrl = await uploadThumbnailImageFirebaseStorage(videoId, videoFilePath);

      //3. save overall video information
      Video videoObject = Video(
        userID: FirebaseAuth.instance.currentUser!.uid,
        userName: (userDocumentSnapshot.data() as Map<String, dynamic>)["name"],
        userProfileImage: (userDocumentSnapshot.data() as Map<String, dynamic>)["image"],
        videoID: videoId,
        totalComments: 0,
        description: description,
        titleName: titleName,
        location: location,
        videoUrl: videoDownloadUrl,
        thumbnailUrl: thumbnailDownloadUrl,
        publishedDateTime: DateTime.now().microsecondsSinceEpoch,
      );

      await FirebaseFirestore.instance.collection("videos").doc(videoId).set(videoObject.toJson());

      Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false);

      Get.snackbar("New Video", "Video Uploaded successfully");

    }catch(e){
      print(e.toString());
      Get.snackbar("Upload video Unsuccessfully", "Your Video not uploaded");
    }
  }

}