import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bujo/classes/query.dart' as q;

class QueryRepo{

  final CollectionReference collection =
  FirebaseFirestore.instance.collection('query');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addQuery(q.Query instance) {
    return collection.add(instance.toJson());
  }

  void updateQuery(q.Query instance) async {
    await collection.doc(instance.referenceId).update(instance.toJson());
  }

  void addReply(q.Query instance) async{
    await collection.doc(instance.referenceId)
        .update({'replyList':FieldValue.arrayUnion([instance.replyList.last]),
    'replies':instance.replies});
  }

  void deleteQuery(q.Query instance) async {
    await collection.doc(instance.referenceId).delete();
  }

}