import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {
  NavDrawer() : super();
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  // UserModel user;
  BuildContext? _context;
  _NavDrawerState() {
    super.initState();
  }

  String idu1 = '';
  String idu2 = '';
  String email1 = '';
  String email2 = '';
  String userName1 = '';
  String userName2 = '';
  String idEntreprise1 = '';
  String idEntreprise2 = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: new Text(userName1,
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
            accountEmail: new Text(email1),
            currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('lib/resources/splashlogo.png')),
            // decoration: new BoxDecoration(color: Colors.green),
          ),
          ListTile(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => ProfilePage()));
            },
            leading: Icon(Icons.person),
            title: Text("profil"),
          ),
          ListTile(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => BugReportPage()));
            },
            leading: Icon(Icons.verified_outlined),
            title: Text("bug repport"),
          ),
          ListTile(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => ContactUstPage()));
            },
            leading: Icon(Icons.verified_outlined),
            title: Text("contact us"),
          ),
          ListTile(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => AboutPage()));
            },
            leading: Icon(Icons.badge),
            title: Text("About us"),
          ),
          ListTile(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) =>
              //             TermsAndConditionsPage()));
            },
            leading: Icon(Icons.badge),
            title: Text("Termes et condition"),
          ),
          ListTile(
            onTap: () {
              // logout().then((value) => {
              //       Navigator.of(context).pushAndRemoveUntil(
              //           MaterialPageRoute(builder: (context) => LoginPage()),
              //           (route) => false)
              //     });
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Exit"),
          ),
          ListTile(
            onTap: () async {
              // final url =
              //     'https://play.google.com/store/apps/details?id=fr.android.kufuli_pro';
              // if (await canLaunch(url)) {
              //   await launch(
              //     url,
              //     forceSafariVC: true,
              //     forceWebView: true,
              //     enableJavaScript: true,
              //   );
              // }
            },
            leading: Icon(Icons.info_sharp),
            title: Text(
              "Version :  1.1",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
