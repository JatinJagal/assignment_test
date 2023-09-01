import 'package:assignment_test/res/consts/consts.dart';

class CustomButton extends StatelessWidget {
  final text;
  final VoidCallback onpress;
  const CustomButton({Key? key, required this.text,required this.onpress}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        margin: EdgeInsets.all(12.0),
        width: double.infinity,
        height: 60.h,
        child: Center(child: Text(text,style: TextStyle(color: whiteColor,fontSize: 16.sp,fontWeight: FontWeight.w600),)),
        decoration: BoxDecoration(
          color: blueButton,
          borderRadius: BorderRadius.circular(12.0.h)
        ),
      ),
    );
  }
}
