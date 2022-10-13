import 'dart:io';
import 'package:location/location.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:bujo/app/get_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:bujo/widgets/drop_down_button.dart';
import 'package:bujo/widgets/form_field.dart';
import 'package:bujo/widgets/loader_button.dart';
import 'package:bujo/classes/emergency.dart';
import 'package:bujo/repos/emergencyRepo.dart';

class CreateDistressScreen extends StatefulWidget {
  static const routeName = '/createDistress';

  @override
  _CreateDistressScreenState createState() => _CreateDistressScreenState();
}

class _CreateDistressScreenState extends State<CreateDistressScreen> {
  final picker = ImagePicker();
  late File _imageFile;
  late String x;
  late String b;


  Future<String> uploadImageToFirebase() async {

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imageFile = File(image.path);

      String fileName = basename(_imageFile.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      b="imageFile" + DateTime.now().toString();
      Reference ref = storage.ref().child(b);
      //print("ref");
      //print(ref);
      UploadTask uploadTask = ref.putFile(_imageFile);
      uploadTask.then((res) async {
        final s= await res.ref.getDownloadURL();
        x=s;

        ////print("inside upload x");
        ////print(x);
        var a =_imageFile.path;
        ////print(a.split("/").last.split('.').last);

        ////print("inside upload res");
        ////print(res);
        b=b+"."+a.split("/").last.split('.').last;
        return b;
      });
    }
    return ' ';

  }
  int count=0;
  String up='Upload 4 Animal Images';
  TextEditingController _description = TextEditingController();
  TextEditingController _sitOther = TextEditingController();
  TextEditingController _aniOther = TextEditingController();
  double distressLevel = 0;
  bool isOthers = false;
  bool isSitOther=false;
  List<String> abc = ['', '', '',''];
  //String abc='';
  final repo = EmergencyRepo();
  Emergency instance = Emergency(
      'Accident','','High','','','','',"Chennai","Tamil Nadu"
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Distress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(
              height: 32.0,
            ),
            Center(
                child: InkWell(
                    onTap: () async{
                      abc[count]= await uploadImageToFirebase();
                      abc[count]=b;
                      //var s=abc[count]; //.split('/');
                      //abc[count]=s.last;
                      //print('abc[count]' + '    '+ abc[count]);
                      count=count+1;
                      if(count>0 && count<4)
                      {
                        up=count.toString();
                        up=up+ " Images uploaded. Upload ";
                        var d = (4-count).toString();
                        up=up+d+" more images.";
                      }
                      if(count==4)
                      {
                        up="4 Images uploaded.";
                        //print(up);
                      }

                      setState((){});
                      //print("Upload clicked");
                      // //print("abc");
                      // //print(abc);
                    },
                    child: Container(
                      height: 200.0,
                      width: 200.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.upload_rounded,
                            color: Theme.of(context).primaryColor,
                            size: 42.0,
                          ),
                          Text(
                            up,
                            style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14.0),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0)),
                    )
                )
            ),
            SizedBox(
              height: 32.0,
            ),
            Text('Distress Level*'),
            SliderTheme(
              data: SliderThemeData(
                thumbColor: instance.col,
                activeTrackColor: instance.col,
              ),
              child: Slider(
                min: 0,
                max: 3,
                divisions: 3,
                label: instance.urgency,
                value: distressLevel,
                onChanged: (value) {
                  setState(() {
                    distressLevel=value;
                    instance.urgency=
                    (value==0?
                    'Low':value==1?
                    'Medium':value==2?
                    'High':'Urgent');
                  });
                },
              ),
            ),
            Text(
              '${distressLevel == 0
                  ? 'Low(1-2 days of response time)' : distressLevel == 1
                  ? 'Medium (7-8 hours of response time)' : distressLevel == 2
                  ? 'High(3-4 hours of response)' : 'Urgent(immediate)'
              }',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Divider(),
            SizedBox(
              height: 32.0,
            ),
            GlobalDropDownButton(
              hint: 'Animal*',
              items: [
                'Dog',
                'Cat',
                'Horse',
                'Cow',
                'Buffalo',
                'Camel',
                'Pigs',
                'Other'
              ],
              prefixIcon: Icons.info,
              onChanged: (value) {
                instance.animal=value;
                if (value=='Other') {
                  isOthers = true;
                } else {
                  isOthers = false;
                }
                setState(() {});
              },
            ),
            Visibility(
              visible: isOthers,
              child: SizedBox(
                height: 32.0,
              ),
            ),
            Visibility(
              visible: isOthers,
              child: GlobalFormField(
                  hint: 'Animal (Others)*',
                  prefixIcon: Icons.info,
                  inputType: TextInputType.text,
                  controller:_aniOther
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            GlobalDropDownButton(
              hint: 'Select Situation*',
              items: ['Accident', 'Abuse', 'Abandonment', 'Unknown', 'Other'],
              prefixIcon: Icons.info,
              onChanged: (value) {
                instance.type=value;
                if (value== 'Other') {
                  isSitOther = true;
                } else {
                  isSitOther = false;
                }
                setState(() {});
              },
            ),
            Visibility(
              visible: isSitOther,
              child: SizedBox(
                height: 32.0,
              ),
            ),
            Visibility(
              visible: isSitOther,
              child: GlobalFormField(
                  hint: 'Situation (Others)*',
                  prefixIcon: Icons.info,
                  inputType: TextInputType.text,
                  controller: _sitOther
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            GlobalFormField(
              hint: 'Description',
              prefixIcon: Icons.info,
              isMultiLine: true,
              controller: _description,
              validator: (value) {},
            ),
            SizedBox(
              height: 16.0,
            ),
            InkWell(
              onTap: () {
                setState(() {});
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GetLocation()),
                );
                setState(() {});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add Location',
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .primaryColor,
                        fontWeight: FontWeight.w600
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            LoaderButton(
              btnTxt: 'Create Distress',
              onPressed: () {
                instance.description = _description.text;
                instance.image1=abc[0];
                instance.image2=abc[1];
                instance.image3=abc[2];
                instance.image4=abc[3];
                Location().onLocationChanged().listen((l) {
                  instance.fixLocation(l.latitude,l.longitude);
                });
                repo.addEmergency(instance);
                setState(() {});
                Navigator.pop(context);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}