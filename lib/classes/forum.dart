import 'package:cloud_firestore/cloud_firestore.dart';

class Forum{
  String? referenceId;
  String question;
  int replies=0;
  List<String> replyList = [];

  Forum(this.question);

  Map<String, dynamic> toJson() => <String, dynamic>{
    'question': this.question,
    'replies': this.replies,
    'replyList': this.replyList
  };

  void addReply(String reply){
    this.replyList.add(reply);
    this.replies+=1;
  }
}

Forum forumFromJson(String id, Map<String, dynamic> json) {
  Forum q = Forum(
    json['question'] as String,
  );
  q.referenceId = id;
  q.replies = json['replies'] as int;
  if(json['replyList']!=null)
    q.replyList = (json['replyList'] as List<dynamic>).cast<String>();
  return q;
}

Forum forumFromSnapshot(DocumentSnapshot snapshot) {
  return forumFromJson(snapshot.id,snapshot.data() as Map<String,dynamic>);
}