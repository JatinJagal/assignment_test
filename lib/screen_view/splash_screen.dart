import 'package:assignment_test/firebase_services/splash_services.dart';
import 'package:assignment_test/res/consts/consts.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashService splashScreen = SplashService();

  @override
  void initState() {
    // TODO: implement initState
    splashScreen.isLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Splash Screen", style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
