import 'package:flutter/material.dart';
import 'package:elapse/game.dart';
import 'dart:developer';

void main() {
  runApp(MaterialApp(home: GameList()));
}

class GameList extends StatefulWidget {
  @override
  _GameListState createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  Future<Tournament> futureTournament;

  matchType(game) { //gets the type of match
    if (game['round'] == 2) {
      return 'Q ';
    }
    else if (game['round'] == 6) {
      return 'R ';
    }
    else if (game['round'] == 3) {
      return 'QF ';
    }
    else if (game['round'] == 4) {
      return 'SF ';
    }
    else if (game['round'] == 5) {
      return 'F ';
    }
  }

  instanceModifier(game) { //removes .1 if type is Q
    if (game['round'] == 2) {
      return '';
    }
    else {
      return game['instance'].toString()+'.';
    }
  }

  Widget gameTemplate(game) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Divider(
            color: const Color(0xE6E6E6FF),
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          DefaultTextStyle(
            child: Row(
              children: <Widget>[
                Text(matchType(game), style: TextStyle(fontSize: 16)),
                Container(
                  width: 70,
                  child: Text(instanceModifier(game)+game['matchnum'].toString(), style: TextStyle(fontSize: 25)),
                ),
                Spacer(flex: 3),
                Container(
                  width: 60,
                  child: DefaultTextStyle(
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(game['red1'], textAlign: TextAlign.left),
                        Text(game['red2'], textAlign: TextAlign.left),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 25,
                  child: Text(
                    game['redscore'].toString(),
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.left,
                  ),
                ),
                Spacer(flex: 1),
                Container(
                  width: 25,
                  child: Text(
                    game['bluescore'].toString(),
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.right,
                  ),
                ),
                Container(
                    width: 60,
                    child: DefaultTextStyle(
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w300),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(game['blue1'], textAlign: TextAlign.right),
                          Text(game['blue2'], textAlign: TextAlign.right),
                        ],
                      ),
                    ))
              ],
            ),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    futureTournament = fetchTournament('RE-VRC-19-8481');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 235, 240, 239),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar (
                expandedHeight: 150.0,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Matches'),
                ),
            ),
            SliverFillRemaining(
              child: Center(
                  child: FutureBuilder<Tournament>(
                    future: futureTournament,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        //print(snapshot.data.matches[0]['division']);
                        return ListView(
                          children: snapshot.data.matches
                              .map((match) => gameTemplate(match))
                              .toList(),
                        );
                      } else if (snapshot.hasError) {
                        print('error');
                        return Text("${snapshot.error}");
                      }
                      print('loading');
                      // By default, show a loading spinner.
                      return CircularProgressIndicator();
                    },
                  ),
                ),
              ),
          ]
        ),
      ),
    );
  }
}
