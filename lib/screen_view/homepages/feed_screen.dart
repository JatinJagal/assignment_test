import 'package:assignment_test/res/components/circle_icon_button.dart';
import 'package:assignment_test/res/components/custom_textfield.dart';
import 'package:assignment_test/res/consts/consts.dart';
import 'package:assignment_test/utils/controllers/authentication_controller.dart';
import 'package:assignment_test/utils/controllers/feed_controller.dart';
import 'package:assignment_test/view_model/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  TextEditingController searchController = TextEditingController();
  final getUserData = Get.put(FeedController());
  var search = "";

  final videoInfo = FirebaseFirestore.instance.collection('videos').snapshots();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                height: 200.h,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("App Logo", style: TextStyle(color: whiteColor),),
                        CircleButton(icn: "assets/bell.png")
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    CustomTextField(
                      keyboard: TextInputType.text,
                      val: search,
                      controller: searchController,
                      onpress: (){},
                      text: "Search",
                      icn: Icons.search,
                      color: whiteColor)
                  ],
                ),
                decoration: BoxDecoration(
                  color: blueButton
                ),
              ),
              Container(
                // color: Colors.green,
                padding: EdgeInsets.all(12.0),
                height: 570.h,
                child: StreamBuilder(
                  stream: videoInfo,
                    builder: (context, snapshot){
                      if(snapshot.hasError){
                        return Text("Connection Error");
                      }
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Text("Loading...");
                      }
                      var docs = snapshot.data!.docs;
                        // return Text('${docs.length}');
                        return ListView.builder(
                            itemCount: docs.length,
                            itemBuilder: (context, index){


                              return Container(
                                margin: EdgeInsets.only(top: 10.h,bottom: 10.h),
                                height: 220.h,
                                width: 520.w,
                                decoration: BoxDecoration(
                                  // color: Colors.green,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 46.h,width: 46.w,
                                          decoration: BoxDecoration(color: Colors.black,
                                              image: DecorationImage(image: NetworkImage(
                                                  docs[index]['userProfileImage']),fit: BoxFit.cover),
                                              borderRadius: BorderRadius.circular(12)),
                                        ),
                                        SizedBox(width: 10.w,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(docs[index]['userName'],style: TextStyle(fontWeight: FontWeight.bold),),
                                            SizedBox(height: 4,),
                                            Text(docs[index]['titleName'],style: TextStyle(color: Colors.black38),)
                                          ],
                                        ),
                                        SizedBox(width: 20.w,),
                                        Text(docs[index]['location'],)
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),

                                    Card(
                                      elevation: 0.0,
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Stack(
                                          children: [
                                            Ink.image(image: NetworkImage(docs[index]['thumbnailUrl']),//main img
                                              height: 120.h,
                                              width: 400.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ]
                                      ),
                                    ),


                                    SizedBox(height: 10.h,),
                                  ],
                                ),
                              );




                            }
                        );
                      },
                ),
              )
            ],
          ),
        )
    );
  }
}
