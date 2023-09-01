import 'package:assignment_test/res/consts/consts.dart';
import 'package:assignment_test/utils/controllers/authentication_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedController extends GetxController{

  final auth = FirebaseAuth.instance.currentUser;
  final getDataController = Get.put(AuthenticationController());
  //
  getUserData(){
    final uid = auth?.uid;
    if(uid != null){
      // getDataController.getUserDetails(uid)*
    }else{
      Get.snackbar("Error", "Login to continue");
    }
  }

}