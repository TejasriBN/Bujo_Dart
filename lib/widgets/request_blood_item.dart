import 'package:flutter/material.dart';
import 'package:bujo/screens/emergency_chat_screen.dart';
import 'package:bujo/classes/request.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// List<Request> dns = [
//   Request('British Shorthair','Cat','Kiara','Mumbai','Maharashtra','3 yrs','A','12/10/21',1,'8 Days ago'),
//   Request('Arabian','Horse','Murfeet','Chennai','Tamil Nadu','7 yrs','C','10/11/21',4,'8 Days ago'),
//   Request('Greyhound','Dog','Walter','Bangalore','Karnataka','4 yrs','DEA-3','21/10/21',1,'7 Days ago'),
//   Request('Sahiwal','Cow','Manav','Dispur','Assam','12 yrs','F','5/10/21',3,'3 Days ago'),
//   Request('Persian','Cat','Jamil','Panaji','Goa','3 yrs','B','15/10/21',1,'8 Days ago'),
//   Request('German Shepherd','Dog','Robert','Chennai','Tamil Nadu','15 yrs','DEA-7','10/11/21',1,'2 Days ago'),
// ];

class RequestBloodDonationItem extends StatelessWidget {
  final DocumentSnapshot ds;
  RequestBloodDonationItem(this.ds);

  @override
  Widget build(BuildContext context) {
    Request element = requestFromSnapshot(this.ds);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: 32.0,
                      child: Text(
                        element.type,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          element.breed+' - '+element.animal,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                        Text(
                          'By '+element.owner,
                          style: TextStyle(decoration: TextDecoration.underline),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.add_location_rounded,
                              color: Colors.grey,
                              size: 18.0,
                            ),
                            Text(
                              element.city+', '+element.state,
                              style: TextStyle(),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Age - '+element.age+ ' | Deadline - '+element.deadline,
                              style: TextStyle(),
                            ),
                          ],
                        ),
                        Text(
                          'Requirement - '+element.amount.toString()+' Pint',
                          style: TextStyle(),
                        ),
                        SizedBox(
                          height: 14.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(34.0))),
                                  onPressed: () {
                                    launch("tel:04424463147");
                                  },
                                  icon: Icon(Icons.call),
                                  label: Text('Call')),
                            ),
                            SizedBox(
                              width: 14.0,
                            ),
                            Expanded(
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(34.0))),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, EmergencyChatScreen.routeName);
                                  },
                                  icon: Icon(Icons.chat),
                                  label: Text('Chat')),
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            ),
            // Align(
            //   alignment: Alignment.topRight,
            //   child: Text(
            //     element.posted,
            //     style: TextStyle(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}