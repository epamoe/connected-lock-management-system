class BluetoothAccessModel {
  int? id;
  String? lock_name;
  String? lock_mac;
  String? lock_data;
  String? description;
  String? start_date;
  String? end_date;
  int? is_set;
  int? lock_id;
  int? user_id;

  BluetoothAccessModel(
      {this.id,
        this.lock_name,
        this.lock_mac,
        this.lock_data,
        this.description,
        this.start_date,
        this.end_date,
        this.is_set,
        this.lock_id,
        this.user_id});

  factory BluetoothAccessModel.fromJson(Map j) {
    return BluetoothAccessModel(
        id: j['id'],
        lock_name: j['lock_name'],
        lock_mac: j['lock_mac'],
        lock_data: j['lock_data'],
        description: j['description'],
        start_date: j['start_date'],
        end_date: j['end_date'],
        is_set: j['is_set'],
        lock_id: j['lock_id'],
        user_id: j['user_id']);
  }

  Map toMap() {
    return {
      "id": id,
      "lock_name":lock_name,
      "lock_mac": lock_mac,
      "lock_data": lock_data,
      "description": description,
      "start_date": start_date,
      "end_date": end_date,
      "is_set": is_set,
      "lock_id": lock_id,
      "user_id": user_id
    };
  }
}
