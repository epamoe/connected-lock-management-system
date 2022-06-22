import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter/ttlock.dart';
import 'package:ttlock_flutter_example/models/CardModel.dart';
import 'package:ttlock_flutter_example/models/lockModel.dart';
import 'package:ttlock_flutter_example/screens/LockOperations/LockOpps.dart';
import 'package:ttlock_flutter_example/services/user_service.dart';
import 'package:ttlock_flutter_example/urls/urls.dart';

class ListCards extends StatefulWidget {
  const ListCards(
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
  _ListCardsState createState() =>
      _ListCardsState(lockName, lockData, lockMac, idAdmin, idSerrure, percent);
}

class _ListCardsState extends State<ListCards> {
  String lockName = '';
  String lockData = '';
  String lockMac = '';
  String idAdmin = '';
  int? idSerrure;
  int? percent;
  _ListCardsState(String lockName, String lockData, String lockMac,
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
    var url = Uri.parse(Urls.url_get_all_card);
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
            title: Text("Choose your type of Card"),
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
                child: Text("Permanent card"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  openDialogCostumName();
                },
                child: Text("Periodic Card"),
              ),
            ]),
      );

  Future openDialogCostumName() => showDialog(
        context: context,
        builder: (context) => SingleChildScrollView(
          child: AlertDialog(
              title: Text('Card'),
              content: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                      // print(startDates);
                      // print(endDates);
                      createCard(description, startDates, endDates);
                    }
                    Navigator.pop(context);
                  },
                  child: Text('validate'),
                ),
              ]),
        ),
      );

  Future<void> createCard(String a, int startDate, int endDate) async {
    EasyLoading.show(status: 'proceed');
    print(startDate);
    print(endDate);
    var url = Uri.parse(Urls.url_add_card);
    TTLock.addCard(null, startDate, endDate, lockData, () {
      EasyLoading.show(status: 'Waiting for add card ...');
    }, (cardNumber) async {
      Map map = {
        "card": cardNumber,
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
            EasyLoading.showInfo('already exist',
                duration: Duration(seconds: 4));
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
    }, (errorCode, errorMsg) {
      EasyLoading.showError(errorMsg);
    });
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
      _cardList!.clear();
      for (Map i in data) {
        setState(() {
          _loading = false;
          _employees!.add(CardModel.fromJson(i));
          _cardList!.add(CardModel.fromJson(i));
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
    _cardList = [];
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
  List<CardModel>? _employees;
  List<CardModel>? _cardList;
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
                _employees = _cardList!
                    .where((u) =>
                        (u.card!.toLowerCase().contains(string.toLowerCase()) ||
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
      itemCount: _cardList!.length,
      itemBuilder: (BuildContext context, index) {
        final coscode = _cardList![index];

        return Card(
          elevation: 10.0,
          child: ListTile(
            title: Text("card" + ":" + coscode.card!),
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
                  onTap: () {},
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
            "all card list",
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
