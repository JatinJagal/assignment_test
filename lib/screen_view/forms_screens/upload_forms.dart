import 'dart:io';

import 'package:assignment_test/res/consts/consts.dart';
import 'package:assignment_test/utils/controllers/location_controller.dart';
import 'package:assignment_test/utils/controllers/upload_controller.dart';
import 'package:video_player/video_player.dart';

import '../../res/components/custom_button.dart';
import '../../res/components/custom_textfield.dart';
import '../../utils/routes/routes_name.dart';
class UploadForms extends StatefulWidget {

  final File videoFile;
  final String videoPath;

  UploadForms({required this.videoFile,required this.videoPath});

  @override
  State<UploadForms> createState() => _UploadFormsState();
}

class _UploadFormsState extends State<UploadForms> {

  final String title = "";
  final String desc = "";

  String? location;

  void getloc(){
    setState(() {
      location = secController.currentLocation!;
    });
  }

  var controller = Get.put(UploadController());
  var secController = Get.put(LocationController());

  var titleController = TextEditingController();
  var descController = TextEditingController();
  var locationController = TextEditingController();

  VideoPlayerController? playerController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      playerController = VideoPlayerController.file(widget.videoFile);
    });

    playerController!.initialize();
    playerController!.play();
    playerController!.setVolume(2);
    playerController!.setLooping(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    playerController!.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(leading: IconButton(
            onPressed: (){
          Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false);
        }, icon: Icon(Icons.arrow_back_ios_rounded)),
        ),
        body: Container(
          padding: EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //display Video Player
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/1.6,
                  child: VideoPlayer(playerController!),
                ),

                showProgressBar == true
                    ? Container(
                        child: CircularProgressIndicator(backgroundColor: whiteColor),
                    )
                    : Column(
                  children: [
                    SizedBox(height: 10.h,),
                    //Title
                    CustomTextField(
                      keyboard: TextInputType.text,
                      controller: titleController,
                      onpress: (){},
                      val: title,
                      text: "Title",
                      icn: Icons.title,
                      color: Colors.black12,
                    ),
                    SizedBox(height: 10.h,),
                    //Description
                    CustomTextField(
                      keyboard: TextInputType.text,
                      controller: descController,
                      onpress: (){},
                      val: desc,
                      text: "Description",
                      icn: Icons.description_outlined,
                      color: Colors.black12,
                    ),
                    SizedBox(height: 10.h,),

                    CustomTextField(
                      keyboard: TextInputType.text,
                      controller: locationController,
                      onpress: (){},
                      val: desc,
                      text: "Location",
                      icn: Icons.location_on_outlined,
                      color: Colors.black12,
                    ),
                    CustomButton(text: "Get Location", onpress: () {

                      setState(() {
                        secController.getCurrentLocation();
                        secController.currentLocation == null
                            ? CircularProgressIndicator(backgroundColor: Colors.black12,)
                            : locationController.text =  secController.currentLocation.toString();
                      });


                    }),
            // showProgressBar == true? : CircularProgressIndicator()
                    //Upload Button
                    CustomButton(text:"Upload Now", onpress: () async{

                      if(titleController.text.isNotEmpty && descController.text.isNotEmpty){
                        controller.saveVideoInformationToFirebaseDatabase(
                            titleController.text,
                            descController.text,
                            locationController.text,
                            widget.videoPath,
                            context
                        );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("Please wait until the process not complete")));
                        }

                      }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
