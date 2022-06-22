class CardModel{
  int? id;
  String? card;
  String? description;
  String? start_date;
  String? end_date;
  int? is_set;
  int? lock_id;
  int? user_id;

  CardModel({this.id,this.card,this.description,this.start_date,this.end_date,this.is_set,this.lock_id,this.user_id});

  factory CardModel.fromJson(Map j){
    return CardModel(
        id:j['id'],
        card:j['card'],
        description:j['description'],
        start_date:j['start_date'],
        end_date:j['end_date'],
        is_set:j['is_set'],
        lock_id: j['lock_id'],
        user_id:j['user_id']
    );
  }


  Map toMap(){
    return {
      "id": id,
      "code": card,
      "description": description,
      "start_date": start_date,
      "end_date": end_date,
      "is_set": is_set,
      "lock_id": lock_id,
      "user_id": user_id
    };
  }
}