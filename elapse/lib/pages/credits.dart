import 'package:elapse/elapse_icons_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:elapse/strings.dart';

class CreditsPage extends StatefulWidget {
  const CreditsPage({Key key}) : super(key: key);
  @override
  _CreditsPageState createState() => _CreditsPageState();
}

class MyBehavior extends ScrollBehavior { // get rid of scroll glow
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class _CreditsPageState extends State<CreditsPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget appIcon() {
    return Container(
        width: 30,
        height: 30,
        child: Image(
            image: AssetImage('include/drawable/images/smallelapse.png')));
  }

  Widget divider() {
    return Divider(
      color: const Color(0xE6E6E6FF),
      height: 20,
      thickness: 1,
      indent: 20,
      endIndent: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Credits',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        color: const Color.fromARGB(255, 245, 250, 249),
        child: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomPadding: false,
              backgroundColor: const Color.fromARGB(255, 245, 250, 249),
              body: ScrollConfiguration(
                behavior: MyBehavior(),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                        backgroundColor: const Color.fromARGB(255, 245, 250, 249),
                        expandedHeight: 150.0,
                        flexibleSpace: const FlexibleSpaceBar(
                          title: Text(
                            'Credits',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w300),
                          ),
                          titlePadding:
                              EdgeInsetsDirectional.only(start: 20, bottom: 16),
                        ),
                        floating: true,
                        pinned: true,
                        elevation: 8,
                        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Navigator.pop(context);}, color: Colors.black, tooltip: 'Back'),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 25,
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage: AssetImage('include/drawable/images/afyn.jpg'),
                                    radius: 35,
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 15, bottom: 3),
                                      child: Text("@a-fyn", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 3),
                                      child: Text("Developer, Designer, & Marketing", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic), softWrap: true),
                                  )

                                ],
                              ),
                            ),
                            Spacer(flex: 1),
                            Container(
                              height: 170,
                              child: Column(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage: AssetImage('include/drawable/images/wontonsoup.png'),
                                    radius: 35,
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 15, bottom: 3),
                                    child: Text("@WontonSoup777", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 3),
                                    child: Text("Developer, Designer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic), softWrap: true),
                                  )

                                ],
                              ),
                            ),
                            Spacer(flex: 1),
                            Container(
                              height: 130,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundImage: AssetImage('include/drawable/images/flaticon.png'),
                                        backgroundColor: Colors.black,
                                        radius: 20,
                                      ),
                                      Padding(padding: EdgeInsets.only(left: 10),
                                        child: Text("Flaticon", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                      ),
                                      Padding(padding: EdgeInsets.only(left: 5),
                                        child: Text("Various Icons", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic), softWrap: true),
                                      )

                                    ],
                                  ),
                                  Container(height: 20),
                                  Text("Your name could be here!", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic, color: Colors.grey[500]), softWrap: true),
                                  RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Contribute at ",
                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.grey[500]
                                            ),
                                          ),
                                          TextSpan(
                                            text: "github.com/elapse-vrc/elapse-app",
                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.grey[700]
                                            ),
                                            recognizer: new TapGestureRecognizer()
                                              ..onTap = () {launchUrl('https://github.com/elapse-vrc/elapse-app');}

                                          ),
                                        ]
                                      ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

launchUrl(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
