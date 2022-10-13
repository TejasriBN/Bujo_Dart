import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bujo/classes/forum.dart';

class ForumRepo{

  final CollectionReference collection =
  FirebaseFirestore.instance.collection('forum');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addForum(Forum instance) {
    return collection.add(instance.toJson());
  }

  void updateForum(Forum instance) async {
    await collection.doc(instance.referenceId).update(instance.toJson());
  }

  void addReply(Forum instance) async {
    await collection.doc(instance.referenceId)
        .update({'replyList':FieldValue.arrayUnion(
        [instance.replyList.last]
          ),
      'replies':instance.replies
    });
  }

  void deleteForum(Forum instance) async {
    await collection.doc(instance.referenceId).delete();
  }

}