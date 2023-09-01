import 'package:assignment_test/screen_view/homepages/bottom_nav.dart';
import 'package:assignment_test/screen_view/homepages/user_details.dart';
import 'package:assignment_test/screen_view/otp_screen.dart';
import 'package:assignment_test/screen_view/splash_screen.dart';
import 'package:assignment_test/utils/routes/routes_name.dart';

import '../../res/consts/consts.dart';
import '../../screen_view/login_with_phone.dart';

class Routes{

  static MaterialPageRoute generateRoute(RouteSettings settings){
    final arguments = settings.arguments;

    switch(settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context)=> SplashScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context)=> LoginScreen());
      case RoutesName.otp:
        return MaterialPageRoute(builder: (BuildContext context)=> OtpScreen());
      case RoutesName.userDetail:
        return MaterialPageRoute(builder: (BuildContext context)=> UserDetailsScreen());
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context)=> BottomNavScreen());
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text('No routes defined'),
            ),
          );
        });
    }

  }

}