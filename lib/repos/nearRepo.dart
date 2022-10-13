import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bujo/classes/nearme.dart';

class NearRepo{

  final CollectionReference collection =
  FirebaseFirestore.instance.collection('near');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addNear(NearMe instance) {
    return collection.add(instance.toJson());
  }

  void updateEvent(NearMe instance) async {
    await collection.doc(instance.referenceId).update(instance.toJson());
  }

  void deleteEvent(NearMe instance) async {
    await collection.doc(instance.referenceId).delete();
  }

}