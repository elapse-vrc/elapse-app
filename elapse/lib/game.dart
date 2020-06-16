import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

Future<Tournament> fetchTournament() async {
  final response =
  await http.get('https://api.vexdb.io/v1/get_events?sku=RE-VRC-19-8481');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Tournament.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load JSON file. Perhaps you have no internet connection?');
  }
}

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
  final List<Match> matches;


  factory Tournament.fromJson(Map<String, dynamic> json) {
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
      end: json['end']
    );
  }
}

class Match {
  String sku;
  String division;
  int round;
  int instance;
  int matchNum;
  String field;
  String red1;
  String red2;
  String red3;
  String redSit;
  String blue1;
  String blue2;
  String blue3;
  String blueSit;
  int redScore;
  int blueScore;
  int scored;
  String scheduled;

  Match({ this.sku });
}