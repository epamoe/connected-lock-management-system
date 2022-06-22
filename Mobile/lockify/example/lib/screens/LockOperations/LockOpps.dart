import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ttlock_flutter/ttlock.dart';
import 'package:ttlock_flutter_example/screens/HomeSelection/lock_list.dart';
import 'package:ttlock_flutter_example/screens/authentifications/login.dart';
import 'package:ttlock_flutter_example/services/user_service.dart';
import 'package:ttlock_flutter_example/urls/urls.dart';
import 'package:ttlock_flutter_example/widgets/circle_card_widget.dart';

import 'Cards/IndexCards.dart';
import 'Codes/IndexCodes.dart';
import 'Lock/IndexLock.dart';
import 'Lock.dart';

class LockOpp extends StatefulWidget {
  LockOpp(
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
  _LockOppState createState() =>
      _LockOppState(lockName, lockData, lockMac, idAdmin, idSerrure, percent);
}

class _LockOppState extends State<LockOpp> {
  String lockName = '';
  String lockData = '';
  String lockMac = '';
  String idAdmin = '';
  int? idSerrure;
  int? percent;
  _LockOppState(String lockName, String lockData, String lockMac,
      String idAdmin, int idSerrure, int percent) {
    super.initState();
    this.lockName = lockName;
    this.lockData = lockData;
    this.lockMac = lockMac;
    this.idAdmin = idAdmin;
    this.idSerrure = idSerrure;
    this.percent = percent;
  }

  @override
  void initState() {
    super.initState();
    gett();
    // getAdminCode(idEntreprise, idSerrure);
  }

  String idadmin1 = '';
  String idadmin2 = '';
  String email1 = '';
  String email2 = '';
  String userName1 = '';
  String userName2 = '';
  String idEntreprise1 = '';
  String idEntreprise2 = '';

  String adminCode = '';
  String status = '';
  String img = "assets/images/SERRURE.png";
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController controller;
  String name = '';

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
            builder: (context) => LockList(
                  idAdmin: idAdmin,
                )));
  }

  void dounlock() {
    TTLock.controlLock(lockData, TTControlAction.unlock,
        (lockTime, electricQuantity, uniqueId) {
      EasyLoading.showSuccess("success");

      int timestamp = DateTime.now().millisecondsSinceEpoch;
      TTLock.setLockTime(timestamp, lockData, () {
        print('$timestamp');
      }, (errorCode, errorMsg) {
        print('setLockTime not possible');
      });
      // _showSuccessAndDismiss(
      //     "Unlock Success lockTime:$lockTime electricQuantity:$electricQuantity uniqueId:$uniqueId");
    }, (errorCode, errorMsg) {
      EasyLoading.showError(errorMsg);
      // _showErrorAndDismiss(errorCode, errorMsg);
    });
    // OtherServices.unlock(lockData, lockMac, idAdmin, context);
  }

  void dolock() {}

  // getAdminCode(String id, String serrure) async {
  //   try {
  //     var url = Uri.parse(Urls.url_dashboard1);
  //     final response = await http.post(url, body: {
  //       "id_entreprise": id,
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
  //     EasyLoading.showError(AppLocalizations.of(context)!.verified_internet);
  //     return null;
  //   }
  //   getStatusLock(serrure);
  // }

  // getStatusLock(String serrure) async {
  //   try {
  //     var url = Uri.parse(Urls.url_passage_mode);
  //     final response = await http.post(url, body: {
  //       "id_serrure": serrure,
  //       "action": "GET_STATUS",
  //     });
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       EasyLoading.dismiss();
  //       // print([0]['isable']);
  //       setState(() {
  //         status = data[0]['isable'];
  //       });
  //       print(status);
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     EasyLoading.showError(AppLocalizations.of(context)!.verified_internet);
  //     return null;
  //   }
  // }

  // setAdminCode(String code, String id, String serrure) {
  //   TTLock.modifyAdminPasscode(code, lockData, () async {
  //     // _showSuccessAndDismiss("Success");
  //     try {
  //       var url = Uri.parse(Urls.url_dashboard1);
  //       final response = await http.post(url, body: {
  //         "code": code,
  //         "id_entreprise": id,
  //         "serrure": serrure,
  //         "Kufuli_Action": "setCode",
  //       });
  //       if (response.statusCode == 200) {
  //         var data = jsonDecode(response.body);
  //         print(data);
  //         print("code Admin = ");
  //         print(data[0]['code_deverou']);
  //         setState(() {
  //           adminCode = data[0]['code_deverou'];
  //         });
  //         EasyLoading.showSuccess(AppLocalizations.of(context)!.success);
  //       } else {
  //         return null;
  //       }
  //     } catch (e) {
  //       EasyLoading.showError(AppLocalizations.of(context)!.verified_internet);
  //       return null;
  //     }
  //     EasyLoading.dismiss();
  //     EasyLoading.showSuccess(AppLocalizations.of(context)!.success);
  //   }, (errorCode, errorMsg) {
  //     // _showErrorAndDismiss(errorCode, errorMsg);
  //     EasyLoading.showError(AppLocalizations.of(context)!.verified_internet);
  //   });
  // }

  Future openDialogSetAdminCode() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text("set Admin Passcode"),
            content: Form(
              key: _key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "set here",
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
                    // setAdminCode(name, idSerrure);
                  }
                },
                child: Text("ok"),
              ),
            ]),
      );

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
            brightness: Brightness.light,
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  EasyLoading.show(status: "loading");
                  locknow();
                },
                icon: Icon(Icons.lock),
                color: Colors.green,
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
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          EasyLoading.show(status: "unlocking");
                          dounlock();
                        },
                        child: Image.asset(
                          img,
                          width: 150.0,
                        ),
                      ),
                      Text(
                        "click to unlock",
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 16,
                              color: Color(0XFF3B928D),
                            ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, //centre les elements en fonction du scafold
                    children: [
                      Image(
                        height: 30,
                        image: NetworkImage(Urls.images + '/battery.png'),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "$percent %",
                        style: TextStyle(color: Colors.blueAccent),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  InkWell(
                    onTap: () {
                      openDialogSetAdminCode();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, //centre les elements en fonction du scafold
                      children: [
                        Text(
                          "Admin Code :",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        SizedBox(width: 5.0),
                        adminCode == '123456'
                            ? Text(
                                "not set",
                                style: TextStyle(color: Colors.blue),
                              )
                            : Text(
                                "$adminCode",
                                style: TextStyle(color: Colors.blue),
                              ),
                        Text(
                          " <- click",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    child: GridView.count(
                      padding: EdgeInsets.all(21.0),
                      primary: false,
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      children: <Widget>[
                        CircleCardWidget(
                            iconImg: "assets/setting.png",
                            nameTxt: "setting",
                            delayStart: Duration(milliseconds: 250),
                            newPage: Lock(
                              lockName: lockName,
                              lockData: lockData,
                              lockMac: lockMac,
                              idAdmin: idAdmin,
                              idSerrure: idSerrure!,
                              percent: percent!,
                            )),
                        CircleCardWidget(
                          iconImg: "assets/Initlock.png",
                          nameTxt: "access",
                          delayStart: Duration(milliseconds: 250),
                          newPage: IndexLock(
                              lockName: lockName,
                              lockData: lockData,
                              lockMac: lockMac,
                              idAdmin: idAdmin,
                              idSerrure: idSerrure!,
                              percent: percent!),
                        ),
                        CircleCardWidget(
                          iconImg: "assets/register.png",
                          nameTxt: "access code",
                          delayStart: Duration(milliseconds: 250),
                          newPage: IndexCode(
                              lockName: lockName,
                              lockData: lockData,
                              lockMac: lockMac,
                              idAdmin: idAdmin,
                              idSerrure: idSerrure!,
                              percent: percent!),
                        ),
                        CircleCardWidget(
                          iconImg: "assets/Finance.png",
                          nameTxt: "smart Card",
                          delayStart: Duration(milliseconds: 250),
                          newPage: IndexCards(
                              lockName: lockName,
                              lockData: lockData,
                              lockMac: lockMac,
                              idAdmin: idAdmin,
                              idSerrure: idSerrure!,
                              percent: percent!),
                        ),
                        CircleCardWidget(
                          iconImg: "assets/Fingerprint.png",
                          nameTxt: "finger Print",
                          delayStart: Duration(milliseconds: 350),
                          newPage: LoginPage(),
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
