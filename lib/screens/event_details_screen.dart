import 'dart:math';

import 'package:bujo/app/mobile_storage.dart';
import 'package:bujo/app/show_location.dart';
import 'package:bujo/classes/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bujo/widgets/form_field.dart';
import 'package:bujo/widgets/loader_button.dart';
import 'package:bujo/repos/eventRepo.dart';

Future<String> _getImage(BuildContext context, String image1) async {
  String m='';
  await FireStorageService.loadFromStorage(context, image1)
      .then((downloadUrl) {

    m=downloadUrl.toString();
  });

  return m;
}

class EventDetailsScreen extends StatefulWidget {
  static const routeName = '/eventDetails';
  final Event instance;

  EventDetailsScreen(this.instance);

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState(this.instance);
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  Event instance;
  var list = ['John Doe','Tejasri','Raja Sekhar','Arvindh A','Rama D', 'Karthik','Grace June'];
  final _random = new Random();
  _EventDetailsScreenState(this.instance);
  TextEditingController _commentController = TextEditingController();
  final repo = EventRepo();

//class EventDetails extends StatelessWidget {
  static const routeName = '/eventDetails';
//   @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _getImage(context, instance.img),
    builder: (context, AsyncSnapshot<String> snapshot) {
    if (snapshot.hasData) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        actions:[
          InkWell(
            onTap: () {
              setState(() {});
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowLocation(
                        instance.location
                    )
                ),
              );
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.location_on),
            ),
          )
        ]
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
                          onPressed: () async{
                            instance.addReply(_commentController.text);
                            await repo.updateEvent(instance);
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
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 10 / 5,
                      child: Container(
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: Image.network(
                                  snapshot.data!,
                                  fit: BoxFit.cover,
                                )),
                            Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Colors.black12, Colors.black87],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(
                                      children: [

                                        Text(
                                          instance.date,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w500),
                                        ),

                                        SizedBox(
                                          height: 8.0,
                                        ),

                                      ]),

                                  Text(
                                    instance.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    instance.type,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),


                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Venue',
                              style: TextStyle(color: Colors.grey),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {});
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowLocation(
                                        instance.location
                                      )),
                                );
                                setState(() {});
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    instance.venue,
                                    style: TextStyle(),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              instance.comments.toString() +' comments',
                              style: TextStyle(),
                            )
                          ],
                        )
                      ]),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text(
                'Comments('+instance.comments.toString()+')',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: (instance.commentList).map<Widget>(
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
            ),
          ],
        ),
      ),
    );
  }
    else {
      return Scaffold(
        appBar: AppBar(),
      );
    }
    }
    );
  }
}