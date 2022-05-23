import 'package:flutter/material.dart';

class Urls {
  static const String server_urls = 'http://www.kufuli-developper.com/mobile';

  static const String url_login = server_urls + '/login_mobile_admin.php';
  static const String url_verified_admin =
      server_urls + '/verified_email_admin.php';
  static const String url_send_email_code_admin =
      server_urls + '/send_email_code_admin.php';
  static const String url_verified_otp_code_admin =
      server_urls + '/verified_otp_code_admin.php';
  static const String url_register = server_urls + '/login.php';

  static const String images = server_urls + '/images';

  static const String baseURL = 'https://lockify.herokuapp.com';
  // static const String baseURL = 'http://192.168.0.100';
  static const String loginURL = baseURL + '/login_lockify';
  static const String registerURL = baseURL + '/register_lockify';
  static const String logoutURL = baseURL + '/logout';
  static const String userURL = baseURL + '/user';
  static const String postsURL = baseURL + '/posts';
  static const String commentsURL = baseURL + '/comments';

// ----- Errors -----
  static const String serverError = 'Server error';
  static const String unauthorized = 'Unauthorized';
  static const String somethingWentWrong = 'Something went wrong, try again!';

  InputDecoration kInputDecoration(String label) {
    return InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.all(10),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black)));
  }

  // button

  TextButton kTextButton(String label, Function onPressed) {
    return TextButton(
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.blue),
          padding: MaterialStateProperty.resolveWith(
              (states) => EdgeInsets.symmetric(vertical: 10))),
      onPressed: () => onPressed(),
    );
  }

// loginRegisterHint
  Row kLoginRegisterHint(String text, String label, Function onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        GestureDetector(
            child: Text(label, style: TextStyle(color: Colors.blue)),
            onTap: () => onTap())
      ],
    );
  }

  Expanded kLikeAndComment(
      int value, IconData icon, Color color, Function onTap) {
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: () => onTap(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 16,
                  color: color,
                ),
                SizedBox(width: 4),
                Text('$value')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
