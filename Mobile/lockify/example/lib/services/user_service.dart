import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Services {
  // var root = Uri.parse(Urls.url_manage_user_admin);

  // static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';

  // static Future<List<AdminModel>> getEmployees(
  //     String id, BuildContext context) async {
  //   // EasyLoading.show();
  //   try {
  //     var map = Map<String, dynamic>();
  //     map['action'] = _GET_ALL_ACTION;
  //     map['id_entreprise'] = id;
  //     var url = Uri.parse(Urls.url_manage_user_admin);
  //     final response = await http.post(url, body: map);
  //     var data = jsonDecode(response.body);
  //     print('getEmployees Response: $data');
  //     if (200 == response.statusCode) {
  //       EasyLoading.dismiss();
  //       List<AdminModel> list = parseResponse(response.body);
  //       return list;
  //     } else {
  //       return <AdminModel>[];
  //     }
  //   } catch (e) {
  //     return <AdminModel>[]; // return an empty list on exception/error
  //   }
  // }

  // static List<AdminModel> parseResponse(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<AdminModel>((json) => AdminModel.fromJson(json)).toList();
  // }

  // Method to add employee to the database...
  // static Future<String> addEmployee(String username, String email, String tel,
  //     String identreprise, BuildContext context) async {
  //   EasyLoading.show();
  //   try {
  //     var map = Map<String, dynamic>();
  //     map['action'] = _ADD_EMP_ACTION;
  //     map['user_name'] = username;
  //     map['email'] = email;
  //     map['tel'] = tel;
  //     map['id_entreprise'] = identreprise;
  //     map['url'] = Urls.racine;
  //     var url = Uri.parse(Urls.url_manage_user_admin);
  //     final response = await http.post(url, body: map);
  //     var data = jsonDecode(response.body);
  //     print('addAdmin Response: $data');
  //     if (200 == response.statusCode) {
  //       return data;
  //     } else {
  //       return "internet_error";
  //     }
  //   } catch (e) {
  //     return "error";
  //   }
  // }

  // Method to update an Employee in Database...
  // static Future<String> updateEmployee(String id_current_admin, String id,
  //     String email, String username, String tel, BuildContext context) async {
  //   print(email);
  //   print(username);
  //   print(tel);
  //   EasyLoading.show();
  //   try {
  //     var map = Map<String, dynamic>();
  //     map['action'] = _UPDATE_EMP_ACTION;
  //     map['id_current_admin'] = id_current_admin;
  //     map['id_admin'] = id;
  //     map['email'] = email;
  //     map['user_name'] = username;
  //     map['tel'] = tel;
  //     var url = Uri.parse(Urls.url_manage_user_admin);
  //     final response = await http.post(url, body: map);
  //     var data = jsonDecode(response.body);
  //     print('updateAdmin Response: $data');
  //     if (200 == response.statusCode) {
  //       return data;
  //     } else {
  //       return "internet_error";
  //     }
  //   } catch (e) {
  //     return "error";
  //   }
  // }

  // Method to Delete an Employee from Database...
//   static Future<String> deleteEmployee(String idEntreprise, String idAdmin,
//       String empId, BuildContext context) async {
//     EasyLoading.show();
//     try {
//       var map = Map<String, dynamic>();
//       map['action'] = _DELETE_EMP_ACTION;
//       map['idAdmin'] = idAdmin;
//       map['id_entreprise'] = idEntreprise;
//       map['id_admin'] = empId;
//       var url = Uri.parse(Urls.url_manage_user_admin);
//       final response = await http.post(url, body: map);
//       var data = jsonDecode(response.body);
//       print('deleteEmployee Response: $data');
//       if (200 == response.statusCode) {
//         return data;
//       } else {
//         return "internet_error";
//       }
//     } catch (e) {
//       return "error"; // returning just an "error" string to keep this simple...
//     }
//   }
}

// get token
Future<String> getRole() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('id_role') ?? '';
}

//get Phone
Future<String> getPhone() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('telephone') ?? '';
}

// get user id
Future<String> getUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('id') ?? '';
}

//get email
Future<String> getEmail() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('email') ?? '';
}

//get username
Future<String> getUserName() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('username') ?? '';
}

//get username
Future<String> getEnterprise() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('id_entreprise') ?? '';
}

// logout
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.remove('id_entreprise');
  await pref.remove('user_name');
  await pref.remove('email');
  return await pref.remove('id_admin');
}

// Get base64 encoded image
String? getStringImage(File? file) {
  if (file == null) return null;
  return base64Encode(file.readAsBytesSync());
}
