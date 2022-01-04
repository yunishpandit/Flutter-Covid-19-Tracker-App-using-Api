import 'dart:convert';

import 'package:covid_tracker/model/worldstatusmodel.dart';
import 'package:covid_tracker/services/utilies/app_url.dart';
import 'package:http/http.dart' as http;

class Stateservices {
  Future<Covidmodel> fetchworldstates() async {
    final response = await http.get(Uri.parse(Appurl.worldstatesapi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return Covidmodel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> countrieslist() async {
    var data;
    final response = await http.get(Uri.parse(Appurl.countrystate));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
