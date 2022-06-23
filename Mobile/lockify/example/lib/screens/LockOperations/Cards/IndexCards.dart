import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'ListCards.dart';
import 'SettingCards.dart';
import 'ShareCards.dart';



class IndexCards extends StatefulWidget {
  IndexCards({Key? key,
    required this.lockName,
    required this.lockData,
    required this.lockMac,
    required this.idAdmin,
    required this.idSerrure,
    required this.percent}) : super(key: key);
  final String lockName;
  final String lockData;
  final String lockMac;
  final String idAdmin;
  final int idSerrure;
  final int percent;
  @override
  _IndexCardsState createState() => _IndexCardsState(lockName, lockData, lockMac, idAdmin, idSerrure, percent);
}

class _IndexCardsState extends State<IndexCards> {
  String lockName = '';
  String lockData = '';
  String lockMac = '';
  String idAdmin = '';
  int? idSerrure;
  int? percent;
  _IndexCardsState(String lockName, String lockData, String lockMac,
      String idAdmin, int idSerrure, int percent) {
    super.initState();
    this.lockName = lockName;
    this.lockData = lockData;
    this.lockMac = lockMac;
    this.idAdmin = idAdmin;
    this.idSerrure = idSerrure;
    this.percent = percent;
  }
  List<Widget> tabs = [];

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabs = [
      ListCards(lockName: lockName, lockData: lockData, lockMac: lockMac, idAdmin: idAdmin, idSerrure: idSerrure!,percent: percent!),
      ShareCards(lockName: lockName, lockData: lockData, lockMac: lockMac, idAdmin: idAdmin, idSerrure: idSerrure!,percent: percent!),
      SettingCards(lockName: lockName, lockData: lockData, lockMac: lockMac, idAdmin: idAdmin, idserrure: idSerrure!,percent: percent!)
      // TabScreen(),
      // //TabScreen2(user: widget.user),
      // TabScreen4(user: widget.user),
    ];
  }

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    // appBar: AppBar(
    //   backgroundColor: Colors.blueAccent,
    //   actions: <Widget>[
    //     IconButton(
    //       onPressed: () {
    //         // gett();
    //       },
    //       icon: Icon(Icons.info),
    //       color: Colors.grey,
    //     )
    //   ],
    // ),
    // drawer: NavDrawer(),
    body: tabs[currentTabIndex],
    bottomNavigationBar: BottomNavigationBar(
      onTap: onTapped,
      currentIndex: currentTabIndex,
      //backgroundColor: Colors.blueGrey,
      type: BottomNavigationBarType.fixed,

      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("All card"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.share),
          title: Text("Share card"),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          title: Text("Settings"),
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.settings),
        //   title: Text("settings"),
        // ),
        /*BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus),
            title: Text("Delivery"),
          ),*/
      ],
    ),
  );
}
