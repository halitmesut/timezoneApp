import 'package:flutter/cupertino.dart';
import 'package:flutter_timezone_app/model/city_model.dart';
import 'package:flutter_timezone_app/model/timezone_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  var client = http.Client();

  Future getCityData() async {
    var uriList = Uri.parse('https://worldtimeapi.org/api/timezone');

    var response = await client.get(uriList);

    if (response.statusCode == 200) {
      var json = response.body;

      return cityListFromJson(json);
    }
  }

  Future getDetailsData() async {
    String? country = Hive.box("selectedCity").get("selectedCountrt");
    var client = http.Client();

    final uriCity = Uri.parse('http://worldtimeapi.org/api/timezone/$country');
    var response = await client.get(uriCity);
    try {
      if (response.statusCode == 200) {
        var json = response.body;
        return timezoneModelFromJson(json);
      } else {
        'hata';
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
