import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ttlock_flutter/ttlock.dart';
import 'package:ttlock_flutter_example/screens/DrawerPage/kufuli_all_NavDrawer.dart';
import 'package:ttlock_flutter_example/screens/authentifications/login.dart';
import 'package:ttlock_flutter_example/services/user_service.dart';
import 'package:ttlock_flutter_example/urls/urls.dart';
import 'package:http/http.dart' as http;

import 'AccessBluetooth.dart';
import 'AccessCode.dart';


class ListAccess extends StatefulWidget {
  ListAccess({
        required this.idAdmin,})
      : super();
  final String idAdmin;

  @override
  _ListAccessState createState() =>
      _ListAccessState(idAdmin);
}

class _ListAccessState extends State<ListAccess> {
  String idAdmin = '';
  BuildContext? _context;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController controller;
  String name = "";
  _ListAccessState(String idAdmin) {
    super.initState();
    this.idAdmin = idAdmin;
  }





  String idadmin1 = '';
  String idadmin2 = '';
  String email1 = '';
  String email2 = '';
  String userName1 = '';
  String userName2 = '';
  String idEntreprise1='';
  String idEntreprise2='';

  Future<void> gett() async {
    idadmin2 = await getUserId();
    email2 = await getEmail();
    userName2 = await getUserName();
    idEntreprise2 = await getEnterprise();
    setState(() {
      idadmin1 = idadmin2;
      email1 = email2;
      userName1 = userName2;
      idEntreprise1 = idEntreprise2;
    });
  }

  @override
  void initState() {
    super.initState();
    gett();
  }


  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  DateTime? selectedStartDateTime,selectedEndDateTime ;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      title: Text('Access'),
    ),
    drawer: NavDrawer(),
    body: Container(
        padding: EdgeInsets.all(15.0),
        child: GridView.count(crossAxisCount: 2, children: <Widget>[
          Card(
              elevation: 10.0,
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccessBluetooth(idAdmin:idAdmin)));
                  },
                  splashColor: Colors.green,
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.bluetooth, size: 60.0, color: Colors.green),
                          Text("bluetooth access", style: new TextStyle(fontSize: 17.0))
                        ],
                      )))),
          Card(
              elevation: 10.0,
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    EasyLoading.show(status: 'please wait...');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccessCode(
                              idAdmin: idAdmin,
                            )));
                  },
                  splashColor: Colors.green,
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.list, size: 70.0, color: Colors.brown),
                          Text("Code Access",
                              style: new TextStyle(fontSize: 17.0))
                        ],
                      )))),
          Card(
              elevation: 10.0,
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    // EasyLoading.show(status: 'please wait...');
                    // clearcard();
                  },
                  splashColor: Colors.green,
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.card_membership,
                              size: 70.0, color: Colors.red),
                          Text("Card Access",
                            style: new TextStyle(fontSize: 17.0),textAlign: TextAlign.center,)
                        ],
                      )))),

        ])),
  );

  // Future<DateTime?> _selectedEndDatime(BuildContext context) => showDatePicker(
  //     context: context,
  //     firstDate: DateTime.now(),
  //     initialDate: DateTime.now().add(Duration(seconds: 1)),
  //     lastDate: DateTime(2200),
  //     helpText: "End Date",
  //     confirmText: "End Date",);

  Future<DateTime?> _selectedEndDatime(BuildContext context) => DatePicker.showDateTimePicker(
    context,
    showTitleActions: true,
    locale: LocaleType.fr,
    onChanged: (date) {
      print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
    },
    onConfirm: (date) {
      selectedEndDateTime = date;
    },
    currentTime: DateTime.now(),
  );

  // Future<DateTime?> _selectedStartDateTime(BuildContext context) =>
  //     showDatePicker(
  //       context: context,
  //       firstDate: DateTime.now(),
  //       initialDate: DateTime.now().add(Duration(seconds: 1)),
  //       lastDate: DateTime(2200),
  //       helpText: "Start Date",
  //       confirmText: "Save Start Date",
  //     );

  Future<DateTime?> _selectedStartDateTime(BuildContext context) =>  DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      locale: LocaleType.fr,
      onChanged: (date) {
        print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
      },
      onConfirm: (date) {
        selectedStartDateTime = date;
      },
      currentTime: DateTime.now()
  );

}

class MyMenu extends StatelessWidget {
  MyMenu({this.title, this.icon, this.warna, required this.newPage});

  final String? title;
  final IconData? icon;
  final MaterialColor? warna;
  final void newPage;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(8.0),
        child: InkWell(
            onTap: () {
              newPage;
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => newPage));
            },
            splashColor: Colors.green,
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(icon, size: 70.0, color: warna),
                    Text(title!, style: new TextStyle(fontSize: 17.0))
                  ],
                ))));
  }
}
