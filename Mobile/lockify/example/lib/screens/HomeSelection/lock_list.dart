import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:ttlock_flutter_example/models/lockModel.dart';
import 'package:ttlock_flutter_example/screens/ScanPage/scan_page.dart';
import 'package:ttlock_flutter_example/services/user_service.dart';
import 'package:ttlock_flutter_example/urls/urls.dart';

import 'lockify_home.dart';

class LockList extends StatefulWidget {
  const LockList({Key? key, required this.idAdmin}) : super(key: key);
  final String idAdmin;

  @override
  _LockListState createState() => _LockListState(idAdmin);
}

class _LockListState extends State<LockList> {
  String idAdmin = '';
  _LockListState(String idAdmin) {
    super.initState();
    this.idAdmin = idAdmin;
  }

  Timer? timelock;

  static getLock(String id) async {
    var url = Uri.parse(Urls.url_get_all_lock);
    Map map = {"id": id};
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

  // _getAllLock() {
  //   OtherServices.getlock(idEnterprise, context).then((lock) {
  //     if (lock.length == 0) {
  //       EasyLoading.showInfo(AppLocalizations.of(context)!.nothing_from_now,
  //           duration: Duration(seconds: 5));
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => LockNotFound(
  //                     idEnterprise: idEnterprise,
  //                     idAdmin: idAdmin,
  //                   )));
  //     }
  //     if (lock.length != 0) {
  //       setState(() {
  //         _employees = lock;
  //         // Initialize to the list from Server when reloading...
  //         _lockList = lock;
  //       });
  //     }
  //
  //     print("Length ${lock.length}");
  //   });
  // }

  getData() async {
    var data = await getLock(idAdmin);
    print("this, is data");
    if (data != []) {
      _lockList!.clear();
      for (Map i in data) {
        setState(() {
          _loading = false;
          _employees!.add(LockModel.fromJson(i));
          _lockList!.add(LockModel.fromJson(i));
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
    _lockList = [];
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
  List<LockModel>? _employees;
  List<LockModel>? _lockList;
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
                _employees = _lockList!
                    .where((u) => (u.lockName!
                            .toLowerCase()
                            .contains(string.toLowerCase()) ||
                        u.lockMac!
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
      itemCount: _lockList!.length,
      itemBuilder: (BuildContext context, index) {
        final lock = _lockList![index];

        return Card(
          elevation: 10.0,
          child: ListTile(
            title: Text(lock.lockName!),
            subtitle: Text(lock.percent! + "%"),
            leading: Icon(
              Icons.lock,
              color: Colors.blue,
            ),
            onTap: () {
              timelock?.cancel();
              Future.delayed(const Duration(seconds: 1));
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => LockOpp(
              //               lockName: lock.lockName!,
              //               lockData: lock.lockData!,
              //               lockMac: lock.lockMac!,
              //               idAdmin: idAdmin,
              //               idSerrure: lock.idSerrure!,
              //               percent: lock.percent!,
              //             )));
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
            "all lock list",
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
              Navigator.pop(context);
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ScanAllPage(
                          scanType: ScanType.lock,
                          idAdmin: idadmin1,
                        )));
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
            leading: Icon(Icons.lock),
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
