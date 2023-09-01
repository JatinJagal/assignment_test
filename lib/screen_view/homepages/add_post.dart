import 'dart:io';

import 'package:assignment_test/res/consts/consts.dart';
import 'package:assignment_test/screen_view/forms_screens/upload_forms.dart';
import 'package:assignment_test/utils/controllers/location_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {


  getVideoFile(ImageSource sourceImg) async{
    final videoFile = await ImagePicker().pickVideo(source: sourceImg);

    if(videoFile != null){
      //Video Confirmation Screen
      Get.to(UploadForms(
        videoFile: File(videoFile.path),
        videoPath: videoFile.path,
      ));
    }
  }



  displayDialogBox(){
    return showDialog(
        context: context,
        builder: (context)=> SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: (){
                getVideoFile(ImageSource.camera);
              },
              child: Row(
                children: [
                  Icon(Icons.video_call_outlined),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Record Video with Camera",
                      maxLines: 2,
                      style: TextStyle(fontSize: 12),),
                  )
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: (){
                Get.back();
              },
              child: Row(
                children: [
                  Icon(Icons.cancel_outlined),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Cancel",style: TextStyle(fontSize: 14),),
                  )
                ],
              ),
            )
          ],
        )
    );
  }

  bool onClick = false;
  void changeWid(){
    setState(() {
      onClick = true;
    });
  }

  var controller = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.red,
          body: Container(
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: ElevatedButton(
                      onPressed: (){
                        displayDialogBox();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenColor
                      ),
                      child: Text(
                        "Upload New Video",
                        style: TextStyle(
                          fontSize: 20,
                          color: whiteColor,
                          fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                ),

                SizedBox(height: 140.h,),

                onClick == true ? ElevatedButton(onPressed: (){
                  setState(() {
                    onClick = true;
                  });
                },
                    child:Text("Text")) : CircularProgressIndicator(),

                // onClick == false ? CircularProgressIndicator():ElevatedButton(onPressed: (){}, child: Text("examop;e"))
              ],
            ),
          ),
        );

  }
}




// Obx(()=> Center(
// child: controller.isLoading.value
// ?CircularProgressIndicator()
//     : Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 16.0),
// child: Text(controller.currentLocation == null
// ?'No Location Found'
//     :controller.currentLocation!,
// style: TextStyle(fontSize: 24),textAlign: TextAlign.center,),
// ),
// SizedBox(height: 20.h,),
// ElevatedButton(
// onPressed: (){
// controller.getCurrentLocation();
// },
// child: Text("Get User Location")
// )
// ],
// ),
// ),
// )



