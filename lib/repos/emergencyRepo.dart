import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bujo/classes/emergency.dart';

class EmergencyRepo{

  final CollectionReference collection =
  FirebaseFirestore.instance.collection('emergency');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addEmergency(Emergency instance) {
    return collection.add(instance.toJson());
  }

  void updateEmergency(Emergency instance) async {
    await collection.doc(instance.referenceId).update(instance.toJson());
  }

  void deleteEmergency(Emergency instance) async {
    await collection.doc(instance.referenceId).delete();
  }

}