import 'package:flutter/material.dart';

class Service {
  Service({
    @required this.name,
    @required this.icon,
    this.status = false,
  });
  String? name;
  IconData? icon;
  bool status;

  static List<Service> getHomeService() {
    List<Service> services = [
      Service(name: 'yours Lock', icon: Icons.lock),
      Service(name: 'Manage Access', icon: Icons.wifi, status: true),
      Service(name: 'Yours Access', icon: Icons.wb_sunny),
      Service(name: 'Add Lock', icon: Icons.add_circle),
    ];
    return services;
  }
}
