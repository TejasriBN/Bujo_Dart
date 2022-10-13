import 'package:bujo/app/mobile_storage.dart';
import 'package:bujo/app/show_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bujo/screens/adoption_details_screen.dart';
import 'package:bujo/classes/adopt.dart';
import 'package:progress_indicators/progress_indicators.dart';
Future<String> _getImage(BuildContext context, String image1) async {
  String m='';
  await FireStorageService.loadFromStorage(context, image1)
      .then((downloadUrl) {
    // m = Image.network(
    //   downloadUrl.toString(),
    //   fit: BoxFit.scaleDown,
    // );
    m=downloadUrl.toString();
  });

  return m;
}

class AdoptionListItem extends StatefulWidget {
  // final int ind;
  // AdoptionListItem(this.ind);
  final DocumentSnapshot ds;
  @override
  AdoptionListItem(this.ds);
  _AdoptionListItemState createState() => _AdoptionListItemState(this.ds);

}
//
// List<Adopt> pad = [
//
//   Adopt('assets/jago.jpg','Jago','6 yrs','Male','Bengaluru','Karnataka','Dog','Adoption/Foster'),
//   Adopt('assets/gin1.jpg','Yuta','4 yrs','Male','Chennai','Tamil Nadu','Cat','Adoption'),
//   Adopt('assets/quart.jpg','Quart','2 months','Female','Madurai','Tamil Nadu','Dog','Foster'),
//   Adopt('assets/mink.jpg','Mink','4 yrs','Female','Hyderabad','Telangana','Turtle','Adoption/Foster'),
//   Adopt('assets/Quall.jpg','Quall','2 yrs','Female','Chennai','Tamil Nadu','Duck','Adoption'),
//   Adopt('assets/jago.jpg','Hilo','6 yrs','Male','Bengaluru','Karnataka','Dog','Adoption/Foster'),
//   Adopt('assets/yuta.jpg','Mushu','4 yrs','Male','Chennai','Tamil Nadu','Cat','Adoption'),
// ];

class _AdoptionListItemState extends State<AdoptionListItem> {
  //int ind;
  DocumentSnapshot ds;

  _AdoptionListItemState(this.ds);

  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    final element = adoptFromSnapshot(this.ds);
    return FutureBuilder<String>(
        future: _getImage(context, element.image1),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () {
                  setState(() {});
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdoptionDetailsScreen(element)),
                  );setState(() {});
                },
                child: Card(
                  shape:
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 0.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.orange,
                                child: ClipOval(
                                  child: Image.network(snapshot.data!),
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    element.name + ' | ' + element.age + ' | ' +
                                        element.gender,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           ShowLocation(
                                          //             element.location
                                          //           )),
                                          // );
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
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
                                ],
                              ),
                              Spacer(),
                              InkWell(
                                  child: Icon(
                                    isSaved
                                        ? Icons.bookmark_rounded
                                        : Icons.bookmark_border,
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
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Available For',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0),
                                ),
                                Text(
                                  element.avail,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Animal Type',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0),
                                ),
                                Text(
                                  element.type,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
