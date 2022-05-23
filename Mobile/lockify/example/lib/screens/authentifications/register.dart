import 'dart:async';
import 'package:ttlock_flutter_example/urls/urls.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ttlock_flutter_example/urls/myColors.dart';

import 'login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Timer? _timer;
  bool _isObscure = true;
  String username = "";
  String phone = "";
  String country = "";
  String email = "";
  String password = "";
  String confirmpassword = "";
  bool isChecked = false;
  final _key = GlobalKey<FormState>();

void register(String name,String phone,String email, String pass) async {
    var url = Uri.parse(Urls.registerURL);
  
    Map map = {
      "username": name,
      "email": email,
      "tel": phone,
      "password": pass
    };
    EasyLoading.show(status: 'loading...');
    try{
      final response =
        await http.post(url,
        headers: {"Accept": "Application/JSON"},
        body: map);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        EasyLoading.dismiss();
        print(data);

        if (data["status"] == "success") {
          EasyLoading.showSuccess("success");
          Future.delayed(const Duration(seconds: 2));
           
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
        }if(data["status"] == "empty"){
          EasyLoading.showError(data["please all is required"]);
        }if(data["status"]=="error"){
          EasyLoading.showError("Internet error");
        }if(data["status"] == "exist"){
          EasyLoading.showError("user already exist");
        }
      } else {
        EasyLoading.showError("response error");
      }
    }catch(e){
      EasyLoading.showError("internet error");
    }
     EasyLoading.dismiss();
  }

  @override
  void initState() {
     EasyLoading.dismiss();
    super.initState();
  }

  @override
  void dispose() {
     EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Sign Up',
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
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 5),
                TextFormField(
                  keyboardType: TextInputType.name,
                  autofillHints: [AutofillHints.name],
                  decoration: InputDecoration(
                      labelText: 'User name', border: OutlineInputBorder()),
                  //recuperations des valeurs entre par l'utilisateur
                  validator: (val) => val!.isEmpty ? 'Enter user name' : null,
                  onChanged: (val) => username = val,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  autofillHints: [AutofillHints.telephoneNumber],
                  decoration: InputDecoration(
                      labelText: 'Phone Number', border: OutlineInputBorder()),
                  //recuperations des valeurs entre par l'utilisateur
                  validator: (val) =>
                      val!.isEmpty ? 'Enter your phone number ' : null,
                  onChanged: (val) => phone = val,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                  decoration: InputDecoration(
                      labelText: 'Email', border: OutlineInputBorder()),
                  //recuperations des valeurs entre par l'utilisateur
                  validator: (val) => val!.isEmpty ? 'Enter your Email' : null,
                  onChanged: (val) => email = val,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
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
                  onChanged: (val) => password = val,
                  validator: (val) =>
                      val!.isEmpty ? 'you should enter password' : null,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Retype Password',
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
                  onChanged: (val) => confirmpassword = val,
                  validator: (val) =>
                      val!.isEmpty ? 'you should enter password' : null,
                ),
                SizedBox(height: 10.0),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  FittedBox(
                    child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              // fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.0, horizontal: 0.0),
                              child: InkWell(
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionsPage()));
                                },
                                child: Text(
                                  "En cliquant, vous accepter \nles conditions generales \nd'utilisation et la politique \nde confidentialite de lockify",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 12,
                                      shadows: [
                                        Shadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 5,
                                          offset: Offset(1, 1),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ]),
                SizedBox(height: 10.0),
                InkWell(
                  onTap: () {
                     if (_key.currentState!.validate()) {
                       if(isChecked == false){
                          EasyLoading.showError("you should accept the terme");
                       }else{
                         if(password != confirmpassword){

                         }else{
                           register(username,phone,email,password);
                         }
                           
                       }
                     
                    }
                  },
                  child: BuildingButton(
                    iconImage: Image(
                      height: 60,
                      width: 20,
                      image: AssetImage('lib/resources/1024.png'),
                    ),
                    textButton: 'Register',
                    color: MyColors.mygreen,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, //centre les elements en fonction du scafold
                  children: [
                    Text(
                      'Already have Account?',
                    ),
                    SizedBox(width: 5.0),
                    FlatButton(
                        //n'a pas de bordure
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        }, //appel du widget visible pour changer l'etat
                        child: Text(
                          "Sign in",
                          style: TextStyle(color: Colors.redAccent),
                        ))
                  ],
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
  final Color color;
  BuildingButton(
      {required this.iconImage, required this.textButton, required this.color});
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height * 0.06,
      width: mediaQuery.width * 0.36,
      decoration: BoxDecoration(
          color: color,
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
