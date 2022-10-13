import 'package:bujo/app/mobile_storage.dart';
import 'package:bujo/app/show_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bujo/screens/emergency_details_screen.dart';
import 'package:bujo/classes/emergency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:progress_indicators/progress_indicators.dart';
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


class EmergencyCard extends StatelessWidget {

  // final List<Emergency> aet = [
  //   Emergency('Accident','Dog','Urgent','Chennai, Tamil Nadu'),
  //   Emergency('Injury','Cat','Low','Bangalore, Karnataka'),
  //   Emergency('Abuse','Horse','High','Bombay, Maharashtra'),
  //   Emergency('Injury','Cat','Medium','Pune, Maharashtra'),
  //   Emergency('Injury','Dog','High','Bangalore, Karnataka'),
  //   Emergency('Injury','Cat','High','Vellore, Tamil Nadu'),
  //   Emergency('Accident','Horse','Urgent','Hyderabad, Telangana'),
  //
  // ];


  final DocumentSnapshot ds;
  EmergencyCard(this.ds);


  @override
  Widget build(BuildContext context){
    final element = emergencyFromSnapshot(this.ds);
    return FutureBuilder<List<String>>(
        future: _getImage(context,element.image1,element.image2,element.image3,element.image4),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
    if (snapshot.hasData) {
    // List image= await _getImage(context,element.image1,element.image2,element.image3,element.image4) ;
    // String img1=_getImage(context,element.image1);
    // String img2=_getImage(context,element.image2);
    // String img3=_getImage(context,element.image3);
    // String img4=_getImage(context,element.image4);
    return Card(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    shape: RoundedRectangleBorder(
    side: BorderSide(color: Colors.white70, width: 1),
    borderRadius: BorderRadius.circular(16.0),
    ),
    child: InkWell(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => EmergencyDetailsScreen(element)),
    );
    },
    child: ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    child: Container(
    padding: EdgeInsets.all(16.0),
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
      width: 6.0,
      height: 42.0,
      decoration: BoxDecoration(
        color: element.col,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
    //StatusColorIndicator(element.col),
    SizedBox(
    width: 16.0,
    ),
    Expanded(
    flex: 8,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    Text(
    element.animal+' | '+element.type,
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    SizedBox(
    height: 4.0,
    ),


      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowLocation(element.location)
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:  Row(
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
        ),
      ),



    SizedBox(
    height: 16.0,
    ),
    //FourImageTiles(element.col,1)
    Row(
    children: [
    ClipOval(
    child: new Container(
    height: 30.0,
    width: 30.0,
    child: Image.network(snapshot.data![0])
    // child: new Image.network(
    //   animalImages[this.type][0],
    //   fit: BoxFit.fill,
    // )
    ),
    ),
    Transform.translate(
    offset: Offset(-4.0, 0.0),
    child: ClipOval(
    child: new Container(
    height: 30.0,
    width: 30.0,
    child: Image.network(snapshot.data![1])
    // child: new Image.network(
    //   animalImages[this.type][1],
    //   fit: BoxFit.fill,
    // )
    ),
    ),
    ),
    Transform.translate(
    offset: Offset(-6.0, 0.0),
    child: ClipOval(
    child: new Container(
    height: 30.0,
    width: 30.0,
    child: Image.network(snapshot.data![2])
    // child: new Image.network(
    //   animalImages[this.type][2],
    //   fit: BoxFit.fill,
    // )
    ),
    ),
    ),
    Transform.translate(
    offset: Offset(-8.0, 0.0),
    child: ClipOval(
    child: new Container(
    height: 30.0,
    width: 30.0,
    child: Image.network(snapshot.data![3])
    // new Image.network(
    //   animalImages[this.type][3],
    //   fit: BoxFit.fill,
    // )
    ),
    ),
    ),
    ],
    ),
    ],
    ),
    ),
      Container(
        width:110,
        decoration: BoxDecoration(
          color: element.col,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning,
                color: Colors.white,
                size: 16.0,
              ),
              SizedBox(
                width: 4.0,
              ),
              Text(
                element.urgency,
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              ),
            ],
          ),
        ),
      )
    //StatusTag(element.col,element.urgency),
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
//
// class StatusColorIndicator extends StatelessWidget {
//   final Color col;
//   StatusColorIndicator(this.col);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 6.0,
//       height: 42.0,
//       decoration: BoxDecoration(
//         color: this.col,
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//       ),
//     );
//   }
// }
//
// class StatusTag extends StatelessWidget {
//   final Color col;
//   final String emerge;
//   StatusTag(this.col,this.emerge);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width:110,
//       decoration: BoxDecoration(
//         color: col,
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               Icons.warning,
//               color: Colors.white,
//               size: 16.0,
//             ),
//             SizedBox(
//               width: 4.0,
//             ),
//             Text(
//               emerge,
//               style: TextStyle(color: Colors.white, fontSize: 12.0),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

