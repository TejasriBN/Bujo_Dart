import 'package:flutter/material.dart';
import 'package:bujo/screens/thread_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bujo/repos/forumRepo.dart';
import 'package:bujo/classes/forum.dart';

class ForumCard extends StatefulWidget {

  final DocumentSnapshot ds;
  ForumCard(this.ds);

  @override
  _ForumCardState createState() => _ForumCardState(this.ds);
}

class _ForumCardState extends State<ForumCard> {

  ForumRepo repo = ForumRepo();
  final DocumentSnapshot ds;

  _ForumCardState(this.ds);

  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    Forum element = forumFromSnapshot(ds);
    return Card(
        child: ListTile(
          title: Text(
            element.question
          ),
          subtitle: Row(
              children: [
                Text(element.replies.toString()+' replies'),
                Spacer(),
                InkWell(
                    child: Icon(
                      isSaved
                          ? Icons.star
                          : Icons.star_border,
                      color: isSaved
                          ? Theme
                          .of(context)
                          .primaryColor
                          : Colors.black,
                    ),
                    onTap: () {
                      setState(() {
                        isSaved = !isSaved;
                      });
                    })
              ]
          ),
          trailing: Icon(Icons.chevron_right),
          onTap: () {setState(() {});
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ThreadScreen(element)),
            );setState(() {});
          },
        )
    );
  }

}