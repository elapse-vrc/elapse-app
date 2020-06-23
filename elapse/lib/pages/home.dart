import 'package:elapse/elapse_icons_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class _HomePageState extends State<HomePage> {

  void _getTeam() async { // Get currently selected teama
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

  @override
  Widget build(BuildContext context) {
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
            resizeToAvoidBottomPadding: false,
            backgroundColor: const Color.fromARGB(255, 245, 250, 249),
            body: CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row (
                          children: <Widget>[
                            Flexible(child: _editTitleTextField()),
                          ],
                        ),
                        Card (
                          margin: const EdgeInsets.only(top: 10.0),
                          child: Padding (
                            padding: const EdgeInsets.all(12.0),
                            child: Column (
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  height: 60,
                                  child: Text('Signature Event: High School VRC KALAHARI CLASSIC INDOOR WATERPARK MULTI-STATE EVENT',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Text('100 days away'),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}
