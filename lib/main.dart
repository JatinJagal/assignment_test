import 'package:assignment_test/res/consts/consts.dart';
import 'package:assignment_test/utils/routes/routes.dart';
import 'package:assignment_test/utils/routes/routes_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (context,child){
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            // home: AddPostScreen(),
            initialRoute: RoutesName.splash,
            onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}