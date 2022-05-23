import 'package:flutter/material.dart';

class TemeratureView extends StatelessWidget {
  final List<IconData> icons = [
    Icons.settings,
    Icons.person,
    Icons.ac_unit,
    Icons.notifications_none,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Temperature',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'Lorem ipsum is simply dummy',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey[400],
                    ),
                  )
                ],
              ),
              Spacer(),
              Text(
                '20°C',
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.blueGrey[400],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration _getBoxDecoration(BuildContext context, {pressed = false}) =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            offset: pressed ? Offset(-3, -3) : Offset(3, 3),
            color: Colors.black12,
            blurRadius: 3,
          ),
          BoxShadow(
            offset: pressed ? Offset(3, 3) : Offset(-3, -3),
            color: Colors.white,
            blurRadius: 3,
          ),
        ],
      );

  Container _buildTemperatureContainer(BuildContext context) => Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(horizontal: 3.0),
        decoration: _getBoxDecoration(context, pressed: true),
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 4.0),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  bottomLeft: Radius.circular(25.0),
                ),
                child: Container(
                  width: 160.0,
                  color: Colors.pinkAccent[700],
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                      5,
                      (index) => Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 5.0),
                            width: 0.2,
                            color: Colors.blueGrey,
                          )),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                '32°C',
                style: TextStyle(color: Colors.blueGrey[600], fontSize: 13.0),
              ),
              SizedBox(
                width: 15.0,
              )
            ],
          ),
        ),
      );
}
