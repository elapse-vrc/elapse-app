import 'package:elapse/elapse_icons_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            backgroundColor: const Color.fromARGB(255, 245, 250, 249),
            body: CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              slivers: <Widget>[
                  SliverAppBar (
                  backgroundColor: const Color.fromARGB(255, 245, 250, 249),
                  expandedHeight: 150.0,
                  flexibleSpace: const FlexibleSpaceBar(
                    title: Text('Home', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),),
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
                            Text('839A', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),),
                            Icon(Icons.edit),
                          ],
                        ),
                        Card (
                          margin: const EdgeInsets.all(0.0),
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
