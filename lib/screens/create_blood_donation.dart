import 'package:bujo/app/get_location.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bujo/widgets/drop_down_button.dart';
import 'package:bujo/widgets/form_field.dart';
import 'package:bujo/widgets/loader_button.dart';
import 'package:bujo/repos/requestRepo.dart';
import 'package:bujo/classes/request.dart';
import 'package:bujo/repos/donorRepo.dart';
import 'package:bujo/classes/donor.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateBloodDonationScreen extends StatefulWidget {
  static const routeName = '/donateBlood';

  @override
  _CreateBloodDonationScreenState createState() =>
      _CreateBloodDonationScreenState();
}

class _CreateBloodDonationScreenState extends State<CreateBloodDonationScreen> {


  final RequestRepo requestRepo = RequestRepo();
  final DonorRepo donorRepo = DonorRepo();

  bool isDonatingBlood = true;
  bool isOthers = false;
  TextEditingController _aniController = TextEditingController();
  List<TextEditingController> _controller = List.generate(
      10, (index) => TextEditingController()
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 48.0,
                  ),
                  Center(
                    child: FaIcon(
                      FontAwesomeIcons.tint,
                      size: 50.0,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Center(
                    child: Text(
                      'Donate/Request Blood',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isDonatingBlood = true;
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            color: isDonatingBlood ? Colors.red : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  FaIcon(
                                    Icons.favorite_border_sharp,
                                    size: 80.0,
                                    color: isDonatingBlood
                                        ? Colors.white
                                        : Colors.red,
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Text(
                                    'Donate Blood',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: isDonatingBlood
                                          ? Colors.white
                                          : Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isDonatingBlood = false;
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            color: isDonatingBlood ? Colors.white : Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  FaIcon(
                                    Icons.search,
                                    size: 80.0,
                                    color: isDonatingBlood
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Text(
                                    'Request Blood',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: isDonatingBlood
                                          ? Colors.red
                                          : Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
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
                      _controller[0].text=value;
                      if (value == 'Other') {
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
                        controller: _controller[0]
                    ),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  GlobalFormField(
                      hint: 'Breed*',
                      prefixIcon: FontAwesomeIcons.tint,
                      inputType: TextInputType.text,
                      controller: _controller[1]
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  GlobalFormField(
                      hint: 'Blood Type*',
                      prefixIcon: FontAwesomeIcons.tint,
                      inputType: TextInputType.text,
                      controller: _controller[2]
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GlobalFormField(
                          hint: 'Age*',
                          controller: _controller[3],
                          inputType: TextInputType.number,
                          prefixIcon: FontAwesomeIcons.calendarDay,
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
                            onChanged: (value){
                              _controller[4].text=value;
                            }
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: !isDonatingBlood,
                    child: SizedBox(
                      height: 32.0,
                    ),
                  ),
                  Visibility(
                    visible: !isDonatingBlood,
                    child: GlobalFormField(
                      hint: 'Deadline*',
                      prefixIcon: FontAwesomeIcons.calendarDay,
                      controller: _controller[5],
                      inputType: TextInputType.number,
                      isExpiryDate: true,
                    ),
                  ),
                  Visibility(
                    visible: !isDonatingBlood,
                    child: SizedBox(
                      height: 32.0,
                    ),
                  ),
                  Visibility(
                    visible: !isDonatingBlood,
                    child: GlobalFormField(
                      hint: 'Amount*',
                      prefixIcon: FontAwesomeIcons.tint,
                      inputType: TextInputType.number,
                      controller: _controller[6],
                    ),
                  ),
                  Visibility(
                    visible: isDonatingBlood,
                    child: SizedBox(
                      height: 32.0,
                    ),
                  ),
                  Visibility(
                    visible: isDonatingBlood,
                    child: GlobalFormField(
                      hint: 'Weight (kg)*',
                      prefixIcon: Icons.av_timer,
                      inputType: TextInputType.number,
                      controller: _controller[7],
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
                    btnTxt: isDonatingBlood ? 'Create Donor' : 'Create Request',
                    //btnColor: Colors.red,
                    onPressed: () {
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final User? user = auth.currentUser;
                      if(user!=null)
                        if(user.displayName!=null) {
                          if (isDonatingBlood) {
                            donorRepo.addDonor(
                                Donor(
                                    _controller[0].text,
                                    _controller[1].text,
                                    _controller[2].text,
                                    _controller[3].text+_controller[4].text,
                                    int.parse(_controller[7].text),
                                    'Chennai', 'Tamil Nadu',
                                    user.displayName!
                                )
                            );
                          }
                          else {
                            requestRepo.addRequest(
                                Request(
                                  _controller[0].text,
                                  _controller[1].text,
                                  _controller[2].text,
                                  _controller[3].text+' '+_controller[4].text,
                                  _controller[5].text,
                                  int.parse(_controller[6].text),
                                  'Chennai',
                                  'Tamil Nadu',
                                  user.displayName!,
                                )
                            );
                          }
                        }
                      setState(() {});
                      Navigator.pop(context);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
