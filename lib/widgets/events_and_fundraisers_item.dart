import 'package:bujo/app/mobile_storage.dart';
import 'package:bujo/app/show_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bujo/screens/event_details_screen.dart';
import 'package:bujo/classes/event.dart';
import 'package:progress_indicators/progress_indicators.dart';
Future<String> _getImage(BuildContext context, String image1) async {
  String m='';
  await FireStorageService.loadFromStorage(context, image1)
      .then((downloadUrl) {
    m=downloadUrl.toString();
  });

  return m;
}
//class EventsAndFundraisersItem extends StatelessWidget {
// class EventsAndFundraisersItem extends StatefulWidget {
//   static const routeName = '/semergencyDetailsScreen';
//   final Event instance;
//   final int ind;
//   EventsAndFundraisersItem(this.instance,this.ind);
//
//   @override
//   _EventsAndFundraisersItemState createState() => _EventsAndFundraisersItemState(this.instance,this.ind);
// }
//
// class _EventsAndFundraisersItemState extends State<EventsAndFundraisersItem> {
//   Event instance;
//   int ind;
//   bool isSaved = false;
//   _EventsAndFundraisersItemState(this.instance,this.ind);
//
// List<String> eventImages = [
//   'assets/event1.jpeg',
//   'assets/event2.jpeg',
//   'assets/event3.jpg',
//   'assets/event4.jpg',
//   'assets/event5.jpg'
// ];
// List<String> eventLoc = [
//   'Anna Library, Chennai',
//   'Gateway of India, Mumbai',
//   'India Gate, Delhi',
//   'Gandhi Street, Gandhi Nagar',
//   'Hyderabad Central, Hyderabad'
// ];

// List<Event> evn = [
//   Event('assets/event1.jpg','Anna Library, Chennai','31/10/21','Golden Time','6','Fundraiser'),
//   Event('assets/event2.jpg','Gateway of India, Mumbai','15/11/21','Revolutionary Lives','4','Adoption Drive'),
//   Event('assets/event3.jpg','India Gate, Delhi','12/12/21','Soul Bridge','3','Fundraiser'),
//   Event('assets/event4.jpg','Gandhi Street, Gandhi Nagar','17/10/21','Rise in Glory','2','Awareness Campaign'),
//   Event('assets/event5.jpg','Hyderabad Central, Hyderabad','15/12/21','Cross Connect','3','Marathon for Streeties'),
// ];
//
class EventsAndFundraisersItem extends StatefulWidget {

  final DocumentSnapshot ds;
  @override
  EventsAndFundraisersItem(this.ds);
  _EventsAndFundraisersItemState createState() => _EventsAndFundraisersItemState(this.ds);
}
//
 class _EventsAndFundraisersItemState extends State<EventsAndFundraisersItem> {
//   final Event instance;
   bool isSaved = false;
   DocumentSnapshot ds;
   _EventsAndFundraisersItemState(this.ds);
//   //final int ind;
//   _EventsAndFundraisersItemState(this.instance);

  //EventsAndFundraisersItem(this.ds);

  @override
  Widget build(BuildContext context) {
    final element = eventFromSnapshot(this.ds);
    return FutureBuilder<String>(
        future: _getImage(context, element.img),
    builder: (context, AsyncSnapshot<String> snapshot) {
    if (snapshot.hasData) {
    return InkWell(
      onTap: () {setState(() {});
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EventDetailsScreen(element)),
        );setState(() {});
        //Navigator.pushNamed(context, EventDetailsScreen.routeName);
      },
      child: Card(
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
                                  Spacer(),
                                  InkWell(
                                      child: Icon(
                                        isSaved
                                            ? Icons.notification_important
                                            : Icons.notification_important_outlined,
                                        color: isSaved
                                            ? Theme.of(context).primaryColor
                                            : Colors.white,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          isSaved = !isSaved;
                                        });
                                      })]),
                            Row(
                                children: [

                                  Text(
                                    element.date,
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
                              element.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              element.type,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowLocation(
                                  element.location
                                )),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              element.venue,
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
                        element.comments.toString() +' comments',
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
    );
  }
    else {
      return LinearProgressIndicator();
    }
    }
    );
  }
}