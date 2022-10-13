import 'package:cloud_firestore/cloud_firestore.dart';

class Request{
  String animal, breed, type, age, city, state, owner;
  String deadline;
  int amount;
  String? referenceId;

  Request(this.animal,this.breed,this.type,this.age,this.deadline,this.amount,this.city,this.state,this.owner);

  Map<String, dynamic> toJson() => <String, dynamic>{
    'animal': this.animal,
    'breed': this.breed,
    'type': this.type,
    'age': this.age,
    'deadline': this.deadline,
    'amount': this.amount,
    'city': this.city,
    'state': this.state,
    'owner': this.owner,
  };
}

Request requestFromSnapshot(DocumentSnapshot snapshot) {
  return requestFromJson(snapshot.id,snapshot.data() as Map<String,dynamic>);
}

Request requestFromJson(String id, Map<String, dynamic> json) {
  Request r = Request(
    json['animal'] as String,
    json['breed'] as String,
    json['type'] as String,
    json['age'] as String,
    json['deadline'] as String,
    json['amount'] as int,
    json['city'] as String,
    json['state'] as String,
    json['owner'] as String,
  );
  r.referenceId = id;
  return r;
}