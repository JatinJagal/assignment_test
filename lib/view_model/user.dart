import 'package:cloud_firestore/cloud_firestore.dart';

class User{

  String? name;
  String? uid;
  String? image;

  User({
    this.name,
    this.uid,
    this.image
  });

  Map<String, dynamic> toJson()=>{
    "name": name,
    "uid": uid,
    "image": image,
  };

  static User fromSnap(DocumentSnapshot snapshot){
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;

    return User(
      name: dataSnapshot["name"],
      uid: dataSnapshot["uid"],
      image: dataSnapshot["image"]
    );
  }

}