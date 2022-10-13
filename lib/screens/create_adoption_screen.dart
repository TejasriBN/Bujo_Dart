import 'dart:io';

import 'package:bujo/app/get_location.dart';
import 'package:bujo/classes/adopt.dart';
import 'package:bujo/repos/adoptRepo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bujo/widgets/drop_down_button.dart';
import 'package:bujo/widgets/form_field.dart';
import 'package:bujo/widgets/loader_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


class CreateAdoption extends StatefulWidget {
  static const routeName = '/createAdoption';

  @override
  _CreateAdoptionState createState() => _CreateAdoptionState();
}

class _CreateAdoptionState extends State<CreateAdoption> {
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
  List<String> abc = ['', '', '',''];
  TextEditingController _aname = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _startdate = TextEditingController();
  TextEditingController _enddate = TextEditingController();
  TextEditingController _mcon = TextEditingController();
  TextEditingController _curdiet = TextEditingController();
  TextEditingController _desc = TextEditingController();
  bool? isFostering = false;
  bool? isAdopting = false;
  final repo = AdoptRepo();
  Adopt instance = Adopt("","","","","","","","","","","","","","","Chennai","Tamil Nadu");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Adoption'),
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
                      var p= await uploadImageToFirebase();
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
                        //print(up);
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
                    ))),
            SizedBox(
              height: 32.0,
            ),
            Divider(),
            SizedBox(
              height: 32.0,
            ),
            GlobalFormField(
              hint: 'Name*',
              prefixIcon: Icons.info,
              inputType: TextInputType.text,
                controller:_aname
            ),
            SizedBox(
              height: 32.0,
            ),
            Row(
              children: [
                Expanded(
                  child: GlobalFormField(
                    hint: 'Age*',
                    inputType: TextInputType.number,
                    prefixIcon: FontAwesomeIcons.calendarDay,
                      controller:_age
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: GlobalDropDownButton(
                    hint: '',
                    items: ['Days', 'Weeks', 'Years'],
                    prefixIcon: FontAwesomeIcons.calendarDay,
                    onChanged: (value) {
                      //print(value);
                      instance.age+=_age.text+" "+value;
                      //print(instance.age);
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 32.0,
            ),
            GlobalDropDownButton(
              hint: 'Gender*',
              items: ['Male', 'Female'],
              prefixIcon: FontAwesomeIcons.genderless,
              onChanged: (value) {
                instance.gender+=value;
                setState(() {});
              },
            ),
            SizedBox(
              height: 32.0,
            ),
            GlobalDropDownButton(
              hint: 'Select Animal*',
              items: ['Dog', 'Cat', 'Cow', 'Goat', 'Rabbit'],
              prefixIcon: Icons.pets,
              onChanged: (value) {
                instance.type+=value;
                setState(() {});
              },
            ),
            SizedBox(
              height: 32.0,
            ),
            GlobalFormField(
              hint: 'Medical Condition',
              prefixIcon: Icons.info,
              inputType: TextInputType.text,
              controller: _mcon
            ),
            SizedBox(
              height: 32.0,
            ),
            GlobalFormField(
              hint: 'Current Diet*',
              prefixIcon: Icons.fastfood_outlined,
              inputType: TextInputType.text,
                controller: _curdiet
            ),
            SizedBox(
              height: 32.0,
            ),
            GlobalFormField(
              hint: 'Description*',
              prefixIcon: Icons.info,
              isMultiLine: true,
              validator: (value) {},
                controller: _desc
            ),
            SizedBox(
              height: 32.0,
            ),
            Row(
              children: [
                Text('Adoption Type?*'),
                Spacer(),
                Checkbox(
                  onChanged: (bool? value) {
                    setState(() {
                      isAdopting = value;
                      if(isAdopting == true && isFostering==true){
                        instance.avail+="Adoption | Foster";
                      }
                      if(isAdopting == true && isFostering==false){
                        instance.avail+="Adoption";
                      }
                    });
                  },
                  value: isAdopting,
                ),
                Text('Adoption'),
                Spacer(),
                Checkbox(
                  onChanged: (bool? value) {
                    setState(() {
                      isFostering = value;
                      if(isAdopting == true && isFostering==true){
                        instance.avail+="Adoption | Foster";
                      }
                      if(isAdopting == false && isFostering==true){
                        instance.avail+="Foster";
                      }
                    });
                  },
                  value: isFostering,
                ),
                Text('Foster'),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 32.0,
            ),
            Visibility(
              visible: isFostering!,
              child: Row(
                children: [
                  Expanded(
                    child: GlobalFormField(
                      hint: 'Start Date*',
                      prefixIcon: Icons.calendar_today,
                      isExpiryDate: true,
                      controller: _startdate,
                      validator: (value) {},
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: GlobalFormField(
                      hint: 'End Date*',
                      prefixIcon: Icons.calendar_today,
                      isExpiryDate: true,
                      controller: _enddate,
                      validator: (value) {},
                    ),
                  ),
                ],
              ),
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

                ); setState(() {});
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
              btnTxt: 'Create Post',
              onPressed: () {
                instance.name=_aname.text;
                instance.startdate= _startdate.text;
                instance.enddate= _enddate.text;
                instance.medicalcon= _mcon.text;
                instance.currdiet= _curdiet.text;
                instance.add_dets= _desc.text;
                instance.image1=abc[0];
                instance.image2=abc[1];
                instance.image3=abc[2];
                instance.image4=abc[3];
                repo.addAdopt(instance);
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
