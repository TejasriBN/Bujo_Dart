import 'package:cloud_firestore/cloud_firestore.dart';

class Donor{
  String animal, breed, type, age, city, state, owner;
  int weight;
  String? referenceId;

  Donor(this.animal,this.breed,this.type,this.age,this.weight,this.city,this.state,this.owner);

  Map<String, dynamic> toJson() => <String, dynamic>{
    'animal': this.animal,
    'breed': this.breed,
    'type': this.type,
    'age': this.age,
    'weight': this.weight,
    'city': this.city,
    'state': this.state,
    'owner': this.owner,
  };
}

Donor donorFromSnapshot(DocumentSnapshot snapshot) {
  return donorFromJson(snapshot.id,snapshot.data() as Map<String,dynamic>);
}

Donor donorFromJson(String id,Map<String, dynamic> json) {

  Donor d =  Donor(
    json['animal'] as String,
    json['breed'] as String,
    json['type'] as String,
    json['age'] as String,
    json['weight'] as int,
    json['city'] as String,
    json['state'] as String,
    json['owner'] as String,
  );
  d.referenceId = id;
  return d;
}