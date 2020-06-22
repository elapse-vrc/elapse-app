import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:developer';

Future<Tournament> fetchTournament(String sku) async {
  final response =
  await http.get('https://raw.githubusercontent.com/elapse-vrc/testdata/master/data.json');

  final matchResponse =
  await http.get('https://raw.githubusercontent.com/elapse-vrc/testdata/master/data.json');

  List<dynamic> tempMatchList;
  List<Map<String, dynamic>> matchList = [];

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    Map<String, dynamic> matchRawJson = json.decode(matchResponse.body);
    print(matchRawJson['result']);
    tempMatchList = matchRawJson['result'];
    
    for (int i = 0; i < matchRawJson['size']; i += 1){

      print(tempMatchList[0]);
      matchList.add(tempMatchList[i]);

    }


    log('internal match list made');
    return Tournament.fromJson(json.decode(response.body), matchList);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    log('test');
    throw Exception('Failed to load JSON file. Perhaps you have no internet connection?');
  }
}

// Serialize Tournament data into a readable object format
class Tournament {
  const Tournament({
    this.sku,
    this.key,
    this.program,
    this.name,
    this.locVenue,
    this.locAddress1,
    this.locAddress2,
    this.locCity,
    this.locRegion,
    this.locPostal,
    this.locCountry,
    this.season,
    this.start,
    this.end,
    this.matches,
  });

  final String sku;
  final String key;
  final String program;
  final String name;
  final String locVenue;
  final String locAddress1;
  final String locAddress2;
  final String locCity;
  final String locRegion;
  final String locPostal;
  final String locCountry;
  final String season;
  final String start;
  final String end;
  final List<Map<String, dynamic>> matches;


  factory Tournament.fromJson(Map<String, dynamic> json, List<Map<String, dynamic>> matchList) {
    if (json == null || json['status'] != 1) {
      throw FormatException("Error fetching data from VexDB. Perhaps you mistyped?");
    }
    json = json['result'][0];

    return Tournament(
      sku: json['sku'],
      key: json['key'],
      program: json['program'],
      name: json['name'],
      locVenue: json['loc_venue'],
      locAddress1: json['loc_address_1'],
      locCity: json['loc_city'],
      locRegion: json['loc_region'],
      locPostal: json['loc_postcode'],
      locCountry: json['loc_country'],
      season: json['season'],
      start: json['start'],
      end: json['end'],
      matches: matchList
    );
  }
}