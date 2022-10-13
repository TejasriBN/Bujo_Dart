import 'package:bujo/app/get_location.dart';
import 'package:bujo/app/show_location.dart';
import 'package:flutter/material.dart';
import 'package:bujo/screens/emergency_chat_screen.dart';
import 'package:bujo/classes/donor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// List<Donor> dns = [
//   Donor('German Shepherd','Dog','Robert','Chennai','Tamil Nadu','15 yrs','DEA-7','2 Days ago','35 Kg'),
//   Donor('Sahiwal','Cow','Manav','Dispur','Assam','12 yrs','F','3 Days ago','138 Kg'),
//   Donor('Greyhound','Dog','Walter','Bangalore','Karnataka','4 yrs','DEA-3','7 Days ago','38 Kg'),
//   Donor('British Shorthair','Cat','Kiara','Mumbai','Maharashtra','3 yrs','B','8 Days ago','7.7 Kg'),
//   Donor('Persian','Cat','Jamil','Panaji','Goa','3 yrs','A','8 Days ago','3.5 Kg'),
//   Donor('Arabian','Horse','Murfeet','Chennai','Tamil Nadu','7 yrs','C','8 Days ago','489 Kg'),
// ];

class DonorBloodDonationItem extends StatelessWidget {
  final DocumentSnapshot ds;
  DonorBloodDonationItem(this.ds);

  @override
  Widget build(BuildContext context) {
    final element = donorFromSnapshot(this.ds);
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
                      backgroundColor: Colors.greenAccent,
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
                            InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => ShowLocation(
                                //         element.location
                                //       )),
                                // );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_location_rounded,
                                    color: Colors.grey,
                                    size: 18.0,
                                  ),
                                  Text(
                                    element.city+', '+element.state,
                                    style: TextStyle(),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Age - '+element.age+' | Weight - '+element.weight.toString()+" Kg",
                              style: TextStyle(),
                            ),
                          ],
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
                                    launch("tel:04424462127");
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