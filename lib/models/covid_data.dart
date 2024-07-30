// models/covid_data.dart

class CovidData {
  final int cases;
  final int deaths;
  final int recovered;

  CovidData(
      {required this.cases, required this.deaths, required this.recovered});

  factory CovidData.fromJson(Map<String, dynamic> json) {
    //factory constructor that creates a CovidData instance from a JSON map
    return CovidData(
      //returns CovidData instance by extracting values from the JSON map
      cases: json['cases'],
      deaths: json['deaths'],
      recovered: json['recovered'],
    );
  }
}
