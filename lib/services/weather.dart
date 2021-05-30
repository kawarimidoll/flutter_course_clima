import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_course_clima/services/location.dart';
import 'package:flutter_course_clima/services/networking.dart';

class WeatherModel {
  Future<String> loadApiKey() async {
    await dotenv.load();
    return dotenv.env['OPENWEATHER_API_KEY'] ?? '';
  }

  Future<dynamic> getCityWeather(String cityName) async {
    String apiKey = await loadApiKey();

    Uri url = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {
        'q': cityName,
        'appid': apiKey,
        'units': 'metric',
      },
    );

    NetworkHelper networkHelper = NetworkHelper(url);
    return await networkHelper.getData();
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    String apiKey = await loadApiKey();

    Uri url = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {
        'lat': location.getLatitude().toString(),
        'lon': location.getLongitude().toString(),
        'appid': apiKey,
        'units': 'metric',
      },
    );

    NetworkHelper networkHelper = NetworkHelper(url);
    return await networkHelper.getData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
