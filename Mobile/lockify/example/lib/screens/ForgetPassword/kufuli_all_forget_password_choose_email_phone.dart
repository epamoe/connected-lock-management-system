import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/urls/urls.dart';

import 'otp/kufuli_all_forget_password_enter_otp.dart';

class HomePageChoosePhoneEmail extends StatefulWidget {
  HomePageChoosePhoneEmail({required this.email, required this.tel});

  final String email;
  final String tel;
  @override
  _HomePageChoosePhoneEmailState createState() =>
      _HomePageChoosePhoneEmailState(email, tel);
}

class _HomePageChoosePhoneEmailState extends State<HomePageChoosePhoneEmail> {
  String email = '';
  String tel = '';
  _HomePageChoosePhoneEmailState(String email, String tel) {
    super.initState();
    this.email = email;
    this.tel = tel;
  }
  BuildContext? _context;

  void sendVerification() async {
    print(email);
    //importation de l'urls de connexion a la bd pour le login
    var url = Uri.parse(Urls.url_send_email_code_admin);
    EasyLoading.show(status: 'loading...');

    //cette fonction permet de faire un post dans la BD
    final response = await http.post(url, body: {
      //"variable du server dans le post[]":variable declare dans la fonction login()
      "email": email,
    });

    if (response.statusCode == 200) {
      //importer la library dart.convert
      var data = jsonDecode(response.body);
      print(data);
      bool success = data['success'];
      String message = data['message'];

      if (data["success"] == true) {
        //le setState permet de Modifier les elements
        EasyLoading.showSuccess(message);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OtpScreen(email: email)));
        print(message);
        print(success);

        EasyLoading.dismiss();
      } else {
        EasyLoading.showError(message);
        print(message);
        print(success);
        EasyLoading.dismiss();
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Select One '),
        ),
        body: Container(
            padding: EdgeInsets.all(70.0),
            child: GridView.count(crossAxisCount: 1, children: <Widget>[
              MyMenu(
                // a configurer
                title: tel,
                icon: Icons.phone_android_outlined,
                warna: Colors.brown,
              ),
              // SizedBox(height: 20,),
              Card(
                  margin: EdgeInsets.all(10.0),
                  elevation: 10,
                  child: InkWell(
                      onTap: () {
                        sendVerification();
                      },
                      splashColor: Colors.green,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.email_outlined,
                              size: 70.0, color: Colors.blue),
                          Text(email, style: new TextStyle(fontSize: 12.0))
                        ],
                      )))),
            ])),
      );
}

class MyMenu extends StatelessWidget {
  MyMenu({this.title, this.icon, this.warna});

  final String? title;
  final IconData? icon;
  final MaterialColor? warna;
  // HomePageChoosePhoneEmail? newPage;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10.0),
        elevation: 10,
        child: InkWell(
            onTap: () {
              // HomePageChoosePhoneEmail.sendVerification();
              // newPage!.sendVerification();
              //Navigator.push(context, MaterialPageRoute(builder: (context) => newPage));
            },
            splashColor: Colors.green,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, size: 70.0, color: warna),
                Text(title!, style: new TextStyle(fontSize: 12.0))
              ],
            ))));
  }
}
