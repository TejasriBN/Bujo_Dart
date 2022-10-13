import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Event{

  String img,venue,name,type;
  int comments=0;
  List<String> commentList = [];
  String date;
  LatLng location = LatLng(0,0);
  String? referenceId;
  Event(this.img,this.venue,this.date,this.name,this.type);

  Map<String, dynamic> toJson() => <String, dynamic>{
    'img': this.img,
    'venue': this.venue,
    'date': this.date,
    'name': this.name,
    'comments': this.comments,
    'type': this.type,
    'commentList': this.commentList,
    'location': GeoPoint(this.location.latitude,this.location.longitude),
  };

  void addReply(String reply){
    this.commentList.add(reply);
    this.comments+=1;
  }

  void fixLocation(double lat,double lng){
    this.location = LatLng(lat,lng);
  }

}

Event eventFromSnapshot(DocumentSnapshot snapshot) {
  return eventFromJson(snapshot.id,snapshot.data() as Map<String,dynamic>);
}

Event eventFromJson(String id, Map<String, dynamic> json) {
  GeoPoint g = json['location'] as GeoPoint;
  Event instance = Event(
    json['img'] as String,
    json['venue'] as String,
    json['date'] as String,
    json['name'] as String,
    json['type'] as String,
  );
  instance.comments = json['comments'] as int;
  if(json['commentList']!=null){
    instance.commentList = (
        json['commentList'] as List<dynamic>)
        .cast<String>();
  }
  instance.referenceId = id;
  instance.fixLocation(g.latitude,g.longitude);
  return instance;
}