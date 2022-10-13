import 'package:bujo/app/get_location.dart';
import 'package:bujo/app/mobile_storage.dart';
import 'package:bujo/app/show_location.dart';
import 'package:bujo/app/videocall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bujo/classes/emergency.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:url_launcher/url_launcher.dart';

Future<List<String>> _getImage(BuildContext context, String image1, String image2, String image3, String image4) async {
  List<String> m=['','','',''];
  await FireStorageService.loadFromStorage(context, image1)
      .then((downloadUrl) {
    // m = Image.network(
    //   downloadUrl.toString(),
    //   fit: BoxFit.scaleDown,
    // );
    m[0]=downloadUrl.toString();
  });
  //print(m[0]);
  await FireStorageService.loadFromStorage(context, image2)
      .then((downloadUrl) {
    m[1]=downloadUrl.toString();
  });
  //print(m[1]);
  await FireStorageService.loadFromStorage(context, image3)
      .then((downloadUrl) {
    m[2]=downloadUrl.toString();
  });
  //print(m[2]);
  await FireStorageService.loadFromStorage(context, image4)
      .then((downloadUrl) {
    m[3]=downloadUrl.toString();
  });
  //print(m[3]);
  return m;
}

class EmergencyDetailsScreen extends StatefulWidget {
  static const routeName = '/semergencyDetailsScreen';
  final Emergency instance;
  EmergencyDetailsScreen(this.instance);

  @override
  _EmergencyDetailsScreenState createState() => _EmergencyDetailsScreenState(this.instance);
}

class _EmergencyDetailsScreenState extends State<EmergencyDetailsScreen> {
  Emergency instance;

  _EmergencyDetailsScreenState(this.instance);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: _getImage(
            context, instance.image1, instance.image2, instance.image3,
            instance.image4),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.grey.shade200,
              appBar: AppBar(
                title: Text('Emergency Details'),
                actions: [
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => VideoCallW()
                      //   ),
                      // );
                      launch("tel:9445576865");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.call),
                    ),
                  ),
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
                ],
              ),
              body: Column(children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.3,
                  child: PageView.builder(
                      itemCount: snapshot.data!.length,
                      controller: PageController(viewportFraction: 0.75),
                      itemBuilder: (ctx, index) {
                        return Image.network(snapshot.data![index]);
                      }),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Summary',
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Animal',
                                  style: TextStyle(color: Colors.grey),
                                )),
                            Expanded(
                                flex: 6,
                                child: Text(
                                  instance.animal,
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        ),
                        Divider(
                          thickness: 1.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Distress Level',
                                  style: TextStyle(color: Colors.grey),
                                )),
                            Expanded(
                                flex: 6,
                                child: Text(
                                  instance.urgency,
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        ),
                        Divider(
                          thickness: 1.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Situation',
                                  style: TextStyle(color: Colors.grey),
                                )),
                            Expanded(
                                flex: 6,
                                child: Text(
                                  instance.type,
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        ),
                        Divider(
                          thickness: 1.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Location',
                                  style: TextStyle(color: Colors.grey),
                                )),
                            Expanded(
                                flex: 6,
                                child: Text(
                                  instance.city+', '+instance.state,
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        ),
                        Divider(
                          thickness: 1.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Additional Details',
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          instance.description,
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
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