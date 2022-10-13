import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Emergency{

  Color col=Colors.red;
  String type, animal, urgency, description='Please help soon',image1,image2,image3,image4,city,state;
  LatLng location = LatLng(12.999263876711556, 80.25930255153484);
  String? referenceId;

  void pickColour(){
    switch(this.urgency){
      case 'Urgent':
        this.col=Colors.red;break;
      case 'High':
        this.col=Colors.orange;break;
      case 'Medium':
        this.col=Colors.yellow;break;
      case 'Low':
        this.col=Colors.green;break;
    }
  }

  void fixLocation(double lat,double lng){
    location = LatLng(lat,lng);
  }

  void fixDescription(String? description){
    if(description!=null)
      this.description=description;
  }

  Emergency(this.type,this.animal,this.urgency,this.image1,this.image2,this.image3,this.image4,this.city,this.state){
    pickColour();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': this.type,
    'animal': this.animal,
    'urgency': this.urgency,
    'description': this.description,
    'location': GeoPoint(this.location.latitude,this.location.longitude),
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

Emergency emergencyFromSnapshot(DocumentSnapshot snapshot) {
  return emergencyFromJson(snapshot.data() as Map<String,dynamic>);
}

Emergency emergencyFromJson(Map<String, dynamic> json) {
  GeoPoint g = json['location'] as GeoPoint;
  Emergency instance = Emergency(
    json['type'] as String,
    json['animal'] as String,
    json['urgency'] as String,
    json['image1'] as String,
    json['image2'] as String,
    json['image3'] as String,
    json['image4'] as String,
    json['city'] as String,
    json['state'] as String,
  );

  instance.fixDescription(json['description'] as String);
  instance.fixLocation(g.latitude,g.longitude);

  return instance;
}