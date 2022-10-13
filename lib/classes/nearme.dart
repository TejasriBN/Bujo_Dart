import 'package:cloud_firestore/cloud_firestore.dart';
import'package:google_maps_flutter/google_maps_flutter.dart';

class NearMe{
  String title, commodity,s1,s2,s3,phone;
  LatLng location = LatLng(0,0);
  NearMe(this.title,this.commodity,this.s1,this.s2,this.s3,this.phone);
  String? referenceId;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'title': this.title,
    'commodity': this.commodity,
    'location': GeoPoint(this.location.latitude,this.location.longitude),
    's1': this.s1,
    's2': this.s2,
    's3': this.s3,
    'phone': this.phone
  };

  void fixLocation(double lat,double lng){
    this.location=LatLng(lat,lng);
  }

}

NearMe nearFromSnapshot(DocumentSnapshot snapshot) {
  return nearFromJson(snapshot.id,snapshot.data() as Map<String,dynamic>);
}

NearMe nearFromJson(String id,Map<String, dynamic> json) {
  GeoPoint g = json['location'] as GeoPoint;
  NearMe instance = NearMe(
    json['title'] as String,
    json['commodity'] as String,
    json['s1'] as String,
    json['s2'] as String,
    json['s3'] as String,
    json['phone'] as String,
  );
  instance.fixLocation(g.latitude,g.longitude);
  instance.referenceId = id;
  return instance;
}