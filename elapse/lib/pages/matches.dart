import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elapse/game.dart';
import 'dart:developer';
import 'package:marquee/marquee.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool _isEditingText = false;
TextEditingController _editingController;
String initialText = "RE-VRC-00-0000";



void main() {
  runApp(MaterialApp(home: GameList()));
}

class GameList extends StatefulWidget {
  const GameList({Key key}) : super(key: key);
  @override
  _GameListState createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  Future<List<Match>> futureMatchList;

  matchType(game) {
    //gets the type of match
    if (game.round == 2) {
      return 'Q';
    } else if (game.round == 6) {
      return 'R';
    } else if (game.round == 3) {
      return 'QF';
    } else if (game.round == 4) {
      return 'SF';
    } else if (game.round == 5) {
      return 'F';
    }
  }

  instanceModifier(game) {
    //removes .1 if type is Q
    if (game.round == 2) {
      return '';
    } else {
      return game.instance.toString() + '.';
    }
  }

  Widget marqueeMaker(game) {
    if (game.field.length < 10) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            game.field,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
        ],
      );
    }
    else {
      return Marquee(
              text: game.field,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              velocity: 10,
              blankSpace: 25.0,
              pauseAfterRound: Duration(seconds: 1),
              accelerationDuration: Duration(seconds: 1),
              decelerationDuration: Duration(seconds: 1),
      );
    }
  }

  Widget mainDataModifier(game) {
    //Changes the score to show field and time if match hasnt been played yet
    if (game.redscore == 0 && game.bluescore == 0) {
      return Row(children: <Widget>[
        Container(
          width: 60,
          height: 30,
          child: marqueeMaker(game)
        ),
        Spacer(flex: 1),
        Container(

          width: 45,
          child: Text(
            game.scheduled.toString().substring(11, 16),
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            textAlign: TextAlign.right,
          ),
        ),
      ]);
    } else {
      return Row(children: <Widget>[
        Container(
          width: 35,
          child: Text(
            game.redscore.toString(),
            style: TextStyle(
                color: Colors.red, fontSize: 20, fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
        ),
        Spacer(flex: 1),
        Container(
          width: 35,
          child: Text(
            game.bluescore.toString(),
            style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.normal),
            textAlign: TextAlign.right,
          ),
        ),
      ]);
    }
  }

  sizeChanger(game) {
    //changes size for the list if match not played
    if (game.redscore == 0 && game.bluescore == 0) {
      return 110.0;
    } else {
      return 80.0;
    }
  }

  Widget matchDivider(game) {
    // Removes divider if it's the first match
    if (game.matchnum == 1 && game.round == 2) {
      return Container(
        color: const Color.fromARGB(255, 245, 250, 249),
        height: 15,
      );
    } else {
      return Divider(
        color: const Color(0xE6E6E6FF),
        height: 20,
        thickness: 1,
        indent: 20,
        endIndent: 20,
      );
    }
  }


  void _getSku() async { // Get currently selected teams
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.get('sku') == null) {
        initialText = 'RE-VRC-00-0000';
      }
      else {
        initialText = prefs.get('sku');
      }
      _editingController.text = initialText;
    });
    futureMatchList = fetchMatches(initialText);
  }

  @override
  void initState(){
    super.initState();
    _editingController = TextEditingController(text: initialText);
    _getSku();
    //futureMatchList = fetchMatches(initialText);
  }

  @override
  void dispose() { // Dispose of the editing controller when main widget is disposed
    _editingController.dispose();
    super.dispose();
  }

  _newTeamWritten(val) async { // When new team is written, update initialText and write to disk
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      initialText = val.toUpperCase(); // Convert 000a to 000A for consistency
      _isEditingText = false;
      _getData();
    });
    await prefs.setString('sku', initialText);
  }

  Widget _editTitleTextField() { // Text field to be able to write to. Using TextField instead of EditableText because of autofocus. May change in the future.
    if (_isEditingText)
      return TextField(
        maxLength: 14, // There's no teams that have more than 6 characters, but I had to be safe.
        maxLengthEnforced: true,
        onSubmitted: (newValue){_newTeamWritten(newValue);},
        autofocus: true,
        controller: _editingController,
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: Container(
            width: 200,
            height: 25,
            child: Row(
              children: <Widget>[
                Text(
                  initialText.toString(),
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300
                  ),
                ),
                Align(alignment: Alignment.centerLeft,child: Icon(Icons.edit, size: 15.0,)),
              ],
            ),
          ),
    );
  }

  Widget textEdit() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        children: <Widget>[
          Flexible(child: _editTitleTextField()),
        ],
      ),
    );
  }
  

  Widget gameTemplate(game) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          matchDivider(game),
          DefaultTextStyle(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Container(
                    width: 20,
                    child: Text(matchType(game), style: TextStyle(fontSize: 16), textAlign: TextAlign.right,),
                  ),
                ),
                Container(
                  width: 70,
                  child: Text(
                      instanceModifier(game) + game.matchnum.toString(),
                      style: TextStyle(fontSize: 25)),
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
                        Text(game.red1, textAlign: TextAlign.left),
                        Text(game.red2, textAlign: TextAlign.left),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: sizeChanger(game),
                  child: mainDataModifier(game),
                ),
                Container(
                    width: 60,
                    child: DefaultTextStyle(
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w300),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(game.blue1, textAlign: TextAlign.right),
                          Text(game.blue2, textAlign: TextAlign.right),
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
  Widget build(BuildContext context) {
    // https://stackoverflow.com/questions/52146850/how-to-use-futurebuilder-inside-sliverlist
    final appBarSliver = SliverAppBar(
      backgroundColor: const Color.fromARGB(255, 245, 250, 249),
      expandedHeight: 150.0,
      flexibleSpace: const FlexibleSpaceBar(
        title: Text(
          'Matches',
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
        titlePadding: EdgeInsetsDirectional.only(start: 20, bottom: 16),
      ),
      floating: false,
      pinned: true,
      elevation: 8,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Match Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        color: const Color.fromARGB(255, 245, 250, 249),
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            backgroundColor: const Color.fromARGB(255, 245, 250, 249),
            body: FutureBuilder<List<Match>>(
              future: futureMatchList,
              builder: (context, snapshot) {
                Widget matchListSliver;
                if (snapshot.hasData) {
                  //print(snapshot.data.matches[0]['division']);
                  matchListSliver = SliverList(
                      delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      print(snapshot.data[index]);
                      return gameTemplate(snapshot.data[index]);
                    },
                    childCount: snapshot.data.length,
                  ));
                } else if (snapshot.hasError) {
                  print('error');
                  return Text("${snapshot.error}");
                } else {
                  print('loading');
                  // By default, show a loading spinner.
                  matchListSliver = SliverFillRemaining(
                      child: Center(
                        child: Container(child: CircularProgressIndicator()),
                      )
                  );


                }

                final textSliver = SliverToBoxAdapter(
                  child: Container(
                      child: textEdit(),
                  ),
                );


                return RefreshIndicator(
                  child: CustomScrollView(
                    slivers: <Widget>[appBarSliver, textSliver, matchListSliver,],
                  ),
                  onRefresh: _getData,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getData() async {
    setState(() {
      futureMatchList = fetchMatches(initialText);

      //show a snackbar to show that loading new matches is complete
      final reloadSnackBar = SnackBar(content: Text('Refreshed matches list'));
      Scaffold.of(context).showSnackBar(reloadSnackBar);
    });
  }
}
