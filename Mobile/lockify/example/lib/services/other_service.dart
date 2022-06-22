import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ttlock_flutter/ttlock.dart';
import 'package:ttlock_flutter_example/models/lockModel.dart';

class OtherServices {
  // static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';

  // static Future<String> getVersion(String id, BuildContext context) async {
  //   // EasyLoading.show();
  //   try {
  //     var map = Map<String, dynamic>();
  //     map['action'] = _GET_ALL_ACTION;
  //     map['id_version'] = id;
  //     var url = Uri.parse(Urls.url_version);
  //     final response = await http.post(url, body: map);
  //     print('get Response: ${response.body}');
  //     if (200 == response.statusCode) {
  //       EasyLoading.dismiss();
  //       return response.body;
  //     } else {
  //       EasyLoading.dismiss();
  //       EasyLoading.showError(AppLocalizations.of(context)!.verified_internet);
  //       return "error";
  //     }
  //   } catch (e) {
  //     EasyLoading.dismiss();
  //     EasyLoading.showError(AppLocalizations.of(context)!.server_error);
  //     return "error"; // return an empty list on exception/error
  //   }
  // }

  static void mytimestime(String lockData) {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    TTLock.setLockTime(timestamp, lockData, () {
      print('$timestamp');
    }, (errorCode, errorMsg) {
      print('errorCode');
    });
  }

  static void unlock(
      String lockData, String lockMac, String idAdmin, BuildContext context) {
    // TTLock.controlLock(lockData, TTControlAction.unlock,
    //     (lockTime, electricQuantity, uniqueId) async {
    //   var url = Uri.parse(Urls.url_trafic_admin);
    //   try {
    //     final response = await http.post(url, body: {
    //       "lockMac": lockMac,
    //       "id_admin": idAdmin,
    //       "power": electricQuantity.toString(),
    //     });
    //
    //     if (response.statusCode == 200) {
    //       print(response.body);
    //       var data = jsonDecode(response.body);
    //       print(data);
    //       bool success = data['success'];
    //       String message = data['message'];
    //
    //       if (data['success'] == true) {
    //         EasyLoading.showSuccess("unlock");
    //         print(message);
    //         print(success);
    //         EasyLoading.dismiss();
    //       } else {
    //         EasyLoading.showSuccess(
    //             "success");
    //       }
    //     } else {
    //       EasyLoading.showInfo("Error", duration: Duration(seconds: 5));
    //     }
    //   } catch (e) {
    //     EasyLoading.showInfo("save",
    //         duration: Duration(seconds: 5));
    //   }
    // }, (errorCode, errorMsg) {
    //   EasyLoading.showError(errorMsg);
    // });
    //
    // //get log
    // TTLock.getLockOperateRecord(TTOperateRecordType.latest, lockData,(operateRecord) {
    //   print('$operateRecord');
    // }, (errorCode, errorMsg) {
    //   print('errorCode');
    // });
    // //set time
    // int timestamp = DateTime.now().millisecondsSinceEpoch;
    // TTLock.setLockTime(timestamp, lockData, () {
    //   print('$timestamp');
    // }, (errorCode, errorMsg) {
    //   print('errorCode');
    // });
  }

  static List<LockModel> parseResponsegetlock(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<LockModel>((json) => LockModel.fromJson(json)).toList();
  }

  // Method to Delete an Employee from Database...
  // static Future<String> deleteEmployee(
  //     String empId, BuildContext context) async {
  //   EasyLoading.show();
  //   try {
  //     var map = Map<String, dynamic>();
  //     map['action'] = _DELETE_EMP_ACTION;
  //     map['id_user'] = empId;
  //     var url = Uri.parse(Urls.url_manage_user_costumer);
  //     final response = await http.post(url, body: map);
  //     print('deleteEmployee Response: ${response.body}');
  //     if (200 == response.statusCode) {
  //       EasyLoading.dismiss();
  //       return response.body;
  //     } else {
  //       EasyLoading.dismiss();
  //       EasyLoading.showError(AppLocalizations.of(context)!.verified_internet);
  //       return "error";
  //     }
  //   } catch (e) {
  //     EasyLoading.dismiss();
  //     EasyLoading.showError(AppLocalizations.of(context)!.server_error);
  //     return "error"; // returning just an "error" string to keep this simple...
  //   }
  // }

  Widget mTile(String title, String data, BuildContext context) {
    var margin = MediaQuery.of(context).size.width / 25;
    return Container(
      margin: EdgeInsets.only(bottom: margin),
      child: Material(
        elevation: 15,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 25),
          height: MediaQuery.of(context).size.height / 12,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                  child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              SizedBox(height: 10),
              Expanded(child: Text(data))
            ],
          ),
        ),
      ),
    );
  }
}
