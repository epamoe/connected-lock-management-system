import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter/ttlock.dart';
import 'package:ttlock_flutter_example/models/CodeModel.dart';
import 'package:ttlock_flutter_example/models/lockModel.dart';
import 'package:ttlock_flutter_example/screens/LockOperations/LockOpps.dart';
import 'package:ttlock_flutter_example/services/user_service.dart';
import 'package:ttlock_flutter_example/urls/urls.dart';

class ListCode extends StatefulWidget {
  const ListCode(
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
  _ListCodeState createState() =>
      _ListCodeState(lockName, lockData, lockMac, idAdmin, idSerrure, percent);
}

class _ListCodeState extends State<ListCode> {
  String lockName = '';
  String lockData = '';
  String lockMac = '';
  String idAdmin = '';
  int? idSerrure;
  int? percent;
  _ListCodeState(String lockName, String lockData, String lockMac,
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

  String start = '';
  String end = '';
  DateTime? selectedStartDateTime, selectedEndDateTime;

  TextEditingController _controller = new TextEditingController();
  TextEditingController _controller1 = new TextEditingController();
  int endDates = 0;
  int startDates = 0;

  static getCode(int id) async {
    var url = Uri.parse(Urls.url_get_all_code);
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

  Future choosetype() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text("Choose your type of code"),
            actions: <Widget>[
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: Text("cancel"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  SavePermanentCode();
                },
                child: Text("Permanent code"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  openDialogCostumName();
                },
                child: Text("temporal Code"),
              ),
            ]),
      );

  Future openDialogCostumName() => showDialog(
        context: context,
        builder: (context) => SingleChildScrollView(
          child: AlertDialog(
              title: Text('Code'),
              content: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "code",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) => val!.isEmpty ? "reqiured" : null,
                      onChanged: (val) => code = val,
                    ),
                    SizedBox(height: 2),
                    TextFormField(
                      autofocus: true,
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
                      readOnly: true,
                      autofocus: true,

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
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: '<----- end date',
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
                      int d = int.parse(code);
                      // costumCodes(d, nameCostum, startDates, endDates);
                      // print(startDates);
                      // print(endDates);
                      createCostumCode(d, description, startDates, endDates);
                    }
                    Navigator.pop(context);
                  },
                  child: Text('validate'),
                ),
              ]),
        ),
      );

  Future<void> createCostumCode(
      int code, String a, int startDate, int endDate) async {
    EasyLoading.show(status: 'proceed');
    String goodCode = code.toString();

    print(startDate);
    print(endDate);
    var url = Uri.parse(Urls.url_add_code);
    Map map = {
      "code": goodCode,
      "lock_id": idSerrure.toString(),
      "description": a,
      "user_id": idAdmin,
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

  Future SavePermanentCode() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text("set your permanent Code"),
            content: Form(
              key: _key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "short description",
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) => val!.isEmpty ? "required" : null,
                    onChanged: (val) => short_description = val,
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                child: Text("CANCEL"),
              ),
              MaterialButton(
                onPressed: () {},
                child: Text("SAVE"),
              ),
            ]),
      );

  getData() async {
    var data = await getCode(idSerrure!);
    print("this, is data");
    print(idSerrure);
    if (data != []) {
      _codeList!.clear();
      for (Map i in data) {
        setState(() {
          _loading = false;
          _employees!.add(CostumCodeModel.fromJson(i));
          _codeList!.add(CostumCodeModel.fromJson(i));
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

  Future attentionfromlock(int id, String code) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text("would you realy delete this access ?"),
            actions: <Widget>[
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: Text("cancel"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  deletespecifiquefromlock(id, code);
                },
                child: Text("Delete ?"),
              ),
            ]),
      );

  Future<void> deletespecifiquefromlock(int id, String code) async {
    EasyLoading.show(status: 'proceed to delete');
    var url = Uri.parse(Urls.url_delete_specifique_code);
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
          TTLock.supportFunction(TTLockFuction.managePasscode, lockData,
              (isSupport) {
            if (isSupport) {
              TTLock.deletePasscode(code, lockData, () {
                EasyLoading.showSuccess('success');
              }, (errorCode, errorMsg) {
                EasyLoading.showError(errorMsg);
              });
            } else {
              EasyLoading.showError('not support delete');
            }
          });
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
  List<CostumCodeModel>? _employees;
  List<CostumCodeModel>? _codeList;
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
                    attentionfromlock(coscode.id!, coscode.code!);
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
            "all code list",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  // setState(() {
                  //   timelock!.cancel();
                  //   _loading = false;
                  //   smg = "search";
                  // });
                  // getData();
                  TTLock.supportFunction(TTLockFuction.managePasscode, lockData,
                      (isSupport) {
                    // not support
                    if (!isSupport) {
                      EasyLoading.showInfo('not support');
                      return;
                    }
                    int startDate = DateTime.now().millisecondsSinceEpoch;
                    int endDate = startDate + 3600 * 24 * 30 * 1000;

                    TTLock.createCustomPasscode(
                        "6666", startDate, endDate, lockData, () {
                      EasyLoading.showInfo('success 6666');
                    }, (errorCode, errorMsg) {
                      EasyLoading.showInfo(errorMsg);
                    });
                  });
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
            choosetype();
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
