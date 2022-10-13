import 'dart:io';
import 'package:location/location.dart';
import 'package:bujo/app/get_location.dart';
import 'package:bujo/classes/event.dart';
import 'package:bujo/repos/eventRepo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:bujo/widgets/form_field.dart';
import 'package:bujo/widgets/loader_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';


class CreateEvents extends StatefulWidget {
  static const routeName = '/createEvents';

  @override
  _CreateEventsState createState() => _CreateEventsState();
}

class _CreateEventsState extends State<CreateEvents> {
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
        var a = _imageFile.path;
        ////print(a.split("/").last.split('.').last);

        ////print("inside upload res");
        ////print(res);
        b = b+"."+a.split("/").last.split('.').last;
        //print(b);
        return b;
      });
    }
    return ' ';

  }
  //int count=0;

  String up = 'Upload Event Banner';
  TextEditingController _eventname = TextEditingController();
  TextEditingController _venue = TextEditingController();
  TextEditingController _toe = TextEditingController();
  TextEditingController _edate = TextEditingController();
  final repo = EventRepo();
  Event instance = Event(
      '','','','',''
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 16.0,
              ),
              Center(
                  child: InkWell(
                      onTap: () async{
                        instance.img= await uploadImageToFirebase();
                        instance.img=b;
                        //var s=abc[count]; //.split('/');
                        //abc[count]=s.last;
                        //print('instance.img' + '    '+ instance.img);
                        // count=count+1;
                        // if(count>0 && count<4)
                        // {
                        //   up=(count) as String;
                        //   up=up+ " Images uploaded. Upload ";
                        //   var d = (4-count) as String;
                        //   up=up+d+" more images.";
                        //   //print(up);
                        // }
                        // if(count==4)
                        // {
                        //   up="4 Images uploaded.";
                        //   //print(up);
                        // }
                        up="Image uploaded successfully";
                        setState((){});
                        //print("Upload clicked");
                        // //print("abc");
                        // //print(abc);
                      },
                      child: Container(
                        height: 200.0,
                        width: double.infinity,
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
                      ))),
              SizedBox(
                height: 32.0,
              ),
              GlobalFormField(
                hint: 'Event Name*',
                prefixIcon: Icons.info,
                inputType: TextInputType.text,
                  controller: _eventname
              ),
              SizedBox(
                height: 32.0,
              ),
              GlobalFormField(
                hint: 'Venue*',
                prefixIcon: Icons.location_on_rounded,
                inputType: TextInputType.text,
                  controller: _venue
              ),
              SizedBox(
                height: 32.0,
              ),
              GlobalFormField(
                hint: 'Date*',
                isExpiryDate: true,
                prefixIcon: Icons.calendar_today,
                inputType: TextInputType.text,
                  controller: _edate
              ),
              SizedBox(
                height: 32.0,
              ),
              GlobalFormField(
                hint: 'Type of Event*',
                prefixIcon: Icons.info,
                inputType: TextInputType.text,
                  controller: _toe
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
                btnTxt: 'Create Event',
                onPressed: () {
                  instance.venue=_venue.text;
                  instance.date=_edate.text;
                  instance.name=_eventname.text;
                  instance.type=_toe.text;
                  Location().onLocationChanged().listen((l) {
                    instance.fixLocation(l.latitude,l.longitude);
                  });
                  repo.addEvent(instance);
                  setState(() {});
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
