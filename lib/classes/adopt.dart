import 'package:cloud_firestore/cloud_firestore.dart';

class Adopt{
  //String img, city, state,
  String name, age,city,state, gender, type, avail,medicalcon,currdiet,add_dets,startdate,enddate,image1,image2,image3,image4;
  String? referenceId;
  Adopt(//this.img,
   this.name,this.age,this.gender,
      //this.city,
      this.medicalcon,this.currdiet,
  this.type,this.avail,this.add_dets,this.startdate,this.enddate,this.image1,this.image2,this.image3,this.image4,this.city,this.state);

  Map<String, dynamic> toJson() => <String, dynamic>{
    //'img': this.img,
    'name': this.name,
    'age': this.age,
    'gender': this.gender,

    'medicalcon': this.medicalcon,
    'type': this.type,
    'avail': this.avail,
    'currdiet':this.currdiet,
    'add_dets':this.add_dets,
    'image1':this.image1,
    'image2':this.image2,
    'image3':this.image3,
    'image4':this.image4,
    'city': this.city,
    'state': this.state,
    // vaccinations:
    // _convertVaccinations(json['vaccinations'] as List<dynamic>));
  };



// List<Map<String, dynamic>>? _vaccinationList(List<Vaccination>? vaccinations) {
//   if (vaccinations == null) {
//     return null;
//   }
//   final vaccinationMap = <Map<String, dynamic>>[];
//   vaccinations.forEach((vaccination) {
//     vaccinationMap.add(vaccination.toJson());
//   });
//   return vaccinationMap;
// }
}

Adopt adoptFromSnapshot(DocumentSnapshot snapshot) {
  return adoptFromJson(snapshot.data() as Map<String,dynamic>);
}

Adopt adoptFromJson(Map<String, dynamic> json) {
  return Adopt(
    //json['img'] as String,
    json['name'] as String,
    json['age'] as String,
    json['gender'] as String,
    //json['city'] as String,
    json['medicalcon'] as String,
    json['currdiet'] as String,
    json['type'] as String,
    json['avail'] as String,
    json['add_dets'] as String,
    json['startdate'] as String,
    json['enddate'] as String,
    json['image1'] as String,
    json['image2'] as String,
    json['image3'] as String,
    json['image4'] as String,
    json['city'] as String,
    json['state'] as String,
    // vaccinations:
    // _convertVaccinations(json['vaccinations'] as List<dynamic>)
  );
}