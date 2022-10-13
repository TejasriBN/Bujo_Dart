import 'package:flutter/material.dart';
import 'package:bujo/widgets/loader_button.dart';
import 'package:bujo/classes/query.dart' as q;
import 'package:bujo/repos/queryRepo.dart';
import 'package:bujo/widgets/form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QueryCard extends StatefulWidget {

  final DocumentSnapshot ds;
  QueryCard(this.ds);

  @override
  _QueryCardState createState() => _QueryCardState(this.ds);
}

class _QueryCardState extends State<QueryCard> {

  QueryRepo repo = QueryRepo();
  final DocumentSnapshot ds;
  _QueryCardState(this.ds);
  bool isSaved = false;
  TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    q.Query element = q.queryFromSnapshot(ds);
    return Card(
        child: ExpansionTile(
            title: Text(element.question),
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
                      }),
                ]
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0),
                child: ListView(
                  shrinkWrap:true,
                  children: (element.replyList).map<Widget>(
                          (data) => ListTile(
                              title:Text(''),
                            subtitle: Text(data)
                          )
                  ).toList(),
                )
              ),

              TextButton.icon(
                  onPressed: () {
                    setState(() {});
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Container(
                          padding: MediaQuery
                              .of(context)
                              .viewInsets,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: [
                                  SizedBox(
                                    height: 32.0,
                                  ),
                                  Text(
                                    'Answer',
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight
                                            .bold),
                                  ),
                                  SizedBox(
                                    height: 32.0,
                                  ),
                                  GlobalFormField(
                                    hint: 'Answer',
                                    prefixIcon: Icons.help,
                                    isMultiLine: true,
                                    validator: (value) {},
                                    controller:_answerController
                                  ),

                                  SizedBox(
                                    height: 32.0,
                                  ),
                                  LoaderButton(
                                    btnTxt: 'Post Answer',
                                    onPressed: () {
                                      element.addReply(_answerController.text);
                                      repo.updateQuery(
                                          element);
                                      setState(() {});
                                      Navigator.pop(context);setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      32.0),
                                  topRight: Radius.circular(
                                      32.0))),
                        );
                      },
                    );
                    setState(() {});
                  },


                  icon: Icon(Icons.add),
                  label: Text('Add Answer'))
            ])
    );
    setState(() {});
  }
}