import 'package:flutter/material.dart';
import 'package:ttlock_flutter_example/widgets/header_view.dart';
import 'package:ttlock_flutter_example/widgets/home_service_view.dart';
import 'package:ttlock_flutter_example/widgets/temperature_view.dart';

class TabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: HeaderView(),
                    ),
                    Expanded(
                      flex: 3,
                      child: HomeServiceView(),
                    ),
                  ],
                ),
              ),
              Expanded(flex: 1, child: TemeratureView()),
            ],
          ),
        ),
      ),
    );
  }
}
