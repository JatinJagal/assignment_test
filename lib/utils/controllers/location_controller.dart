import 'package:assignment_test/res/consts/consts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController{

  Position? currentPosition;
  var isLoading = false.obs;

   // String? _currentLocation;
  String? currentLocation;
  //
  // String? get currentLocation => _currentLocation;
// this tow line edited up

  Future<Position> getPosition() async{
    LocationPermission? permission;

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error("Location Permission are denied");
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getAddressFromLatLng(long,lat) async{
    try{
      List<Placemark> place = await placemarkFromCoordinates(lat, long);
      Placemark placemark = place[0];

      currentLocation = "${placemark.locality},${placemark.name},${placemark.subLocality},${placemark.subAdministrativeArea}";
      update();
    }catch(e){
      print(e.toString());
    }
  }

  Future<void> getCurrentLocation() async{
    try{
      isLoading(true);
      update();
      currentPosition = await getPosition();
      getAddressFromLatLng(currentPosition!.longitude, currentPosition!.latitude);

      isLoading(false);
      update();
    }catch(e){
      print(e.toString());
    }
  }

}