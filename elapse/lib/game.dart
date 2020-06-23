import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:developer';

Future<Tournament> fetchTournament(String sku) async {
  final response =
  await http.get('https://api.vexdb.io/v1/get_events?sku=$sku');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.




    log('internal match list made');
    return Tournament.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    log('test');
    throw Exception('Failed to load JSON file. Perhaps you have no internet connection?');
  }
}


Future<List<Tournament>> fetchTournamentsByTeam(String team) async {
  final response =
  await http.get('https://api.vexdb.io/v1/get_events?sku=$team');
  Map<String, dynamic> tRawJson = json.decode(response.body);

  List<dynamic> tempTList;
  List<Tournament> tList = [];

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.


    log('internal match list made');
    if (response.statusCode == 200) {
      tempTList = tRawJson['result'];

      for (int i = 0; i < tRawJson.length; i += 1) {
        tList.add(Tournament.fromJson(tempTList[i]));
      }
      return (tList);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      log('test');
      throw Exception(
          'Failed to load JSON file. Perhaps you have no internet connection?');
    }
  }
}

Future<List<Match>> fetchMatches(String sku) async {
  final matchResponse =
  await http.get('https://api.vexdb.io/v1/get_matches?sku=$sku');
  Map<String, dynamic> matchRawJson = json.decode(matchResponse.body);

  print(matchRawJson);

  List<dynamic> tempMatchList;
  List<Match> matchList = [];

  if (matchResponse.statusCode == 200) {
    print(matchRawJson['result']);
    tempMatchList = matchRawJson['result'];

    for (int i = 0; i < matchRawJson.length; i += 1) {
      matchList.add(Match.fromJson(tempMatchList[i]));
    }
    return (matchList);
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
      end: json['end'],
    );
  }
}

class Match {
  const Match({
      this.sku,
      this.division,
      this.round,
      this.instance,
      this.matchnum,
      this.field,
      this.red1,
      this.red2,
      this.red3,
      this.redsit,
      this.blue1,
      this.blue2,
      this.blue3,
      this.bluesit,
      this.redscore,
      this.bluescore,
      this.scored,
      this.scheduled
    });

  final String sku;
  final String division;
  final int round;
  final int instance;
  final int matchnum;
  final String field;
  final String red1;
  final String red2;
  final String red3;
  final String redsit;
  final String blue1;
  final String blue2;
  final String blue3;
  final String bluesit;
  final int redscore;
  final int bluescore;
  final int scored;
  final String scheduled;

  factory Match.fromJson(Map<String, dynamic> json) {
    if (json == null || json['status'] != 1) {
      throw FormatException("Error fetching data from VexDB. Perhaps you mistyped?");
    }

    return Match(
      sku: json['sku'],
      division: json['division'],
      round: json['round'],
      instance: json['instance'],
      matchnum: json['matchnum'],
      field: json['field'],
      red1: json['red1'],
      red2: json['red2'],
      red3: json['red3'],
      redsit: json['redsit'],
      blue1: json['blue1'],
      blue2: json['blue2'],
      blue3: json['blue3'],
      bluesit: json['bluesit'],
      redscore: json['redscore'],
      bluescore: json['bluescore'],
      scored: json['scored'],
      scheduled: json['scheduled'],
    );
  }
}