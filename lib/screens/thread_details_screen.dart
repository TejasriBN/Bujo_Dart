import 'dart:math';

import 'package:flutter/material.dart';
import 'package:bujo/widgets/form_field.dart';
import 'package:bujo/widgets/loader_button.dart';
import 'package:bujo/classes/forum.dart';
import 'package:bujo/repos/forumRepo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ThreadScreen extends StatefulWidget {
  static const routeName = '/threadScreen';

  final Forum element;
  ThreadScreen(this.element);
  @override
  _ThreadScreenState createState() => _ThreadScreenState(this.element);
}

class _ThreadScreenState extends State<ThreadScreen> {
  _ThreadScreenState(this.element);
  var list = ['John Doe','Tejasri','Raja Sekhar','Arvindh A','Rama D', 'Karthik','Grace June'];
  final _random = new Random();
  final Forum element;
  TextEditingController _commentController = TextEditingController();
  ForumRepo repo = ForumRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Container(
                padding: MediaQuery.of(context).viewInsets,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 32.0,
                        ),
                        Text(
                          'Post Comment.',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        GlobalFormField(
                          hint: 'Comment',
                          prefixIcon: Icons.help,
                          isMultiLine: true,
                          validator: (value) {},
                          controller: _commentController
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        LoaderButton(
                          btnTxt: 'Post Comment',
                          onPressed: () {
                            element.addReply(_commentController.text);
                            repo.updateForum(element);
                            setState(() {});
                            Navigator.pop(context);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0))),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(' '),
                    subtitle: Text('Today'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Original Post ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      element.question
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text(
                'Replies('+element.replies.toString()+')',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: (element.replyList).map<Widget>(
              (data) => Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(list[_random.nextInt(list.length)]),

                    subtitle: Text('5m ago'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      data
                    ),
                  )
                ],
              ),
            )

            ).toList()
  )

          ],
        ),
      ),
    );
  }
}
