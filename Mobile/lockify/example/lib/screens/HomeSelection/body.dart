import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/screens/LockOperations/Access/ListAccess.dart';
import 'package:ttlock_flutter_example/services/user_service.dart';

import 'const.dart';
import 'lock_list.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int? selectindex;

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

  void initState() {
    super.initState();
    // _employees = [];
    // _lockList = [];
    gett();
    // getData();
    // Future.delayed(const Duration(seconds: 2));
    // timelock = Timer.periodic(Duration(seconds: 10), (Timer t) => getData());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(8),
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/SERRURE.png",
                      height: 120,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Container(
              color: boxColor,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Container(
                      color: Colors.white,
                      child: GridView.count(
                          padding: EdgeInsets.all(21.0),
                          primary: false,
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: <Widget>[
                            TodayAC(
                              iconImg: "assets/images/add.png",
                              nameTxt: "LOCK",
                              total: "01",
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LockList(
                                              idAdmin: idadmin1,
                                            )));
                              },
                            ),
                            TodayAC(
                              iconImg:
                                  "assets/images/Icon feather-settings.png",
                              nameTxt: "Manage Access",
                              total: "25",
                              onPressed: () {
                                // getPower();
                              },
                            ),
                            TodayAC(
                              iconImg: "assets/images/Group 2359.png",
                              nameTxt: "your Access",
                              total: "31",
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListAccess(
                                          idAdmin: idadmin1,
                                        )));
                              },
                            ),
                            TodayAC(
                              iconImg: "assets/Switch.png",
                              nameTxt: "other",
                              total: "21",
                              onPressed: () {
                                // getPower();
                              },
                            ),
                          ])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TodayAC extends StatefulWidget {
  final String iconImg;
  final String nameTxt;
  final String total;
  final VoidCallback onPressed;
  TodayAC(
      {required this.iconImg,
      required this.nameTxt,
      required this.total,
      required this.onPressed})
      : super();
  @override
  _TodayACState createState() => _TodayACState();
}

class _TodayACState extends State<TodayAC> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.2),
      child: Padding(
        padding: const EdgeInsets.only(right: 6),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            height: 60,
            width: 120,
            margin: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: boxColor,
                boxShadow: kboxShadow),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      widget.iconImg,
                      height: 30,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      widget.total,
                      style: TextStyle(letterSpacing: 2),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.nameTxt,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class dailyAC extends StatelessWidget {
  const dailyAC({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.2),
      child: Padding(
        padding: const EdgeInsets.only(right: 6),
        child: Container(
          height: 80,
          width: 66,
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: boxColor,
              boxShadow: kboxShadow),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                daily[index].day,
                style: TextStyle(
                    letterSpacing: 0, fontSize: 12, color: Colors.grey),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                daily[index].date,
                style: TextStyle(
                    color: Colors.blue[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              )
            ],
          ),
        ),
      ),
    );
  }
}
