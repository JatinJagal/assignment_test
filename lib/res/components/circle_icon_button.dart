import 'package:assignment_test/res/consts/consts.dart';
class CircleButton extends StatelessWidget {
  final icn;
  const CircleButton({Key? key, required this.icn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(height: 50,width: 50,
          child:Image.asset(icn,height: 14,width: 14,fit: BoxFit.none,color: Colors.black,),
          // Icon(Icons.search,color: Colors.black,),),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: blackColor,
                  blurRadius: 16.0,
                  // spreadRadius: 5.0,
                  offset: Offset(2.0, 4.0),
                )
              ]
          ),
        ));
  }
}
