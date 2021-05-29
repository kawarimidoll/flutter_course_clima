import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_course_clima/services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude, longitude;

  @override
  void initState() {
    super.initState();
    print('initState!');
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.getLatitude();
    longitude = location.getLongitude();

    print('Latitude: $latitude, Longitude: $longitude');

    getData();
  }

  void getData() async {
    await dotenv.load();
    String apiKey = dotenv.env['OPENWEATHER_API_KEY'] ?? '';

    Uri url = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {
        'lat': latitude.toString(),
        'lon': longitude.toString(),
        'appid': apiKey,
      },
    );

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      print(data['coord']);
      print(data['weather'][0]);

      print(data['weather'][0]['id']);
      print(data['name']);
      print(data['main']['temp']);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: Center(
        //   child: ElevatedButton(
        //     onPressed: () {
        //       //Get the current location
        //       getLocation();
        //     },
        //     child: Text('Get Location'),
        //   ),
        // ),
        );
  }
}
