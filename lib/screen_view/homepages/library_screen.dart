import 'package:assignment_test/res/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/routes/routes_name.dart';
class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(),
        body: Container(
          child: Center(
            child: ElevatedButton(
                onPressed: (){
                  auth.signOut().then((value){
                     Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false);
                  }).onError((error, stackTrace){
                    print(error.toString());
                  });
                }, 
                child: Text("Logout")
            ),
          ),
        ),
        )
    );
  }
}
