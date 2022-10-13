import 'package:flutter/material.dart';
import 'package:bujo/screens/emergency_chat_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodDonationItem extends StatelessWidget {
  final String type;

  const BloodDonationItem({this.type = 'Available'});

  @override
  Widget build(BuildContext context) {
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
                      backgroundColor:
                          type == 'Available' ? Colors.green : Colors.redAccent,
                      radius: 32.0,
                      child: Text(
                        'A+',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
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
                      'Rott willer - Dog',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.0),
                    ),
                    Text(
                      'By John Doe',
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
                          'Chennai, TamilNadu',
                          style: TextStyle(),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Age - 25yrs | Deadline - 11/12/2021',
                          style: TextStyle(),
                        ),
                      ],
                    ),
                    Text(
                      'Reuirement- 5 Pints',
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
                                ////launch("tel://9876543210");
                              },
                              icon: Icon(Icons.call),
                              label: Text('Call')),
                        ),
                        SizedBox(
                          width: 14.0,
                        ),
                        Expanded(
                          child: TextButton.icon(
                              style: TextButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(34.0),
                                      side: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor))),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, EmergencyChatScreen.routeName);
                              },
                              icon: Icon(Icons.chat),
                              label: Text('Chat')),
                        )
                      ],
                    )
                  ],
                ))
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                '5 days ago',
                style: TextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
