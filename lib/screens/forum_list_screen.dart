import 'package:flutter/material.dart';
import 'package:bujo/screens/thread_details_screen.dart';
import 'package:bujo/widgets/form_field.dart';
import 'package:bujo/widgets/loader_button.dart';
import 'package:bujo/repos/forumRepo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bujo/widgets/navigation_drawer.dart';
import 'package:bujo/widgets/forum_card.dart';
import 'package:bujo/classes/forum.dart';

class ForumList extends StatefulWidget {
  static const routeName = '/forumList';

  @override
  _ForumListState createState() => _ForumListState();
}

class _ForumListState extends State<ForumList> {

  ForumRepo repo = ForumRepo();
  TextEditingController _forumController = TextEditingController();
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      floatingActionButton: FloatingActionButton.extended(
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
                          'New Thread.',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        // GlobalFormField(
                        //   hint: 'Title',
                        //   prefixIcon: Icons.help,
                        //   validator: (value) {},
                        // ),
                        // SizedBox(
                        //   height: 32.0,
                        // ),
                        GlobalFormField(
                          hint: 'Topic',
                          prefixIcon: Icons.help,
                          isMultiLine: true,
                          validator: (value) {},
                          controller: _forumController
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        LoaderButton(
                          btnTxt: 'Post',
                          onPressed: () {
                            repo.addForum(
                              Forum(_forumController.text)
                            );
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
        label: Text('Start Thread'),
        icon: Icon(Icons.forum_outlined),
      ),
      appBar: AppBar(
        title: Text('Forum'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: repo.getStream(),
        builder: (context,snapshot){
          return ListView(
            children: (snapshot.data?.docs ?? []).map(
                    (data) => ForumCard(data)
        ).toList()
        );

      }),
    );
  }
}