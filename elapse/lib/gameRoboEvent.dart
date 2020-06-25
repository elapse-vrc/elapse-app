import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:html/parser.dart';


Future<Tournament> fetchTournament(String sku) async {
  final response =
  await http.get('https://www.robotevents.com/api/v2/events?sku[]=$sku');

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


Future<List<Tournament>> fetchTournamentsByTeam(String team, {bool afterCurrentDate = false, int responses:99999999}) async {

  String rAmount = responses.toString();
  final response =
  await http.get('https://api.vexdb.io/v1/get_events?team=$team&limit_number=$rAmount');
  Map<String, dynamic> tRawJson = json.decode(response.body);

  List<dynamic> tempTList;
  List<Tournament> tList = [];

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    log('internal match list made');
    if (response.statusCode == 200) {
      tempTList = tRawJson['result'];

      for (int i = 0; i < tRawJson['size']; i += 1) {
        //print(tempTList[i]['sku']);
        var tDate = DateTime.parse(tempTList[i]['start']);
        if (afterCurrentDate) {
          if (tDate
              .difference(DateTime.now())
              .inDays > -1) {
            tList.add(Tournament.fromJson(tempTList[i]));
          }
        }
        else {
          tList.add(Tournament.fromJson(tempTList[i]));
        }
      }
      tList = afterCurrentDate && tList.isNotEmpty ? tList.reversed.toList() : tList; // Reverse the list to make it from day up
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

  List<dynamic> tempMatchList;
  List<Match> matchList = [];

  if (matchResponse.statusCode == 200) {
    tempMatchList = matchRawJson['result'];

    for (int i = 0; i < matchRawJson['size']; i += 1) {
      //print(tempMatchList[i]);
      matchList.add(Match.fromJson(tempMatchList[i]));
    }
    //print(matchList);
    return (matchList);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    //log('test');
    throw Exception('Failed to load JSON file. Perhaps you have no internet connection?');
  }
}

Future<List<dynamic>> getCsrfTokenAndCookie () async {
  final response =
  await http.Client().get(Uri.parse('https://www.robotevents.com'));

  final body = parse(response.body); // Convert body into readable string

  if (response.statusCode == 200) {
    final csrfToken = body.getElementsByTagName('meta')[3].attributes['content']; // Extract csrf-token from all meta tags and store content attribute
    final cookie = response.headers['set-cookie'].split(',').map((cookie) => cookie.substring(0, cookie.indexOf(';') + 1)).join(' ');
    print(csrfToken);
    print(cookie);
    return [csrfToken, cookie];
  } else {
    throw Exception();
  }
}

Future<List<Tournament>> testFunc () async {
  final cookieandtoken = await getCsrfTokenAndCookie();
  final csrfToken = cookieandtoken[0];
  final cookie = cookieandtoken[1];

  final response = await http.Client().get(
      'https://www.robotevents.com/api/v2/events',
    headers: {
        'origin': 'https://www.robotevents.com',
        'x-csrf-token': csrfToken,
      }
  );
  print(response.body);
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
    this.divisions
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
  final List<dynamic> divisions;


  factory Tournament.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw FormatException("Error fetching data from VexDB. Perhaps you mistyped?");
    }

    return Tournament(
      sku: json['sku'],
      key: json['key'],
      program: json['program'],
      name: json['name'],
      locVenue: json['loc_venue'],
      locAddress1: json['loc_address1'],
      locCity: json['loc_city'],
      locRegion: json['loc_region'],
      locPostal: json['loc_postcode'],
      locCountry: json['loc_country'],
      season: json['season'],
      start: json['start'],
      end: json['end'],
      divisions: json['divisions'],
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
    this.scheduled,
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
    if (json == null) {
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