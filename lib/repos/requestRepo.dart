import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bujo/classes/request.dart';

class RequestRepo{

  final CollectionReference collection =
  FirebaseFirestore.instance.collection('request');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addRequest(Request instance) {
    return collection.add(instance.toJson());
  }

  void updateRequest(Request instance) async {
    await collection.doc(instance.referenceId).update(instance.toJson());
  }

  void deleteRequest(Request instance) async {
    await collection.doc(instance.referenceId).delete();
  }

}