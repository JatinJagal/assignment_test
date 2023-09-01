import 'package:cloud_firestore/cloud_firestore.dart';

class Video{
  String? userID;
  String? userName;
  String? userProfileImage;
  String? videoID;
  int? totalComments;
  String? titleName;
  String? description;
  String? location;
  String? videoUrl;
  String? thumbnailUrl;
  int? publishedDateTime;

  Video({
    this.userID,
    this.userName,
    this.userProfileImage,
    this.videoID,
    this.totalComments,
    this.titleName,
    this.description,
    this.location,
    this.videoUrl,
    this.thumbnailUrl,
    this.publishedDateTime,
  });

  Map<String, dynamic> toJson() => {
    "userID": userID,
    "userName": userName,
    "userProfileImage": userProfileImage,
    "videoID": videoID,
    "totalComments": totalComments,
    "titleName": titleName,
    "description": description,
    "location": location,
    "videoUrl": videoUrl,
    "thumbnailUrl": thumbnailUrl,
    "publishedDateTime": publishedDateTime,
  };

  static Video fromDocumentSnapshot(DocumentSnapshot snapshot){

    var docSnapshot = snapshot.data() as Map<String,dynamic>;

    return Video(
      userID: docSnapshot["userId"],
      userName: docSnapshot["userName"],
      userProfileImage: docSnapshot["userProfileImage"],
      videoID: docSnapshot["videoID"],
      totalComments: docSnapshot["totalComments"],
      titleName: docSnapshot["titleName"],
      description: docSnapshot["description"],
      location: docSnapshot["location"],
      videoUrl: docSnapshot["videoUrl"],
      thumbnailUrl: docSnapshot["thumbnailUrl"],
      publishedDateTime: docSnapshot["publishedDateTime"],
    );
  }
}