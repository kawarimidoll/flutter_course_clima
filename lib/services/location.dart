import 'package:geolocator/geolocator.dart';

class Location {
  double? _latitude;
  double? _longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      _latitude = position.latitude;
      _longitude = position.longitude;
    } catch (e) {
      print('ERROR!');
      print(e);
    }
  }

  double getLatitude() => _latitude ?? 0;
  double getLongitude() => _longitude ?? 0;
}
