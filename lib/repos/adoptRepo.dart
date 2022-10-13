import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bujo/classes/adopt.dart';

class AdoptRepo{

  final CollectionReference collection =
  FirebaseFirestore.instance.collection('adopt');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addAdopt(Adopt instance) {
    return collection.add(instance.toJson());
  }

  void updateAdopt(Adopt instance) async {
    await collection.doc(instance.referenceId).update(instance.toJson());
  }

  void deleteAdopt(Adopt instance) async {
    await collection.doc(instance.referenceId).delete();
  }

}