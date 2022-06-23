class BluetoothModel {
  int? id;
  String? username;
  String? email;
  String? description;
  String? start_date;
  String? end_date;
  int? is_set;
  int? lock_id;
  int? user_id;

  BluetoothModel(
      {this.id,
      this.username,
      this.email,
      this.description,
      this.start_date,
      this.end_date,
      this.is_set,
      this.lock_id,
      this.user_id});

  factory BluetoothModel.fromJson(Map j) {
    return BluetoothModel(
        id: j['id'],
        username: j['username'],
        email: j['email'],
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
      "username": username,
      "email": email,
      "description": description,
      "start_date": start_date,
      "end_date": end_date,
      "is_set": is_set,
      "lock_id": lock_id,
      "user_id": user_id
    };
  }
}
