class LockModel {
  String? lockName;
  String? lockMac;
  String? lockData;
  int? status;
  int? idSerrure;
  int? percent;
  int? owner;

  LockModel({
    this.lockName,
    this.lockMac,
    this.lockData,
    this.status,
    this.idSerrure,
    this.percent,
    this.owner,
  });

  factory LockModel.fromJson(Map<dynamic, dynamic> j) {
    return LockModel(
      lockName: j['lock_name'] as String,
      lockMac: j['lock_mac'] as String,
      lockData: j['lock_data'] as String,
      status: j['auto_lock_time'] as int,
      idSerrure: j['id_lock'] as int,
      percent: j['lock_percent'] as int,
      owner: j['user_id'] as int,
    );
  }

  Map toMap() {
    return {
      "lock_name": lockName,
      "lock_mac": lockMac,
      "lock_data": lockData,
      "auto_lock_time": status,
      "id_lock": idSerrure,
      "lock_percent": percent,
      "user_id": owner
    };
  }

  void getLockAccess() {}
}
