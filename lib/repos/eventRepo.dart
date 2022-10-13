import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bujo/classes/event.dart';

class EventRepo{

  final CollectionReference collection =
  FirebaseFirestore.instance.collection('event');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addEvent(Event instance) {
    return collection.add(instance.toJson());
  }

  Future<void> updateEvent(Event instance) async {
    await collection.doc(instance.referenceId).update(instance.toJson());
  }

  Future<void> deleteEvent(Event instance) async {
    await collection.doc(instance.referenceId).delete();
  }

}