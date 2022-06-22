class ShareCodeModel {
  int? id;
  String? code;
  String? description;
  String? start_date;
  String? end_date;
  int? is_set;
  String? username;
  String? email;

  ShareCodeModel(
      {this.id,
      this.code,
      this.description,
      this.start_date,
      this.end_date,
      this.is_set,
      this.username,
      this.email});

  factory ShareCodeModel.fromJson(Map j) {
    return ShareCodeModel(
        id: j['id'],
        code: j['code'],
        description: j['description'],
        start_date: j['start_date'],
        end_date: j['end_date'],
        is_set: j['is_set'],
        username: j['username'],
        email: j['email']);
  }

  Map toMap() {
    return {
      "id": id,
      "code": code,
      "description": description,
      "start_date": start_date,
      "end_date": end_date,
      "is_set": is_set,
      "username": username,
      "email": email
    };
  }
}
