import 'package:assignment_test/res/consts/consts.dart';
import 'package:assignment_test/screen_view/homepages/add_post.dart';
import 'package:assignment_test/screen_view/homepages/feed_screen.dart';
import 'package:assignment_test/screen_view/homepages/library_screen.dart';
import 'package:assignment_test/utils/controllers/home_controller.dart';
class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  @override
  Widget build(BuildContext context) {

    //controller
    var controller = Get.put(HomeController());

    var navBarItem = [
      BottomNavigationBarItem(icon: Image.asset(icExplore, width: 26.sp),label: explore),
      BottomNavigationBarItem(icon: Image.asset(icAdd, width: 26.sp),label: add),
      BottomNavigationBarItem(icon: Image.asset(icLibrary, width: 26.sp),label: library)
    ];

    var navBody = [
      FeedScreen(),
      AddPostScreen(),
      LibraryScreen()
    ];

    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Obx(() => Expanded(child: navBody.elementAt(controller.currentNavIndex.value))),
            ],
          ),
          bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
                items: navBarItem,
              selectedItemColor: redColor,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              backgroundColor: whiteColor,
              type: BottomNavigationBarType.fixed,
            onTap: (value){
              controller.currentNavIndex.value = value;
            },
            ),
          ),
        )
    );
  }
}
