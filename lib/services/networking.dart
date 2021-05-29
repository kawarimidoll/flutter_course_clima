import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  late Uri url;

  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}
