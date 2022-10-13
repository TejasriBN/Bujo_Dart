import 'package:cloud_firestore/cloud_firestore.dart';

class Query{
  String question;
  int replies=0;
  List<String> replyList = [];
  String? referenceId;

  Query(this.question);

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

Query queryFromSnapshot(DocumentSnapshot snapshot) {
  return queryFromJson(snapshot.id,snapshot.data() as Map<String,dynamic>);
}


Query queryFromJson(String id,Map<String, dynamic> json) {
  Query q = Query(
    json['question'] as String,
  );
  q.replies = json['replies'] as int;
  q.referenceId=id;
  if(json['replyList']!=null)
    q.replyList = (json['replyList'] as List<dynamic>).cast<String>();
  return q;
}