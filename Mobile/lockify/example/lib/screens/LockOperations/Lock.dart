import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:ttlock_flutter/ttlock.dart';
import 'package:ttlock_flutter_example/screens/DrawerPage/kufuli_all_NavDrawer.dart';
import 'package:ttlock_flutter_example/screens/HomeSelection/lockify_home.dart';
import 'package:ttlock_flutter_example/screens/authentifications/login.dart';
import 'package:ttlock_flutter_example/services/other_service.dart';
import 'package:ttlock_flutter_example/services/user_service.dart';
import 'package:ttlock_flutter_example/urls/urls.dart';
import 'package:ttlock_flutter_example/widgets/circle_Lock_widget.dart';

import 'LockOpps.dart';
import 'PassageMode/IndexPassageMode.dart';

class Lock extends StatefulWidget {
  Lock(
      {required this.lockName,
      required this.lockData,
      required this.lockMac,
      required this.idAdmin,
      required this.idSerrure,
      required this.percent})
      : super();
  final String lockName;
  final String lockData;
  final String lockMac;
  final String idAdmin;
  final int idSerrure;
  final int percent;

  @override
  _LockState createState() =>
      _LockState(lockMac, lockData, lockName, idAdmin, idSerrure, percent);
}

class _LockState extends State<Lock> {
  String lockData = '';
  String lockMac = '';
  String lockName = '';
  String idAdmin = '';
  int? idSerrure;
  int? percent;
  BuildContext? _context;
  _LockState(String lockMac, String lockData, String lockName, String idAdmin,
      int idSerrure, int percent) {
    super.initState();
    this.lockData = lockData;
    this.lockMac = lockMac;
    this.lockName = lockName;
    this.idAdmin = idAdmin;
    this.idSerrure = idSerrure;
    this.percent = percent;
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController controller;
  String name = '';
  String nameCostum = '';
  String lockname = '';

  Future<void> getPower() async {
    try {
      var url = Uri.parse(Urls.url_get_power);

      TTLock.getLockPower(lockData, (electricQuantity) async {
        final response = await http.post(url, body: {
          "lock_mac": lockMac,
          "power": electricQuantity.toString(),
          "id_user": idAdmin,
        }).onError((error, stackTrace) {
          EasyLoading.showInfo("internet error",
              duration: Duration(seconds: 4));
          return Response(error.toString(), 500);
        });
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data['status'] == 'success') {
            setState(() {
              percent = electricQuantity;
            });
            EasyLoading.showInfo("$electricQuantity %",
                duration: Duration(seconds: 4));
          }
          if (data['status'] == 'failed') {
            EasyLoading.showInfo("server error",
                duration: Duration(seconds: 4));
          }
        } else {
          EasyLoading.showInfo("verifiy internet",
              duration: Duration(seconds: 4));
        }
      }, (errorCode, errorMsg) {
        EasyLoading.showError(errorMsg);
      });
    } catch (e) {
      EasyLoading.showInfo("server error", duration: Duration(seconds: 4));
    }
  }

  static const _RESET_ACTION = 'kufuli_reset_lock';

  void initLock() {
    TTLock.resetLock(lockData, () async {
      print("Reset lock success");
      var url = Uri.parse(Urls.url_reset_lock);
      Map mapp = {
        "lock_data": lockData,
        "lock_mac": lockMac,
        "id_serrure": idSerrure,
        "id_user": idAdmin,
      };
      try {
        final response = await http
            .delete(
          url,
          body: mapp,
        )
            .onError((error, stackTrace) {
          EasyLoading.showInfo("verified internet",
              duration: Duration(seconds: 4));
          return Response(error.toString(), 500);
        });
        if (response.statusCode == 200) {
          print(response.body);
          var data = jsonDecode(response.body);
          print(data);
          String message = data['status'];
          if (message == 'reset_success') {
            print("-----success de reintialisation ");
            EasyLoading.dismiss();
            setState(() {
              EasyLoading.showSuccess(message);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomePageAll()),
                  (route) => false);
            });
          }
          if (message == 'empty_data') {
            EasyLoading.showError("server error");
            print("-------les donnees sont vides");
            EasyLoading.dismiss();
            setState(() {
              EasyLoading.showSuccess(message);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false);
            });
          }
          if (message == 'action_not_permitted') {
            EasyLoading.showError("server error");
            print("-------pas de permission");
            EasyLoading.dismiss();
            setState(() {
              EasyLoading.showSuccess(message);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false);
            });
          }
        } else {
          EasyLoading.showError("internet error");
        }
      } catch (e) {
        EasyLoading.showError("error", duration: Duration(seconds: 5));
      }
    }, (errorCode, errorMsg) {
      EasyLoading.showError(errorMsg);
    });
  }

  void getLockTime() {
    TTLock.getLockAutomaticLockingPeriodicTime(lockData,
        (currentTime, minTime, maxTime) {
      EasyLoading.showSuccess(
          "currentTime:$currentTime\n minTime:$minTime\n maxTime:$maxTime");
    }, (errorCode, errorMsg) {
      EasyLoading.showError(errorMsg);
    });
  }

  void setLockTime(int a) {
    TTLock.setLockAutomaticLockingPeriodicTime(a, lockData, () {
      EasyLoading.showSuccess("success");
    }, (errorCode, errorMsg) {
      EasyLoading.showError(errorMsg);
    });
  }

  String adminCode = '';

  setAdminCode(String code, int serrure) {
    TTLock.modifyAdminPasscode(code, lockData, () async {
      // _showSuccessAndDismiss("Success");
      try {
        var url = Uri.parse(Urls.url_set_admin_code);
        final response = await http.post(url, body: {
          "code": code,
          "serrure": serrure,
          "Kufuli_Action": "setCode",
        });
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          print(data);
          print("code Admin = ");
          print(data[0]['code_deverou']);
          setState(() {
            adminCode = data[0]['code_deverou'];
          });
          EasyLoading.showSuccess("success");
        } else {
          return null;
        }
      } catch (e) {
        EasyLoading.showError("verified internet");
        return null;
      }
      EasyLoading.dismiss();
      EasyLoading.showSuccess("verified internet");
    }, (errorCode, errorMsg) {
      // _showErrorAndDismiss(errorCode, errorMsg);
      EasyLoading.showError("verified internet");
    });
  }

  Future openDialogSetAdminCode() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text("set Admin code"),
            content: Form(
              key: _key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "code here",
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) => val!.isEmpty ? "required" : null,
                    onChanged: (val) => name = val,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: Text("cancel"),
              ),
              MaterialButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    Navigator.pop(
                      context,
                    );
                    EasyLoading.show(status: "loading");
                    setAdminCode(name, idSerrure!);
                  }
                },
                child: Text("ok"),
              ),
            ]),
      );

  // getLock(int serrure) async {
  //   try {
  //     var url = Uri.parse(Urls.url_set_admin_code);
  //     final response = await http.post(url, body: {
  //       "serrure": serrure,
  //       "Kufuli_Action": "getCode",
  //     });
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       EasyLoading.dismiss();
  //       print(data);
  //       print("code Admin = ");
  //       print(data[0]['code_deverou']);
  //       setState(() {
  //         adminCode = data[0]['code_deverou'];
  //       });
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     EasyLoading.showError("internet error");
  //     return null;
  //   }
  // }

  Future openDialogSetLockTime() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text("set lock time"),
            content: Form(
              key: _key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "time here",
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) => val!.isEmpty ? "required" : null,
                    onChanged: (val) => name = val,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: Text("cancel"),
              ),
              MaterialButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    Navigator.pop(
                      context,
                    );
                    EasyLoading.show(status: "loading");
                    setLockTime(int.parse(name));
                  }
                },
                child: Text("ok"),
              ),
            ]),
      );

  Future<void> changeName(String name) async {
    print("Change lockName success");
    var url = Uri.parse(Urls.url_rename_lock);
    try {
      final response = await http.post(url, body: {
        "lockname": name,
        "idserrure": idSerrure,
        "id_admin": idAdmin,
      }).onError((error, stackTrace) {
        EasyLoading.showInfo("verified internet",
            duration: Duration(seconds: 4));
        return Response(error.toString(), 500);
      });
      if (response.statusCode == 200) {
        print(response.body);
        var data = jsonDecode(response.body);
        print(data);
        if (data == 'success') {
          EasyLoading.showToast("success", duration: Duration(seconds: 4));
        }
        if (data == 'no_exist') {
          print("l'utilisateur n'existe pas");
          setState(() {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false);
            EasyLoading.showError("none");
          });
        }
        if (data == 'error') {
          EasyLoading.showInfo("error", duration: Duration(seconds: 4));
        }
        if (data == 'some_error') {
          EasyLoading.showInfo("server error", duration: Duration(seconds: 4));
        }
      } else {
        EasyLoading.showInfo("verified internet",
            duration: Duration(seconds: 4));
      }
    } catch (e) {}
  }

  Future openDialogChangeLockName() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text("change name"),
            content: Form(
              key: _key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "name here",
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) => val!.isEmpty ? "required" : null,
                    onChanged: (val) => lockname = val,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: Text("cancel"),
              ),
              MaterialButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    Navigator.pop(
                      context,
                    );
                    EasyLoading.show(status: "loading");
                    changeName(lockname);
                  }
                },
                child: Text("ok"),
              ),
            ]),
      );

  // Future<void> uploadCode(
  //     String entreprise, String code, int idSerrure, String action) async {
  //   try {
  //     var url = Uri.parse(Urls.url_dashboard1);
  //     final response = await http.post(url, body: {
  //       "id_entreprise": entreprise,
  //       "code": code,
  //       "serrure": idSerrure,
  //     });
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       EasyLoading.dismiss();
  //       print(data);
  //       setState(() {
  //         adminCode = data[0]['code_deverou'].toString();
  //         EasyLoading.showInfo(code, duration: Duration(seconds: 3));
  //       });
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     EasyLoading.showError("verified internet");
  //     return null;
  //   }
  // }

  void getAdminPass() {
    TTLock.getAdminPasscode(lockData, (adminPasscode) async {
      String set = "setCode";
      EasyLoading.showSuccess(adminPasscode,duration: Duration(seconds: 10));
      // uploadCode(idEntreprise, adminPasscode, idSerrure!, set);
    }, (errorCode, errorMsg) {
      EasyLoading.showError(errorMsg);
    });
  }

  @override
  void initState() {
    super.initState();
    gett();
    // getLock(idSerrure!);
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
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

  back() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LockOpp(
                  lockName: lockName,
                  lockData: lockData,
                  lockMac: lockMac,
                  idAdmin: idAdmin,
                  idSerrure: idSerrure!,
                  percent: percent!,
                )));
  }

  void dounlock() {
    OtherServices.unlock(lockData, lockMac, idAdmin, context);
  }

  locknow() {
    TTLock.controlLock(lockData, TTControlAction.lock,
        (lockTime, electricQuantity, uniqueId) async {
      EasyLoading.showSuccess("success");
    }, (errorCode, errorMsg) {
      EasyLoading.showError(errorMsg);
    });
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () {
          return back();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text(lockName),
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
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  EasyLoading.show(status: "loading");
                  locknow();
                },
                icon: Icon(Icons.lock),
                color: Colors.green,
              ),
              IconButton(
                onPressed: () {

                },
                icon: Icon(Icons.home),
                color: Colors.black,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    color: Colors.white,
                    child: GridView.count(
                      padding: EdgeInsets.all(21.0),
                      primary: false,
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      children: <Widget>[
                        LockCircleCardWidget(
                          iconImg: "assets/Battery.png",
                          nameTxt: "get power",
                          delayStart: Duration(milliseconds: 250),
                          onPressed: () {
                            EasyLoading.show(status: "loading");
                            getPower();
                          },
                        ),
                        LockCircleCardWidget(
                          iconImg: "assets/Initlock.png",
                          nameTxt: "reset lock",
                          delayStart: Duration(milliseconds: 250),
                          onPressed: () {
                            // EasyLoading.show(status: "loading");
                            int timestamp = DateTime.now().millisecondsSinceEpoch;
                            TTLock.setLockTime(timestamp, lockData, () {
                              print('$timestamp');
                            }, (errorCode, errorMsg) {
                              print('setLockTime not possible');
                            });
                            TTLock.resetLock(lockData, () {
                              print("Reset lock success");
                              // Navigator.popAndPushNamed(context, '/');
                            }, (errorCode, errorMsg) {
                              // _showErrorAndDismiss(errorCode, errorMsg);
                            });
                            // initLock();
                          },
                        ),
                        LockCircleCardWidget(
                          iconImg: "assets/Keyboard.png",
                          nameTxt: "get admin code",
                          delayStart: Duration(milliseconds: 250),
                          onPressed: () {
                            EasyLoading.show(status: "loading");
                            getAdminPass();
                          },
                        ),
                        LockCircleCardWidget(
                          iconImg: "assets/Get_lock_Time.png",
                          nameTxt: "get lock tim ",
                          delayStart: Duration(milliseconds: 350),
                          onPressed: () {
                            EasyLoading.show(status: "loading");
                            getLockTime();
                          },
                        ),
                        LockCircleCardWidget(
                          iconImg: "assets/Set_Lock_Time.png",
                          nameTxt: "set lock time",
                          delayStart: Duration(milliseconds: 350),
                          onPressed: () {
                            // EasyLoading.show(status: 'please wait...');
                            openDialogSetLockTime();
                          },
                        ),
                        LockCircleCardWidget(
                          iconImg: "assets/Keyboard.png",
                          nameTxt: "lock reccord",
                          delayStart: Duration(milliseconds: 350),
                          onPressed: () {
                            EasyLoading.show(status: "loading");
                            TTLock.getLockOperateRecord(
                                TTOperateRecordType.latest, lockData,
                                (operateRecord) {
                              // List data = jsonDecode(operateRecord);
                              EasyLoading.showInfo("operateRecord",
                                  duration: Duration(seconds: 10));
                              print(
                                  "operation faites --------------------------------------------------------");
                              print(operateRecord);
                              // data.forEach((element) {
                              //   var a = element['recordType'];
                              //   var b = element['operateDate'];
                              //   print(a);
                              //   print(
                              //       "operate date ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
                              //   print(b);
                              // });
                            }, (errorCode, errorMsg) {
                              EasyLoading.showError(errorMsg);
                            });
                          },
                        ),
                        LockCircleCardWidget(
                          iconImg: "assets/Switch.png",
                          nameTxt: "change name",
                          delayStart: Duration(milliseconds: 350),
                          onPressed: () {
                            openDialogChangeLockName();
                          },
                        ),
                        LockCircleCardWidget(
                          iconImg: "assets/transcation.png",
                          nameTxt: "passage mode",
                          delayStart: Duration(milliseconds: 350),
                          onPressed: () {
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => IndexPassageMode(
                            //               lockName: lockName,
                            //               lockData: lockData,
                            //               lockMac: lockMac,
                            //               idAdmin: idAdmin,
                            //               idserrure: idSerrure,
                            //               percent: percent,
                            //             )));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class MyMenu extends StatelessWidget {
  MyMenu({this.title, this.icon, this.warna, required this.newPage});

  final String? title;
  final IconData? icon;
  final MaterialColor? warna;
  final void newPage;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(8.0),
        child: InkWell(
            onTap: () {
              newPage;
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => newPage));
            },
            splashColor: Colors.green,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, size: 70.0, color: warna),
                Text(title!, style: new TextStyle(fontSize: 17.0))
              ],
            ))));
  }
}
