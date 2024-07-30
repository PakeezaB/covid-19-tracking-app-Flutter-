// services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/covid_data.dart';

class ApiService {
  static const String apiUrl = 'https://disease.sh/v3/covid-19/all';

  Future<CovidData> fetchCovidData() async {
    final response = await http.get(Uri.parse(apiUrl));
    //Sends an HTTP GET request to the API endpoint

    if (response.statusCode == 200) {
      return CovidData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load COVID-19 data');
    }
  }
}
