import 'package:assignment_test/res/components/custom_button.dart';
import 'package:assignment_test/res/components/custom_textfield.dart';
import 'package:assignment_test/res/consts/consts.dart';
import 'package:assignment_test/screen_view/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/routes/routes_name.dart';

class LoginScreen extends StatefulWidget {
  static String verify = "";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // TextEditingController phoneController = TextEditingController();

  var phone = "";

  TextEditingController countryCode = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    countryCode.text = "+91";
    super.initState();
  }

  // var phone = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/Mobile login-rafiki.png",height: 350.h,width: 350.w,),
              SizedBox(height: 40.h,),

              //TextField for phone
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryCode,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                          onChanged: (value){
                            phone = value;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                          ),
                        ))
                  ],
                ),
              ),
              CustomButton(
                text: "Send Otp",
                onpress: () async{
                          await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: '${countryCode.text+phone}',
                          verificationCompleted: (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            LoginScreen.verify = verificationId;
                            Navigator.pushNamed(context, RoutesName.otp);
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

