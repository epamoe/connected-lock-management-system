import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter/ttlock.dart';
import 'package:ttlock_flutter_example/models/BluetoothModel.dart';
import 'package:ttlock_flutter_example/screens/LockOperations/LockOpps.dart';
import 'package:ttlock_flutter_example/services/user_service.dart';
import 'package:ttlock_flutter_example/urls/urls.dart';

class ListLock extends StatefulWidget {
  const ListLock(
      {Key? key,
      required this.lockName,
      required this.lockData,
      required this.lockMac,
      required this.idAdmin,
      required this.idSerrure,
      required this.percent})
      : super(key: key);
  final String lockName;
  final String lockData;
  final String lockMac;
  final String idAdmin;
  final int idSerrure;
  final int percent;

  @override
  _ListLockState createState() =>
      _ListLockState(lockName, lockData, lockMac, idAdmin, idSerrure, percent);
}

class _ListLockState extends State<ListLock> {
  String lockName = '';
  String lockData = '';
  String lockMac = '';
  String idAdmin = '';
  int? idSerrure;
  int? percent;
  _ListLockState(String lockName, String lockData, String lockMac,
      String idAdmin, int idSerrure, int percent) {
    super.initState();
    this.lockName = lockName;
    this.lockData = lockData;
    this.lockMac = lockMac;
    this.idAdmin = idAdmin;
    this.idSerrure = idSerrure;
    this.percent = percent;
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
  String email = '';

  String start = '';
  String end = '';
  DateTime? selectedStartDateTime, selectedEndDateTime;

  TextEditingController _controller = new TextEditingController();
  TextEditingController _controller1 = new TextEditingController();
  int endDates = 0;
  int startDates = 0;

  static getBluetooth(int id) async {
    var url = Uri.parse(Urls.url_get_all_bluetooch);
    Map map = {"lock_id": id.toString()};
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

  Future openDialogCostumName() => showDialog(
        context: context,
        builder: (context) => SingleChildScrollView(
          child: AlertDialog(
              title: Text('Bluetooth access'),
              content: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) => val!.isEmpty ? "required" : null,
                      onChanged: (val) => email = val,
                    ),
                    SizedBox(height: 4),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'description',
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) => val!.isEmpty ? "required" : null,
                      onChanged: (val) => description = val,
                    ),
                    SizedBox(height: 4),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'start date',
                        border: OutlineInputBorder(),
                        prefixIcon: InkWell(
                            onTap: () async {
                              final selectedStartDate =
                                  await _selectedStartDateTime(context);
                              if (selectedStartDate == null) return;
                              startDates =
                                  selectedStartDate.millisecondsSinceEpoch;
                              setState(() {
                                _controller1.text =
                                    selectedStartDate.toString();
                              });
                            },
                            child: Icon(Icons.calendar_today)),
                      ),
                      keyboardType: TextInputType.text,
                      controller: _controller1,

                      //recuperations des valeurs entre par l'utilisateur
                      validator: (val) => val!.isEmpty ? 'required' : null,
                      onChanged: (val) => start = val,
                    ),
                    SizedBox(height: 4),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: '<-- end date',
                        border: OutlineInputBorder(),
                        prefixIcon: InkWell(
                            onTap: () async {
                              final selectedEndtDate =
                                  await _selectedEndDatime(context);
                              if (selectedEndtDate == null) return;
                              endDates =
                                  selectedEndtDate.millisecondsSinceEpoch;
                              setState(() {
                                _controller.text = selectedEndtDate.toString();
                              });
                            },
                            child: Icon(Icons.calendar_today)),
                      ),
                      keyboardType: TextInputType.text,
                      controller: _controller,
                      //recuperations des valeurs entre par l'utilisateur
                      validator: (val) => val!.isEmpty ? 'required' : null,
                      onChanged: (val) => end = val,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('cancel'),
                ),
                MaterialButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      createAccess(description, email, startDates, endDates);
                    }
                    Navigator.pop(context);
                  },
                  child: Text('validate'),
                ),
              ]),
        ),
      );

  Future choosetype(int id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text("are you sure you want to delete ?"),
            actions: <Widget>[
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: Text("cancel"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  deleteAccess(id);
                },
                child: Text("Delte"),
              ),
            ]),
      );

  Future<void> deleteAccess(int id) async {
    EasyLoading.show(status: 'proceed to delete');
    var url = Uri.parse(Urls.url_remove_bluetooth_access);
    Map map = {
      "id": id.toString(),
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
        if (data['status'] == 'not exist') {
          print("----------------------error for add");
          EasyLoading.showInfo('not exit exist',
              duration: Duration(seconds: 4));
        }
        if (data['status'] == 'deleted') {
          EasyLoading.showSuccess('success');
          getData();
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

  Future<void> createAccess(
      String a, String email, int startDate, int endDate) async {
    EasyLoading.show(status: 'proceed');

    var url = Uri.parse(Urls.url_create_bluetooth_access);
    Map map = {
      "lock_id": idSerrure.toString(),
      "description": a,
      "email": email,
      "start_date": startDate.toString(),
      "end_date": endDate.toString(),
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
        if (data['status'] == 'exist') {
          print("----------------------error for add");
          EasyLoading.showInfo('already exist', duration: Duration(seconds: 4));
        }
        if (data['status'] == 'success') {
          EasyLoading.showSuccess('success');
          getData();
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

  getData() async {
    var data = await getBluetooth(idSerrure!);
    print("this, is data");
    print(idSerrure);
    if (data != []) {
      _bluetoothList!.clear();
      for (Map i in data) {
        setState(() {
          _loading = false;
          _employees!.add(BluetoothModel.fromJson(i));
          _bluetoothList!.add(BluetoothModel.fromJson(i));
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
    _bluetoothList = [];
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
  List<BluetoothModel>? _employees;
  List<BluetoothModel>? _bluetoothList;
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
                _employees = _bluetoothList!
                    .where((u) => (u.start_date!
                            .toLowerCase()
                            .contains(string.toLowerCase()) ||
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
      itemCount: _bluetoothList!.length,
      itemBuilder: (BuildContext context, index) {
        final coscode = _bluetoothList![index];

        return Card(
          elevation: 10.0,
          child: ListTile(
            title: Text("Name" + ":" + coscode.username!),
            subtitle: Text("start Date: " +
                coscode.start_date! +
                "\n\n" +
                "end Date : " +
                coscode.end_date! +
                "\n\n"),
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
                    choosetype(coscode.id!);
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
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => LockOpp(
              //           lockName: lock.lockName!,
              //           lockData: lock.lockData!,
              //           lockMac: lock.lockMac!,
              //           idAdmin: idAdmin,
              //           idSerrure: lock.idSerrure!,
              //           percent: lock.percent!,
              //         )));
            },
          ),
        );
      },
    );
  }

  back() {
    timelock?.cancel();
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
            "all bluetooth access",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    timelock!.cancel();
                    _loading = false;
                    smg = "search";
                  });
                  getData();
                },
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            timelock!.cancel();
            openDialogCostumName();
          },
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
