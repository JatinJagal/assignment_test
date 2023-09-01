import 'package:assignment_test/res/components/custom_button.dart';
import 'package:assignment_test/res/components/custom_textfield.dart';
import 'package:assignment_test/res/consts/consts.dart';
import 'package:assignment_test/utils/controllers/authentication_controller.dart';
class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {

  // var authenticationController = AuthenticationController.instanceAuth;
  // var profileImage = authenticationController.profileImage.value;

  var controller = Get.put(AuthenticationController());

  //text controller
  var nameController = TextEditingController();


  var name = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 24.h,right: 24,left: 24),
          child: Column(

            children: [

              GestureDetector(
                onTap: (){
                  controller.chooseImageFromGallery();

                },
                child: CircleAvatar(
                  radius: 80.r,
                  backgroundImage: AssetImage(addImage),
                  backgroundColor: Colors.green,
             ),
              ),
              SizedBox(height: 20.h,),
              Text("Click on the Above image for add profile image"),
              SizedBox(height: 20.h,),
              CustomTextField(
                  keyboard: TextInputType.text,
                  controller: nameController,
                  onpress: (){},
                  val: name,
                  text: "Name",
                  icn: Icons.person,
                  color: Colors.black12,
              ),
              SizedBox(height: 20.h,),
              CustomButton(text: "Submit", onpress: (){
                controller.saveUserDataToStorage(
                    controller.profileImage!,nameController.text,context);
              }),

              // ElevatedButton(
              // onPressed: (){
              //   controller.saveUserDataToStorage(
              //       controller.profileImage!,nameController.text,context);
              // },
              //     child: controller.isLoading.value
              //         ? CircularProgressIndicator()
              //         : Text('Submit'))

            ],

          ),
        ),
      ),
    );
  }
}
