import 'package:assignment_test/res/components/custom_button.dart';
import 'package:assignment_test/res/components/otp_field.dart';
import 'package:assignment_test/res/consts/consts.dart';
import 'package:assignment_test/screen_view/login_with_phone.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/routes/routes_name.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var code = "";

    return SafeArea(
        child: Scaffold(
          // extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
                onPressed: (){
                  Navigator.pushNamed(context, RoutesName.login);
                },
                icon: Icon(Icons.arrow_back_ios_rounded,color: blackColor,)
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset("assets/Enter OTP-bro.png",height: 250.h,width: 250.w,),
                  ),
                  SizedBox(height: 60.h,),
                  Pinput(
                    length: 6,
                    showCursor: true,
                    onChanged: (value){
                      code = value;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('Resend OTP', style: TextStyle(fontSize: 16.sp),),
                  ),
                  CustomButton(
                    text: "Verify OTP",
                    onpress: () async{

                      try{
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(
                            verificationId: LoginScreen.verify, smsCode: code);

                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);
                        Navigator.pushNamedAndRemoveUntil(context, RoutesName.userDetail, (route) => false);
                      }catch(e){
                        print("Wrong OTP");
                      }

                    },
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
