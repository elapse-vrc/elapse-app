import 'package:elapse/elapse_icons_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:elapse/strings.dart';
import 'package:elapse/pages/credits.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget appIcon() {
    return Container(width: 30, height: 30, alignment: Alignment.center, child: Image(image: AssetImage('include/drawable/images/smallelapse.png')));
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
      title: 'Configure',
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
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: const Color.fromARGB(255, 245, 250, 249),
                    expandedHeight: 150.0,
                    flexibleSpace: const FlexibleSpaceBar(
                      title: Text(
                        'About & Configure',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w300),
                      ),
                      titlePadding:
                          EdgeInsetsDirectional.only(start: 20, bottom: 16),
                    ),
                    floating: false,
                    pinned: true,
                    elevation: 8,
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(

                            'More settings, such as dark mode and tournament delay config, will arrive in the future!',
                            style: TextStyle(fontSize: 17),
                          ),
                          Container(
                            height: 20,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey[400], width: 1.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            margin: const EdgeInsets.only(top: 10.0),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    height: 60,
                                    child: Image(
                                      image: AssetImage(
                                          'include/drawable/images/elapselogodark.png'),
                                      alignment: Alignment.topLeft,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(aboutElapse, style: TextStyle(fontSize: 14.5)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                          ),
                          ListTile(
                            title: Text('Our Website'),
                            trailing: Icon(Icons.language),
                            onTap: () {},
                          ),
                          divider(),
                          ListTile(
                            title: Text('GitHub Repository'),
                            trailing: Icon(Icons.code),
                            onTap: () => launchUrl('https://github.com/elapse-vrc/elapse-app'),
                          ),
                          divider(),
                          ListTile(
                            title: Text('Credits'),
                            trailing: Icon(Icons.insert_emoticon),
                            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => CreditsPage()));},
                          ),
                          divider(),
                          ListTile(
                            title: Text('Send Feedback'),
                            trailing: Icon(Icons.feedback),
                            onTap: () => launchUrl('https://forms.gle/NbwEPV58Saxm6DUe6'),
                          ),
                          divider(),
                          ListTile(
                            title: Text('More Info'),
                            trailing: Icon(Icons.info),
                            onTap: () => showAboutDialog(context: context, applicationVersion: '0.0.1', applicationName: 'Elapse', applicationLegalese: 'Elapse is an app for the VEX Robotics Competition.', applicationIcon: appIcon()),
                          ),
                          Container(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
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
