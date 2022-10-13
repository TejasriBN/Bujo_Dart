import 'package:bujo/app/mobile_storage.dart';
import 'package:bujo/app/videocall.dart';
import 'package:bujo/classes/adopt.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:url_launcher/url_launcher.dart';

import 'emergency_chat_screen.dart';
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
class AdoptionDetailsScreen extends StatefulWidget {
  static const routeName = '/adoptionDetailsScreen';
  final Adopt instance;
  AdoptionDetailsScreen(this.instance);
  @override
  _AdoptionDetailsScreenState createState() => _AdoptionDetailsScreenState(this.instance);
}

class _AdoptionDetailsScreenState extends State<AdoptionDetailsScreen> {
  Adopt instance;
  _AdoptionDetailsScreenState(this.instance);
  // List<String> animalImages = [
  //   'assets/gin1.jpg',
  //   'assets/gin2.jpg',
  //   'assets/gin3.jpg'
  // ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: _getImage(
        context, instance.image1, instance.image2, instance.image3,         instance.image4),
    builder: (context, AsyncSnapshot<List<String>> snapshot) {
    if (snapshot.hasData) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('About'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VideoCallW()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.videocam),
            ),
          ),
          InkWell(
            onTap: () {
              launch("tel:8510036563");
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.call),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {});
              Navigator.of(context).pushNamed(EmergencyChatScreen.routeName);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.chat),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            height: MediaQuery.of(context).size.height * 0.3,
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
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
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
                            'Name',
                            style: TextStyle(color: Colors.grey),
                          )),
                      Expanded(
                          flex: 6,
                          child: Text(
                            instance.name,
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
                            'Age',
                            style: TextStyle(color: Colors.grey),
                          )),
                      Expanded(
                          flex: 6,
                          child: Text(
                            instance.age,
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
                            'Gender',
                            style: TextStyle(color: Colors.grey),
                          )
                      ),
                      Expanded(
                          flex: 6,
                          child: Text(
                            instance.gender,
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
                            'Type',
                            style: TextStyle(color: Colors.grey),
                          )),
                      Expanded(
                          flex: 6,
                          child: Text(
                            instance.avail,
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
                  // Row(
                  //   children: <Widget>[
                  //     Expanded(
                  //         flex: 4,
                  //         child: Text(
                  //           'Duration',
                  //           style: TextStyle(color: Colors.grey),
                  //         )),
                  //     Expanded(
                  //         flex: 6,
                  //         child: Text(
                  //           '-',
                  //           style: TextStyle(color: Colors.black),
                  //         )),
                  //   ],
                  // ),
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
                    'Medical Condition',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    instance.medicalcon,
                    style: TextStyle(color: Colors.black),
                  )
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
                    'Current Diet',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    instance.currdiet,
                    style: TextStyle(color: Colors.black),
                  )
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
                    instance.add_dets,
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        ]),
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
