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

  void _getTeam() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _editingController.text = prefs.get('team');
      initialText = prefs.get('team');
    });
  }

  @override
  void initState(){
    super.initState();
    _editingController = TextEditingController(text: initialText);
    _getTeam();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  _newTeamWritten(val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      initialText = val.toUpperCase();
      _isEditingText = false;
    });
    await prefs.setString('team', initialText);
  }

  Widget _editTitleTextField() {
    if (_isEditingText)
      return TextField(
        maxLength: 10,
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
        child: Text(
          initialText,
          overflow: TextOverflow.fade,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w300
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
                            Align(alignment: Alignment.bottomLeft,child: Icon(Icons.edit, size: 15.0,)),
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
