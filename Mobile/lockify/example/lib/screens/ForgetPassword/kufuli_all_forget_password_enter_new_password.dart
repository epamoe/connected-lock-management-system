import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/screens/ErrorsPage/kufuli_all_error_server.dart';
import 'package:ttlock_flutter_example/urls/urls.dart';

class EnterNewPassword extends StatefulWidget {
  EnterNewPassword({required this.email});
  final String email;
  @override
  _EnterNewPasswordState createState() => _EnterNewPasswordState(email);
}

class _EnterNewPasswordState extends State<EnterNewPassword> {
  _EnterNewPasswordState(String email) {
    this.email = email;
  }
  String email = '';

  Timer? _timer;
  bool _isObscure = true;
  String confirmPassword = "";
  String password = "";

  String erro = ""; //pour afficher les messages d'erreur
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  //fonction de login avec la BD
  void login(String email, String pass, Widget newPage) async {
    //importation de l'urls de connexion a la bd pour le login
    var url = Uri.parse(Urls.url_login);
    //on chamge l'etat du loading
    setState(() {
      erro = "";
      //chaque fois qu'on vas clicket sur login on vas initialiser et on passe le loading a true
      _loading = true;
    });
    EasyLoading.show(status: 'loading...');

    //cette fonction permet de faire un post dans la BD
    final response = await http.post(url, body: {
      //"variable du server dans le post[]":variable declare dans la fonction login()
      "email": email,
      "password": pass
    });

    if (response.statusCode == 200) {
      //importer la library dart.convert
      var data = jsonDecode(response.body);
      print(data);
      bool success = data['success'];
      String message = data['message'];
      String id_admin = data['id_admin'];
      String email = data['email'];
      String user_name = data['user_name'];
      String id_entreprise = data['id_entreprise'];

      if (data["success"] == true) {
        //le setState permet de Modifier les elements
        setState(() {
          EasyLoading.showSuccess(message);
          _loading = false;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => newPage));
        });
        //   EasyLoading.showSuccess(message);
        EasyLoading.dismiss();
      } else {
        setState(() {
          // EasyLoading.removeAllCallbacks();
          EasyLoading.showError(message);
          print(message);
          print(success);
          // erro = result[0];
          _loading = false;
          EasyLoading.dismiss();
        });
      }
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ServerErrorPage()));
    }
    EasyLoading.dismiss();
  }

  //creation d'une cle pour verifier que le formulaire est bien rempli
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Reset Pssword',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 30.0),
          child: Form(
            key: _key, //liaison de la cle avec le formulaire
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Set New Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
                Text(
                  'Welcome Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(height: 5),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  obscureText: _isObscure,
                  validator: (val) => val!.length < 6
                      ? 'you should enter 6 or more charactar'
                      : null,
                  onChanged: (val) => password = val,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  obscureText: _isObscure,
                  validator: (val) => val!.length < 6
                      ? 'you should enter 6 or more charactar'
                      : null,
                  onChanged: (val) => confirmPassword = val,
                ),
                SizedBox(height: 10.0),
                MaterialButton(
                  onPressed: () {
                    if (_key.currentState!.validate() &&
                        password == confirmPassword) {
                      // login(email, password, HomePageAll());
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePageAll()));
                    }
                  },
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Login",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  height: 50,
                  minWidth: 600,
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildingButton extends StatelessWidget {
  final Image iconImage;
  final String textButton;
  BuildingButton({required this.iconImage, required this.textButton});
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height * 0.06,
      width: mediaQuery.width * 0.36,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconImage,
          SizedBox(
            width: 5,
          ),
          Text(textButton),
        ],
      ),
    );
  }
}
