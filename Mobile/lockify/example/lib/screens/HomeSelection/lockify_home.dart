import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ttlock_flutter_example/screens/DrawerPage/kufuli_all_NavDrawer.dart';

import 'TabScreen.dart';
import 'body.dart';

class HomePageAll extends StatefulWidget {
  HomePageAll();
  @override
  _HomePageAllState createState() => _HomePageAllState();
}

class _HomePageAllState extends State<HomePageAll> {
  List<Widget> tabs = [];

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabs = [
      Body(),
      TabScreen(),
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
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                // gett();
              },
              icon: Icon(Icons.info),
              color: Colors.grey,
            )
          ],
        ),
        drawer: NavDrawer(),
        body: tabs[currentTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTapped,
          currentIndex: currentTabIndex,
          //backgroundColor: Colors.blueGrey,
          type: BottomNavigationBarType.fixed,

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              title: Text("Profile"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text("setting"),
            ),
            /*BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus),
            title: Text("Delivery"),
          ),*/
          ],
        ),
      );
}
