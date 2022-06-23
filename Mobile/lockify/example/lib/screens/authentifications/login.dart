import 'dart:async';
import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttlock_flutter_example/screens/ForgetPassword/kufuli_all_forget_password_enter_email.dart';
import 'package:ttlock_flutter_example/screens/HomeSelection/lockify_home.dart';
import 'package:ttlock_flutter_example/urls/myColors.dart';
import 'package:ttlock_flutter_example/urls/urls.dart';
import 'package:ttlock_flutter_example/widgets/validator.dart';

import 'register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Timer? _timer;
  bool _isObscure = true;
  String email = "";
  String password = "";

  @override
  void initState() {
    super.initState();
  }

  //fonction de login avec la BD
  /// It takes in an email, a password and a widget as parameters. It then sends a post request to the
  /// server with the email and password as the body. If the response is 200, it decodes the response and
  /// checks if the status is success. If it is, it stores the data in the shared preferences and
  /// navigates to the new page. If the status is empty, it shows an error. If the status is error, it
  /// shows an error. If the status is invalid credential, it shows an error. If the response is not 200,
  /// it shows an error
  ///
  /// Args:
  ///   email (String): email,
  ///   pass (String): the password
  ///   newPage (Widget): the page you want to navigate to after a successful login
  void login_(String email, String pass, Widget newPage) async {
    var url = Uri.parse(Urls.loginURL);

    Map map = {"email": email, "password": pass};
    EasyLoading.show(status: 'loading...');
    try {
      final response = await http.post(
          url,
          headers: {"Accept": "Application/JSON"},
          body: map);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        EasyLoading.dismiss();

        if (data["status"] == "success") {
          List<dynamic> result = data["data"];
          print(data);
          int id = data["myid"];
          String username = result[0]["username"];
          String email = result[0]['email'];
          String telephone = result[0]['first_name'];
          int role = result[0]['is_superuser'];
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setString('id', id.toString());
          await pref.setString('username', username);
          await pref.setString('email', email);
          await pref.setString('telephone', telephone);
          await pref.setString('id_role', role.toString());
          print(result);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => newPage),
              (route) => false);
        }
        if (data["status"] == "empty") {
          EasyLoading.showError(data[""]);
        }
        if (data["status"] == "error") {
          EasyLoading.showError("internet error server");
        }
        if (data["status"] == "invalid credential") {
          EasyLoading.showError("invalid credential");
        }
      } else {
        EasyLoading.showError("internet error network");
      }
    } catch (e) {
      print(e);
      EasyLoading.showError("request error");
    }
    EasyLoading.dismiss();
  }

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Login',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: Image.asset(
          'lib/resources/L.png',
          height: 100,
          width: 100,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 40.0),
          child: Form(
            key: _key, //liaison de la cle avec le formulaire
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 50),
                Text(
                  'Welcome Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(height: 50),
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
                  validator: (val) => val!.length < 5
                      ? 'you should enter 6 or more charactar'
                      : null,
                  onChanged: (val) => password = val,
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                        //n'a pas de bordure
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ForgetPasswordEnterEmailPage()));
                        }, //navigation vers la page forget password
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(color: Colors.redAccent),
                        ))
                  ],
                ),
                SizedBox(height: 10.0),
                MaterialButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      login_(email, password, HomePageAll());
                    }
                  },
                  textColor: MyColors.mywhite,
                  color: MyColors.mygreen,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, //centre les elements en fonction du scafold
                  children: [
                    Text(
                      'New to this app?',
                    ),
                    SizedBox(width: 5.0),
                    FlatButton(
                        //n'a pas de bordure
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        }, //appel du widget visible pour changer l'etat
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.redAccent),
                        ))
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  BuildingButton(
                    iconImage: Image(
                      height: 20,
                      width: 20,
                      image: AssetImage('lib/resources/facebook.png'),
                    ),
                    textButton: 'Facebook',
                  ),
                  SizedBox(width: 10.0),
                  BuildingButton(
                    iconImage: Image(
                      height: 20,
                      width: 20,
                      image: AssetImage('lib/resources/google.jfif'),
                    ),
                    textButton: 'Google',
                  )
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// This class is a stateless widget that takes in an image and a string and returns a container with a
/// row inside of it that has the image and the string
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
