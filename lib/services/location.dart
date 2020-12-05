import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;
  double startlatitude;
  double startlongitude;
  double endlatitude;
  double endlongitude;
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      latitude = position.latitude;
      longitude = position.longitude;
      print(latitude);
      print(longitude);
    } catch (e) {
      print(e);
    }
  }
  double getDistance(startlatitude,startlongitude,endlatitude,endlongitude){
    double distanceInMeters = Geolocator.distanceBetween(startlatitude, startlongitude, endlatitude, endlongitude);
    return distanceInMeters;
  }
}