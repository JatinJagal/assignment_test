import 'package:assignment_test/res/consts/consts.dart';
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onpress;
  final String text;
  late String val;
  final keyboard;
  final icn;
  final color;
   CustomTextField({Key? key,required this.keyboard, required this.controller, required this.onpress,required this.val,
    required this.text, required this.icn, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value){
        val=value;
      },
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
          fillColor: color,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20)
          ),
          filled: true,
          hintText: text,
          prefixIcon: Icon(icn,color: Colors.teal,),
          hintStyle: TextStyle(),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          )
      ),
    );
  }
}
