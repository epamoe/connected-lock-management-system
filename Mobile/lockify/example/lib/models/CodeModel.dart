class CostumCodeModel{
  int? id;
  String? code;
  String? description;
  String? start_date;
  String? end_date;
  int? is_set;
  int? lock_id;
  int? user_id;

  CostumCodeModel({this.id,this.code,this.description,this.start_date,this.end_date,this.is_set,this.lock_id,this.user_id});

  factory CostumCodeModel.fromJson(Map j){
    return CostumCodeModel(
      id:j['id'],
      code:j['code'],
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
      "code": code,
      "description": description,
      "start_date": start_date,
      "end_date": end_date,
      "is_set": is_set,
      "lock_id": lock_id,
      "user_id": user_id
    };
  }
}