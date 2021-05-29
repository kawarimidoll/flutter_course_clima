import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_course_clima/services/location.dart';

const API_KEY = 'b6907d289e10d714a6e88b30761fae22';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
  }

  void getData() async {
    Uri url = Uri.https(
      'samples.openweathermap.org',
      '/data/2.5/weather',
      {
        'lat': '35',
        'lon': '139',
        'appid': API_KEY,
      },
    );

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
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
