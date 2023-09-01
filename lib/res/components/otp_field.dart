import 'package:assignment_test/res/consts/consts.dart';
class OtpField extends StatelessWidget {
  const OtpField({Key? key, required this.otpController}): super(key: key);
  final TextEditingController otpController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 50.w,
      child: TextField(
        onSubmitted: (value){},
        controller: otpController,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value){
          if(value.length == 1){
            FocusScope.of(context).nextFocus();
          }
          if(value.isEmpty){
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: InputDecoration(
            hintText: '0',
            fillColor: Colors.black12,
            border: OutlineInputBorder()
        ),
      ),
    );
  }
}
