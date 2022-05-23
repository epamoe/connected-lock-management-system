import 'package:/flutter/material.dart';

class LoginForm extends StatefulWidget{
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State{
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        buildInputForm('Email'),
      ]
    );
  }

  Padding buildInputForm(String label){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      // child: TextFormField(
      //   decoration: InputDecoration(
      //     labelText: label,
      //     border: OutlineInputBorder(),
      //     suffixIcon: IconButton(
      //         onPressed: (){
      //           setState(() {
      //
      //           });
      //           _isObscure = !_isObscure;
      //         },
      //         icon: Icon(Icons.visibility_off)
      //     ),
      //   ),
      //
      //   obscureText: true,
      //   onChanged: (val) => password = val,
      //   validator: (val) => val!.isEmpty ? 'you should enter password': null,
      // ),
    );
  }
}
