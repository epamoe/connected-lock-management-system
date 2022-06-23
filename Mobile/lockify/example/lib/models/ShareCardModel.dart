class ShareCardModel {
  int? id;
  String? card;
  String? description;
  String? start_date;
  String? end_date;
  int? is_set;
  String? username;
  String? email;

  ShareCardModel(
      {this.id,
      this.card,
      this.description,
      this.start_date,
      this.end_date,
      this.is_set,
      this.username,
      this.email});

  factory ShareCardModel.fromJson(Map j) {
    return ShareCardModel(
        id: j['id'],
        card: j['card'],
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
      "card": card,
      "description": description,
      "start_date": start_date,
      "end_date": end_date,
      "is_set": is_set,
      "username": username,
      "email": email
    };
  }
}
