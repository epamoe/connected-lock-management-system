import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'ListLocks.dart';
import 'SettingLock.dart';

class IndexLock extends StatefulWidget {
  IndexLock(
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
  _IndexLockState createState() =>
      _IndexLockState(lockName, lockData, lockMac, idAdmin, idSerrure, percent);
}

class _IndexLockState extends State<IndexLock> {
  String lockName = '';
  String lockData = '';
  String lockMac = '';
  String idAdmin = '';
  int? idSerrure;
  int? percent;
  _IndexLockState(String lockName, String lockData, String lockMac,
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
      ListLock(
          lockName: lockName,
          lockData: lockData,
          lockMac: lockMac,
          idAdmin: idAdmin,
          idSerrure: idSerrure!,
          percent: percent!),
      SettingLock(
          lockName: lockName,
          lockData: lockData,
          lockMac: lockMac,
          idAdmin: idAdmin,
          idserrure: idSerrure!,
          percent: percent!)
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
              icon: Icon(Icons.share),
              title: Text("Share"),
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
