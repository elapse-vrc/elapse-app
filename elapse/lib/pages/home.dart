import 'package:elapse/elapse_icons_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:elapse/game.dart';

bool _isEditingText = false;
TextEditingController _editingController;
String initialText = "00000A";

/*class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("home")
      ),
    );
  }
}*/

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class MyBehavior extends ScrollBehavior { // get rid of scroll glow
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class _HomePageState extends State<HomePage> {

  Future<List<Tournament>> futureTournamentList;

  void _getTeam() async { // Get currently selected teams
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.get('team') == null) {
        initialText = '00000A';
      }
      else {
        initialText = prefs.get('team');
      }
      _editingController.text = initialText;
    });
    futureTournamentList = fetchTournamentsByTeam(initialText, afterCurrentDate: true);
  }

  @override
  void initState(){
    super.initState();
    _editingController = TextEditingController(text: initialText);
    _getTeam();
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
    await prefs.setString('team', initialText);
  }

  Widget _editTitleTextField() { // Text field to be able to write to. Using TextField instead of EditableText because of autofocus. May change in the future.
    if (_isEditingText)
      return TextField(
        maxLength: 10, // There's no teams that have more than 6 characters, but I had to be safe.
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
          width: 110,
          child: Row(
            children: <Widget>[
              Text(
                initialText.toString(),
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300
                ),
              ),
              Align(alignment: Alignment.bottomLeft,child: Icon(Icons.edit, size: 15.0,)),
            ],
          ),
        )
    );
  }

  String xDaysAway (tour) {
    print(tour.start);
    String t = tour.start;
    var now = DateTime.now();
    var tournamentDate = DateTime.parse(t);
    print(tournamentDate.toIso8601String());

    final difference = tournamentDate.difference(now).inDays;

    return difference.toString() + " days away";
  }

  Widget tTemplate(tournamentList, index) {
    Widget tDivider (i) {
      if (i == 5) {
        return Container();
      }
      else {
        return Divider(
          color: const Color(0xE6E6E6FF),
          height: 20,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        );
      }
    }
    
    if (tournamentList.length < index) {
      return Container();
    }
    else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
                tournamentList[index].name,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 15,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
                xDaysAway(tournamentList[index]),
              style: TextStyle (
                color: Colors.black26,
              )
            ),
            tDivider(index),
          ],
        ),
      );
    }
  }
  
  Widget TournamentList (List<Tournament> tData) {
    if (tData.isNotEmpty) {
      return Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey[400], width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            color: const Color.fromARGB(255, 250, 255, 254),
            margin: const EdgeInsets.only(top: 10.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .stretch,
                children: <Widget>[
                  Container(
                    height: 60,
                    child: Text(
                      tData[0].name,
                      style: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.w300),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Text(xDaysAway(tData[0])),
                ],
              ),
            ),
          ),
          Container(height: 20,),
          tTemplate(tData, 1),
          tTemplate(tData, 2),
          tTemplate(tData, 3),
          tTemplate(tData, 4),
          tTemplate(tData, 5),
        ],
      );
    }
    else {
      return Container(
        height: 450,
        child: Center(child:
          Text(
              "No data found! Wrong team, or you're all done for the season!",
            style: TextStyle (
              fontStyle: FontStyle.italic,
              color: Colors.black54,
              fontSize: 20
            ),
            textAlign: TextAlign.center,
          )
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        color: const Color.fromARGB(255, 245, 250, 249),
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color.fromARGB(255, 245, 250, 249),
            body: ScrollConfiguration(
              behavior: MyBehavior(),
              child: CustomScrollView(
                slivers: <Widget>[
                    SliverAppBar (
                    backgroundColor: const Color.fromARGB(255, 245, 250, 249),
                    expandedHeight: 150.0,
                    flexibleSpace: const FlexibleSpaceBar(
                      title: Text('Welcome back!', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),),
                      titlePadding: EdgeInsetsDirectional.only(start: 20, bottom: 16),
                    ),
                    floating: false,
                    pinned: true,
                    elevation: 8,
                  ),
                  SliverFillRemaining (
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Flexible(child: _editTitleTextField()),
                                  ],
                                ),
                                FutureBuilder<List<Tournament>>(
                                  future: futureTournamentList,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return TournamentList(snapshot.data);
                                    }
                                    else if (snapshot.hasError) {
                                      print('error');
                                      return Text("${snapshot.error}");
                                    }
                                    else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }
                                ),
                                //Spacer(flex:1),

                              ],
                            ),
                            Container(height: 20),
                            Center(
                                child: Text(
                                  "Always file your axles!",
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black26,
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ),
        ),
      ),
    );
  }

  Future<void> _getData() async {
    setState(() {
      futureTournamentList = fetchTournamentsByTeam(initialText, afterCurrentDate: true);
    });
  }
}
