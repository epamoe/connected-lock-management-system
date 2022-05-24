import 'dart:convert';

import 'package:bmprogresshud/progresshud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter/ttgateway.dart';
import 'package:ttlock_flutter/ttlock.dart';
import 'package:ttlock_flutter_example/gateway_page.dart';
import 'package:ttlock_flutter_example/screens/HomeSelection/lock_list.dart';
import 'package:ttlock_flutter_example/screens/authentifications/login.dart';
import 'package:ttlock_flutter_example/urls/urls.dart';

import '../../wifi_page.dart';

enum ScanType { lock, gateway }

class ScanAllPage extends StatefulWidget {
  ScanAllPage({
    required this.scanType,
    required this.idAdmin,
  }) : super();
  final ScanType scanType;
  final String idAdmin;
  @override
  _ScanAllPageState createState() => _ScanAllPageState(scanType, idAdmin);
}

class _ScanAllPageState extends State<ScanAllPage> {
  ScanType? scanType;
  String idAdmin = '';
  BuildContext? _context;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController controller;
  String name = "";

  _ScanAllPageState(ScanType scanType, String idAdmin) {
    super.initState();
    this.scanType = scanType;
    this.idAdmin = idAdmin;
    controller = TextEditingController();
    // Print TTLock Log
    TTLock.printLog = true;
    EasyLoading.dismiss();
  }

  List<TTLockScanModel> _lockList = [];
  List<TTGatewayScanModel> _gatewayList = [];

  void dispose() {
    controller.dispose();
    if (scanType == ScanType.lock) {
      TTLock.stopScanLock();
    } else {
      TTGateway.stopScan();
    }
    super.dispose();
    EasyLoading.dismiss();
  }

  void _showLoading() {
    ProgressHud.of(_context!).showLoading(text: '');
  }

  void _dismissLoading() {
    ProgressHud.of(_context!).dismiss();
  }

  static const _INIT_ACTION = 'kufuli_init_lock';
  static const _NAME_ACTION = 'kufuli_rename_lock';

  void _initLock(TTLockScanModel scanModel, String name) async {
    // scanModel.lockName = name;
    Map map = Map();
    map["lockMac"] = scanModel.lockMac;
    map["lockVersion"] = scanModel.lockVersion;
    map["isInited"] = scanModel.isInited;
    EasyLoading.show(status: "proceed");

    TTLock.initLock(map, (lockData) async {
      try {
        var url = Uri.parse(Urls.url_save_lock);
        Map mapp = {
          "lockMac": scanModel.lockMac,
          "lockData": lockData,
          "id_user": idAdmin,
          "lock_name": name,
          "percent": scanModel.electricQuantity.toString(),
        };
        final response = await http.post(url,
            headers: {"Accept": "Application/JSON"}, body: mapp);
        print(scanModel.lockMac);
        print(scanModel.lockName);

        if (response.statusCode == 200) {
          //importer la library dart.convert
          var data = jsonDecode(response.body);
          print(data);
          bool success = data['success'];

          if (success == true) {
            EasyLoading.dismiss();
            openDialog(scanModel.lockMac);
          } else if (success == false) {
            EasyLoading.dismiss();
            openDialog(scanModel.lockMac);
          } else {
            EasyLoading.showError("error");
          }
        } else {
          EasyLoading.dismiss();
          EasyLoading.showInfo("internet error",
              duration: Duration(seconds: 4));
        }
      } catch (e) {
        EasyLoading.dismiss();
        EasyLoading.showInfo("error", duration: Duration(seconds: 4));
      }
    }, (errorCode, errorMsg) {
      EasyLoading.dismiss();
      EasyLoading.showError(errorMsg);
    });
  }

  void _connectGateway(String mac, TTGatewayType type) async {
    _showLoading();
    TTGateway.connect(mac, (status) {
      _dismissLoading();
      if (status == TTGatewayConnectStatus.success) {
        StatefulWidget? widget;
        if (type == TTGatewayType.g2) {
          widget = WifiPage(mac: mac);
        } else if (type == TTGatewayType.g3 || type == TTGatewayType.g4) {
          widget = GatewayPage(type: type);
        }

        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return widget!;
        }));
      }
    });
  }

  void _startScanLock() async {
    EasyLoading.show(status: "tooch lock");
    _lockList = [];
    TTLock.startScanLock((scanModel) {
      bool contain = false;
      bool initStateChanged = false;
      for (var model in _lockList) {
        if (scanModel.lockMac == model.lockMac) {
          EasyLoading.dismiss();
          contain = true;
          initStateChanged = model.isInited != scanModel.isInited;
          if (initStateChanged) {
            EasyLoading.dismiss();
            model.isInited = scanModel.isInited;
          }
          break;
        }
      }
      if (!contain) {
        EasyLoading.dismiss();
        _lockList.add(scanModel);
      }
      if (!contain || initStateChanged) {
        EasyLoading.dismiss();
        setState(() {
          _lockList.sort((model1, model2) =>
              (model2.isInited ? 0 : 1) - (model1.isInited ? 0 : 1));
        });
      }
    });
  }

  void _startScanGateway() {
    _gatewayList = [];
    TTGateway.startScan((scanModel) {
      bool contain = false;
      for (TTGatewayScanModel model in _gatewayList) {
        if (scanModel.gatewayMac == model.gatewayMac) {
          contain = true;
          break;
        }
      }
      if (!contain) {
        setState(() {
          _gatewayList.add(scanModel);
        });
      }
    });
  }

  Future<void> saveLock(String mac, String newName) async {
    // _initLock(scanModel);
    EasyLoading.show(status: "change name");
    var url = Uri.parse(Urls.url_rename_lock);
    try {
      final response = await http.post(url, body: {
        "kufuli": _NAME_ACTION,
        "lockMac": mac,
        "idAdmin": idAdmin,
        "lock_name": newName,
      });

      print(_NAME_ACTION);
      print(mac);
      print(idAdmin);
      print(newName);

      if (response.statusCode == 200) {
        print(response.body);
        var data = jsonDecode(response.body);
        print(data);
        String message = data['message'];
        if (message == 'rename_success') {
          print("-----renommage de success ");
          EasyLoading.dismiss();
          setState(() {
            EasyLoading.showSuccess(message);
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => LockList(
            //               idAdmin: idAdmin,
            //             )));
          });
        }
        if (message == 'bug_rename') {
          EasyLoading.showInfo("failed to rename",
              duration: Duration(seconds: 4));
        }
        if (message == 'user_no_exist') {
          print("l'utilisateur n'existe pas");
          EasyLoading.dismiss();
          EasyLoading.showError("user no exit");
          setState(() {
            EasyLoading.showSuccess(message);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false);
          });
        }
        if (message == 'empty_data') {
          print("data vide");
          EasyLoading.dismiss();
          EasyLoading.showError("empty data");
          setState(() {
            EasyLoading.showSuccess(message);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false);
          });
        }
        if (message == 'action_not_permitted') {
          print("pas de permission");
          EasyLoading.dismiss();
          EasyLoading.showError("not permited");
          setState(() {
            EasyLoading.showSuccess(message);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false);
          });
        }
        if (message == 'no_authorized') {
          print("pas de permission");
          EasyLoading.dismiss();
          EasyLoading.showError("not authorized");
          setState(() {
            EasyLoading.showSuccess(message);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false);
          });
        }
      }
    } catch (e) {
      EasyLoading.showInfo("verified internet", duration: Duration(seconds: 4));
    }
  }

  Future openDialog(String m) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text("room"),
            content: Form(
              key: _key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "name",
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
                onPressed: () {
                  Navigator.pop(context);
                  back();
                },
                child: Text("cancel"),
              ),
              MaterialButton(
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    Navigator.pop(
                      context,
                    );
                    TTLock.stopScanLock();
                    saveLock(m, name);
                  }
                },
                child: Text("save"),
              ),
            ]),
      );

  back() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LockList(
                  idAdmin: idAdmin,
                )));
  }

  @override
  Widget build(BuildContext context) {
    String title = scanType == ScanType.lock ? "locks" : "gateway";
    return WillPopScope(
      onWillPop: () {
        return back();
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Material(
              child: ProgressHud(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 30.0),
              child: Builder(builder: (context) {
                _context = context;
                return getListView();
              }),
            ),
          ))),
    );
  }

  Widget getListView() {
    String gatewayNote = "power gateway";
    String lockNote = "locks";
    String note = scanType == ScanType.lock ? lockNote : gatewayNote;
    return Column(
      children: <Widget>[
        SizedBox(height: 10.0),
        MaterialButton(
          onPressed: () {
            scanType == ScanType.lock ? _startScanLock() : _startScanGateway();
          },
          textColor: Colors.white,
          color: Colors.blue,
          child: SizedBox(
            width: double.infinity,
            child: Text(
              scanType == ScanType.lock ? "scan Lock" : "scan gateway",
              textAlign: TextAlign.center,
            ),
          ),
          height: 50,
          minWidth: 600,
        ),
        SizedBox(height: 10.0),
        Text(note),
        Expanded(
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(height: 2, color: Colors.green);
                },
                itemCount: (scanType == ScanType.lock
                    ? _lockList.length
                    : _gatewayList.length),
                itemBuilder: (context, index) {
                  String title;
                  String subtitle;
                  Color textColor = Colors.green;
                  if (scanType == ScanType.lock) {
                    TTLockScanModel scanModel = _lockList[index];
                    title = "Locks" + ' ：${scanModel.lockName}';
                    subtitle = scanModel.isInited
                        ? "you can;t add lock again"
                        : "click to init";
                    if (scanModel.isInited) {
                      textColor = Colors.red;
                    }
                  } else {
                    TTGatewayScanModel scanModel = _gatewayList[index];
                    title = "gateway" + ' ：${scanModel.gatewayName}';
                    subtitle = "click to init";
                  }

                  TextStyle textStyle = new TextStyle(color: textColor);

                  return ListTile(
                    title: Text(title, style: textStyle),
                    subtitle: Text(subtitle, style: textStyle),
                    onTap: () async {
                      if (scanType == ScanType.lock) {
                        TTLockScanModel scanModel = _lockList[index];
                        if (!scanModel.isInited) {
                          TTLock.stopScanLock();
                          // openDialog(scanModel);
                          String a = scanModel.lockName;
                          _initLock(scanModel, a);
                          // final name = await openDialog();
                        }
                      } else {
                        TTGatewayScanModel scanModel = _gatewayList[index];
                        TTGateway.stopScan();
                        _connectGateway(scanModel.gatewayMac, scanModel.type!);
                      }
                    },
                  );
                })),
      ],
    );
  }
}
