import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bujo/classes/donor.dart';

class DonorRepo{

  final CollectionReference collection =
  FirebaseFirestore.instance.collection('donor');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addDonor(Donor instance) {
    return collection.add(instance.toJson());
  }

  void updateDonor(Donor instance) async {
    await collection.doc(instance.referenceId).update(instance.toJson());
  }

  void deleteDonor(Donor instance) async {
    await collection.doc(instance.referenceId).delete();
  }

}