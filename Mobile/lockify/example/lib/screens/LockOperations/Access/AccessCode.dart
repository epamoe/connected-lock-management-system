import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter/ttlock.dart';
import 'package:ttlock_flutter_example/models/CodeAccessModel.dart';
import 'package:ttlock_flutter_example/models/lockModel.dart';
import 'package:ttlock_flutter_example/screens/HomeSelection/lockify_home.dart';
import 'package:ttlock_flutter_example/services/user_service.dart';
import 'package:ttlock_flutter_example/urls/urls.dart';

class AccessCode extends StatefulWidget {
  const AccessCode({
    Key? key,
    required this.idAdmin,
  }) : super(key: key);
  final String idAdmin;

  @override
  _AccessCodeState createState() => _AccessCodeState(idAdmin);
}

class _AccessCodeState extends State<AccessCode> {
  String idAdmin = '';
  _AccessCodeState(String idAdmin) {
    super.initState();
    this.idAdmin = idAdmin;
  }

  Timer? timelock;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController controller;
  String name = '';
  String short_description = '';
  String nameCostum = '';
  String nameOfBelongCode = '';
  String code = '';
  String description = '';

  String start = '';
  String end = '';
  DateTime? selectedStartDateTime, selectedEndDateTime;

  TextEditingController _controller = new TextEditingController();
  TextEditingController _controller1 = new TextEditingController();
  int endDates = 0;
  int startDates = 0;

  static getCode(String id) async {
    var url = Uri.parse(Urls.url_get_access_code_access);
    Map map = {"user_id": id};
    final response = await http.post(
      url,
      headers: {"Accept": "Application/JSON"},
      body: map,
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<void> createCostumCode(
      int id, String code, String start, String end, String lockData) async {
    // EasyLoading.show(status: 'proceed');
    String goodCode = code.toString();
    DateTime a = DateTime.parse(start);
    DateTime b = DateTime.parse(end);

    int startDate = a.millisecondsSinceEpoch;
    int endDate = b.millisecondsSinceEpoch;

    print(startDate);
    print(endDate);
    var url = Uri.parse(Urls.url_set_password_to_lock);
    Map map = {
      "id": id.toString(),
      "code": goodCode,
      "user_id": idAdmin,
    };
    try {
      final response = await http.post(url,
          headers: {"Accept": "Application/JSON"}, body: map);
      if (response.statusCode == 200) {
        print(response.body);
        var data = jsonDecode(response.body);
        print(data);
        if (data['status'] == 'error') {
          print("----------------------erreur de requette");
          EasyLoading.showInfo('somthing wrong',
              duration: Duration(seconds: 4));
        }
        if (data['status'] == 'updated') {
          TTLock.supportFunction(TTLockFuction.managePasscode, lockData,
              (isSupport) async {
            // not support
            if (!isSupport) {
              EasyLoading.showError('not supported');
              return;
            }
            TTLock.createCustomPasscode(goodCode, startDate, endDate, lockData,
                () async {
              print("---------------------> Success Message");
              EasyLoading.showSuccess('success');
              getData();
            }, (errorCode, errorMsg) {
              EasyLoading.showError(errorMsg);
            });
          });
          int timestamp = DateTime.now().millisecondsSinceEpoch;
          TTLock.setLockTime(timestamp, lockData, () {
            print('$timestamp');
          }, (errorCode, errorMsg) {
            print('setLockTime not possible');
          });
        }
      } else {
        EasyLoading.showInfo('server error', duration: Duration(seconds: 4));
      }
    } catch (e) {
      print(e);
      EasyLoading.showInfo('somthing wrong', duration: Duration(seconds: 4));
    }
  }

  Future choosetype(
          int id, String code, String start, String end, String lockData) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text("Set New Code ?"), actions: <Widget>[
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text("cancel"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              createCostumCode(id, code, start, end, lockData);
            },
            child: Text("Set"),
          ),
        ]),
      );

  Future message() => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text("Your code set on lock"), actions: <Widget>[
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text("cancel"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ]),
      );

  getData() async {
    var data = await getCode(idAdmin);
    print("this, is data");
    print(idAdmin);
    if (data != []) {
      _codeList!.clear();
      for (Map i in data) {
        setState(() {
          _loading = false;
          _employees!.add(CodeAccessModel.fromJson(i));
          _codeList!.add(CodeAccessModel.fromJson(i));
        });
      }
    } else if (data == null) {
      setState(() {
        _loading = false;
        smg = "internet error";
      });
    } else {
      setState(() {
        _loading = false;
        smg = "nothing from now";
      });
    }
    print(data);
    setState(() {
      _loading = false;
    });
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

  @override
  void initState() {
    super.initState();
    _employees = [];
    _codeList = [];
    gett();
    getData();
    Future.delayed(const Duration(seconds: 2));
    timelock = Timer.periodic(Duration(seconds: 10), (Timer t) => getData());
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    timelock!.cancel();
    super.dispose();
  }

  final _debouncer = Debouncer(milliseconds: 2000);
  List<CodeAccessModel>? _employees;
  List<CodeAccessModel>? _codeList;
  String smg = 'search lock';
  bool _loading = true;
  String img = 'lib/resources/spinner.gif';

  searchField() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          hintText: "search",
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (string) {
          // timelock!.cancel();
          if (string != '') {
            timelock!.cancel();
            _debouncer.run(() {
              setState(() {
                _employees = _codeList!
                    .where((u) =>
                        (u.code!.toLowerCase().contains(string.toLowerCase()) ||
                            u.description!
                                .toLowerCase()
                                .contains(string.toLowerCase())))
                    .toList();
              });
            });
          } else {
            timelock =
                Timer.periodic(Duration(seconds: 10), (Timer t) => getData());
          }
        },
      ),
    );
  }

  _dataLockList() {
    return ListView.builder(
      itemCount: _codeList!.length,
      itemBuilder: (BuildContext context, index) {
        final coscode = _codeList![index];

        return Card(
          elevation: 10.0,
          child: ListTile(
            title: Text("code" + ":" + coscode.code!),
            subtitle: Text("start Date: " +
                coscode.start_date! +
                "\n" +
                "end Date : " +
                coscode.end_date!),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.qr_code,
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 4,
                ),
                InkWell(
                  onTap: () {
                    // attentionfromlock(coscode.id!, coscode.code!);
                  },
                  child: Icon(
                    Icons.restore_from_trash,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            onTap: () {
              timelock?.cancel();
              Future.delayed(const Duration(seconds: 1));
              coscode.is_set == 0
                  ? choosetype(coscode.id!, coscode.code!, coscode.start_date!,
                      coscode.end_date!, coscode.lock_data!)
                  : message();
            },
          ),
        );
      },
    );
  }

  back() {
    timelock?.cancel();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePageAll()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        timelock?.cancel();
        return back();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "all Access code list",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.refresh,
                  color: Colors.black87,
                ))
          ],
          brightness: Brightness.light,
          backgroundColor: Colors.white,
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
        body: _loading == true
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    img,
                    fit: BoxFit.none,
                    height: 30,
                    width: 30,
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.15,
                    left: MediaQuery.of(context).size.width * 0.065,
                    right: MediaQuery.of(context).size.width * 0.065,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 13),
                            blurRadius: 25,
                            color: Color(0xFF5666C2).withOpacity(0.17),
                          ),
                        ],
                      ),
                      child: Text(
                        smg,
                        style: TextStyle(fontSize: 22, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              )
            : Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    searchField(),
                    Expanded(
                      child: _dataLockList(),
                    ),
                  ],
                ),
              ),

        // return  Center(child: CircularProgressIndicator(),);
      ),
    );
  }

  Future<DateTime?> _selectedEndDatime(BuildContext context) =>
      DatePicker.showDateTimePicker(
        context,
        showTitleActions: true,
        locale: LocaleType.fr,
        onChanged: (date) {
          print('change $date in time zone ' +
              date.timeZoneOffset.inHours.toString());
        },
        onConfirm: (date) {
          selectedEndDateTime = date;
        },
        currentTime: DateTime.now(),
      );

  Future<DateTime?> _selectedStartDateTime(BuildContext context) =>
      DatePicker.showDateTimePicker(context,
          showTitleActions: true, locale: LocaleType.fr, onChanged: (date) {
        print('change $date in time zone ' +
            date.timeZoneOffset.inHours.toString());
      }, onConfirm: (date) {
        selectedStartDateTime = date;
      }, currentTime: DateTime.now());
}

class LockListView extends StatelessWidget {
  const LockListView({
    Key? key,
    required List<LockModel> lockList,
    required this.idAdmin,
    required this.idEnterprise,
  })  : _lockList = lockList,
        super(key: key);

  final List<LockModel> _lockList;
  final String idAdmin;
  final String idEnterprise;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _lockList.length,
      itemBuilder: (BuildContext context, index) {
        final lock = _lockList[index];
        return Card(
          elevation: 10.0,
          child: ListTile(
            title: Text("Owner: " + lock.lockMac!),
            subtitle: Text("Room: " + lock.lockName!),
            leading: Icon(Icons.qr_code),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => LockOpp(
              //               lockName: lock.lockName!,
              //               lockData: lock.lockData!,
              //               lockMac: lock.lockMac!,
              //               idAdmin: idAdmin,
              //               idEntreprise: idEnterprise,
              //               idSerrure: lock.idSerrure!,
              //               percent: lock.percent!,
              //             )));
            },
          ),
        );
      },
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!
          .cancel(); // when the user is continuosly typing, this cancels the timer
    }
    // then we will start a new timer looking for the user to stop
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
