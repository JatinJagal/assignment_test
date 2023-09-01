import 'dart:async';

import 'package:assignment_test/res/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/routes/routes_name.dart';

class SplashService{

  void isLogin(BuildContext context){

    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

      if(user != null){
        Timer(Duration(seconds: 3), () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false));
      }else{
        Timer(Duration(seconds: 3), () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false));
      }

    }
}