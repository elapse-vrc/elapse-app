import 'package:flutter/material.dart';
import 'package:elapse/game.dart';

void main() {
  runApp(MaterialApp(
    home: GameList()
  ));
}

class GameList extends StatefulWidget {
  @override
  _GameListState createState() => _GameListState();
}

class _GameListState extends State<GameList> {

  Future<Tournament> futureTournament;

  @override
  void initState() {
    super.initState();
    futureTournament = fetchTournament();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('fetching data'),
        ),
        body: Center(
          child: FutureBuilder<Tournament>(
            future: futureTournament,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.locPostal);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
