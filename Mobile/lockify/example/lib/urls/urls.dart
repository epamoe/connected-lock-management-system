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

  //our service
  static const String authURL = 'https://authlockify.herokuapp.com';
  static const String baseURL = 'https://lockify.herokuapp.com';
  // static const String baseURL = 'http://192.168.0.100';
  //all other url
  static const String loginURL = authURL + '/login_lockify';
  static const String registerURL = authURL + '/register_lockify';
  static const String logoutURL = authURL + '/logout';
  static const String url_save_lock = baseURL + '/add_lock';
  static const String url_rename_lock = baseURL + '/rename_lock';
  static const String url_get_all_lock = baseURL + '/lock';
  static const String url_get_power = baseURL + '/set_power';
  static const String url_reset_lock = baseURL + '/reset_lock';
  static const String url_set_admin_code = baseURL + '/set_admin_code';
  //code
  static const String url_get_all_code = baseURL + '/view_all_code';
  static const String url_add_code = baseURL + '/create_code';
  static const String url_add_share_code = baseURL + '/create_share_code';
  static const String url_get_all_share_code = baseURL + '/view_all_share_code';
  static const String url_delete_all_costume_code =
      baseURL + '/delete_all_code';
  static const String url_delete_specifique_code =
      baseURL + '/delete_specifique_code';
  static const String url_get_access_code_access =
      baseURL + '/get_all_code_access_person';
  static const String url_set_password_to_lock =
      baseURL + '/update_password_to_lock';

  //Card
  static const String url_get_all_card = baseURL + '/view_all_card';
  static const String url_add_card = baseURL + '/create_card';
  static const String url_delete_all_card = baseURL + '/delete_all_card';
  static const String url_delete_specifique_card =
      baseURL + '/delete_specique_card';
  static const String url_add_share_card = baseURL + '/create_share_card';
  static const String url_get_all_share_card = baseURL + '/view_share_card';

  //bluetooth
  static const String url_get_all_bluetooch =
      baseURL + '/view_all_bluetooch_access';
  static const String url_create_bluetooth_access =
      baseURL + '/create_bluetooth';
  static const String url_remove_bluetooth_access =
      baseURL + '/remove_bluettoth_access';
  static const String url_edit_bluetooth_access =
      baseURL + '/edit_bluetooch_acces';
  static const String url_delete_all_bluetooch_access =
      baseURL + '/delete_all_bluetooth_access';
  static const String url_get_access_bluetooch_access =
      baseURL + '/get_all_bluetooth_access_person';

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
