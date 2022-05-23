import 'dart:async';
import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/urls/urls.dart';
import 'package:ttlock_flutter_example/widgets/validator.dart';

import 'kufuli_all_forget_password_choose_email_phone.dart';

class ForgetPasswordEnterEmailPage extends StatefulWidget {
  @override
  _ForgetPasswordEnterEmailPageState createState() =>
      _ForgetPasswordEnterEmailPageState();
}

class _ForgetPasswordEnterEmailPageState
    extends State<ForgetPasswordEnterEmailPage> {
  Timer? _timer;
  bool _isObscure = true;
  String email = "";
  //creation d'une cle pour verifier que le formulaire est bien rempli
  final _key = GlobalKey<FormState>();

  void verifiedEmail(String email) async {
    //importation de l'urls de connexion a la bd pour le login
    var url = Uri.parse(Urls.url_verified_admin);
    EasyLoading.show(status: 'loading...');

    //cette fonction permet de faire un post dans la BD
    final response = await http.post(url, body: {
      //"variable du server dans le post[]":variable declare dans la fonction login()
      "email_admin": email,
    });

    if (response.statusCode == 200) {
      //importer la library dart.convert
      var data = jsonDecode(response.body);
      print(data);
      bool success = data['success'];
      String message = data['message'];
      String email = data['email'];
      String tel = data['phone'];

      if (data["success"] == true) {
        //le setState permet de Modifier les elements
        setState(() {
          EasyLoading.showSuccess(message);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePageChoosePhoneEmail(
                        tel: tel,
                        email: email,
                      )));
          print(message);
          print(success);
        });
        EasyLoading.dismiss();
      } else {
        setState(() {
          EasyLoading.showError(message);
          print(message);
          print(success);
        });
        EasyLoading.dismiss();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Recovery Password Kufuli',
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
                Image.asset(
                  'lib/resources/splashlogo.png',
                  height: 50,
                ),
                // SizedBox(height: 5),
                Text(
                  'Enter Your Email to verified it',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(height: 90),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,

                  //recuperations des valeurs entre par l'utilisateur
                  validator: (val) => !EmailValidator.validate(val!) &&
                          validateEmail(val) != null
                      ? 'Enter valid Email'
                      : null,
                  onChanged: (val) => email = val,
                ),
                SizedBox(height: 10.0),
                MaterialButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      verifiedEmail(email);
                    }
                  },
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Send",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  height: 50,
                  minWidth: 600,
                ),
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
