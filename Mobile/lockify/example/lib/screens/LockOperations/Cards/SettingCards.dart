import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter/ttlock.dart';
import 'package:ttlock_flutter_example/services/user_service.dart';
import 'package:ttlock_flutter_example/urls/urls.dart';

import 'IndexCards.dart';

class SettingCards extends StatefulWidget {
  SettingCards({
    required this.lockName,
    required this.lockData,
    required this.idAdmin,
    required this.idserrure,
    required this.lockMac,
    required this.percent,
  }) : super();
  final String lockName;
  final String lockData;
  final String idAdmin;
  final int idserrure;
  final String lockMac;
  final int percent;

  @override
  _SettingCardsState createState() => _SettingCardsState(
      lockName, lockData, idAdmin, idserrure, lockMac, percent);
}

class _SettingCardsState extends State<SettingCards> {
  String lockName = '';
  String lockData = '';
  String idAdmin = '';
  int? idserrure;
  String lockMac = '';
  int? percent;
  BuildContext? _context;

  _SettingCardsState(String lockName, String lockData, String idAdmin,
      int idserrure, String lockMac, int percent) {
    super.initState();
    this.lockName = lockName;
    this.lockData = lockData;
    this.idAdmin = idAdmin;
    this.idserrure = idserrure;
    this.lockMac = lockMac;
    this.percent = percent;
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController controller;
  static const _MODIFIED_ACTION = 'kufuli_modified_costum_code_lock';

  void modifyCostumCode(
      String name, int oldCode, int newCode, int startDate, int endDate) {
    String newc = newCode.toString();
    String old = oldCode.toString();
    TTLock.supportFunction(TTLockFuction.managePasscode, lockData, (isSupport) {
      // not support
      if (!isSupport) {
        EasyLoading.showError('not supported');
        return;
      }
      TTLock.modifyPasscode(old, newc, startDate, endDate, lockData, () async {
        EasyLoading.show(status: 'loading');
        var url = Uri.parse(Urls.url_save_lock);
        String st = startDate.toString();
        String en = endDate.toString();
        final response = await http.post(url, body: {
          "name": name,
          "oldCode": old,
          "costumCode": newc,
          "idAdmin": idAdmin,
          "idserrure": idserrure,
          "startDate": st,
          "endDate": en,
        });
        var data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          if (data['success'] == true) {
            EasyLoading.dismiss();
            setState(() {
              EasyLoading.showSuccess("");
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             ListCostumCode(
              //               idSerrure: idserrure,
              //               lockData: lockData,
              //               idAdmin: idAdmin,
              //               lockName: lockName,
              //               lockMac: lockMac,
              //               percent: percent,
              //             )));
            });
          }
        }
      }, (errorCode, errorMsg) {
        EasyLoading.dismiss();
        EasyLoading.showError(errorMsg);
      });
    });
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    gett();
  }

  String idadmin1 = '';
  String idadmin2 = '';
  String email1 = '';
  String email2 = '';
  String userName1 = '';
  String userName2 = '';
  String idEntreprise1 = '';
  String idEntreprise2 = '';

  Future<void> gett() async {
    idadmin2 = await getUserId();
    email2 = await getEmail();
    userName2 = await getUserName();
    idEntreprise2 = await getEnterprise();
    setState(() {
      idadmin1 = idadmin2;
      email1 = email2;
      userName1 = userName2;
      idEntreprise1 = idEntreprise2;
    });
  }

  TextEditingController _controller = new TextEditingController();
  TextEditingController _controller1 = new TextEditingController();
  int endDates = 0;
  int startDates = 0;

  Future<bool> back() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => IndexCards(
              lockName: lockName,
              lockData: lockData,
              lockMac: lockMac,
              idAdmin: idAdmin,
              idSerrure: idserrure!,
              percent: percent!),
        ));

    return false;
  }

  Future<void> resetAllCard() async {
    var url = Uri.parse(Urls.url_delete_all_card);
    try {
      final response = await http.post(url, body: {
        "lock_id": idserrure.toString(),
      });
      var data = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        print(data);
        if (data['status'] == 'deleted') {
          TTLock.clearAllCards(lockData, () {
            EasyLoading.showSuccess('success');
            Future.delayed(const Duration(seconds: 3));
            back();
          }, (errorCode, errorMsg) {
            EasyLoading.showError('error');
          });
        }
        if (data['status'] == 'error') {
          print("----------------------------delete error");
          EasyLoading.showInfo('error');
        }
      } else {
        EasyLoading.showInfo('server error');
      }
    } catch (e) {
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeee");
      print(e);
      EasyLoading.showInfo('something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () {
          return back();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  // deleteSpecificPasscode(int.parse(code));
                },
                icon: Icon(Icons.delete_forever),
                color: Colors.red,
              )
            ],
            leading: IconButton(
              onPressed: () {
                back();
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
                    SizedBox(height: 25),
                    Text(
                      'you will delete code',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 25),
                    MaterialButton(
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text('delete all costum code'),
                            content: Text(""),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  resetAllCard();
                                },
                                child: Text('validate'),
                              ),
                            ],
                          ),
                        );
                      },
                      textColor: Colors.white,
                      color: Colors.red,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'delete all costum code',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      height: 50,
                      minWidth: 600,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    MaterialButton(
                      onPressed: () {},
                      textColor: Colors.white,
                      color: Colors.redAccent,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'delete all user access',
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
        ),
      );
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
