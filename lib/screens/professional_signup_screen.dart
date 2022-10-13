import 'package:bujo/app/get_location.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bujo/widgets/form_field.dart';
import 'package:bujo/widgets/header_banner.dart';
import 'package:bujo/widgets/loader_button.dart';
import 'package:bujo/widgets/upload_field.dart';

import 'dialog_get_location.dart';
import 'login_screen.dart';

class ProfessionalSignUp extends StatefulWidget {
  static const routeName = '/prosignup';

  @override
  _ProfessionalSignUpState createState() => _ProfessionalSignUpState();
}

class _ProfessionalSignUpState extends State<ProfessionalSignUp> {
  bool? isVGOorNGO = false;
  bool? isProprietary = false;
  TimeOfDay? mondayStart, mondayEnd;
  TimeOfDay? tuesdayStart, tuesdayEnd;
  TimeOfDay? wednesdayStart, wednesdayEnd;
  TimeOfDay? thursdayStart, thursdayEnd;
  TimeOfDay? fridayStart, fridayEnd;
  TimeOfDay? saturdayStart, saturdayEnd;
  TimeOfDay? sundayStart, sundayEnd;

  List<String> willings = [
    "Foster",
    "Rescue",
    "Volunteer",
    "Professional Consultation",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            child: HeaderBanner(
              title: 'Organization Sign Up',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 32.0,
                ),
                GlobalFormField(
                  hint: 'Organization Name*',
                  prefixIcon: Icons.person,
                  inputType: TextInputType.name,
                ),
                SizedBox(
                  height: 32.0,
                ),
                GlobalFormField(
                  hint: 'Organization Email*',
                  prefixIcon: Icons.email,
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 32.0,
                ),
                GlobalFormField(
                  hint: 'Phone Number*',
                  prefixIcon: Icons.phone_android_rounded,
                  inputType: TextInputType.number,
                ),
                SizedBox(
                  height: 32.0,
                ),
                GlobalFormField(
                  hint: 'Password*',
                  prefixIcon: Icons.vpn_key_rounded,
                  isPassword: true,
                  inputType: TextInputType.name,
                ),
                SizedBox(
                  height: 32.0,
                ),
                GlobalFormField(
                  hint: 'Confirm Password*',
                  prefixIcon: Icons.vpn_key_rounded,
                  isConfirmPass: true,
                  inputType: TextInputType.name,
                ),
                SizedBox(
                  height: 32.0,
                ),
                AbsorbPointer(
                  absorbing: false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: Text(
                                'Day',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              flex: 5,
                              fit: FlexFit.tight,
                              child: Text(
                                'Open',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              flex: 5,
                              fit: FlexFit.tight,
                              child: Text(
                                'Close',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: Text(
                                'Monday',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[300],),
                                  child: Text(mondayStart == null
                                      ? 'Choose'
                                      : '${mondayStart!.format(context)}'),
                                  onPressed: () async {
                                    mondayStart = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        helpText: 'Select Start Time');
                                    mondayEnd = await showTimePicker(
                                        context: context,
                                        initialTime:
                                            mondayStart ?? TimeOfDay.now(),
                                        helpText: 'Select To Time');
                                    setState(() {});
                                  },
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[300],),
                                  child: Text(mondayEnd == null
                                      ? 'Choose'
                                      : '${mondayEnd!.format(context)}'),
                                  onPressed: mondayStart == null
                                      ? null
                                      : () async {
                                          mondayEnd = await showTimePicker(
                                              context: context,
                                              initialTime: mondayStart ??
                                                  TimeOfDay.now(),
                                              helpText: 'Select To Time');
                                          setState(() {});
                                        },
                                )),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: SizedBox(
                                width: double.maxFinite,
                              ),
                              flex: 3,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              flex: 10,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      child: Card(
                                        margin: EdgeInsets.zero,
                                        color: Theme.of(context).primaryColor,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Text(
                                            'Copy for all days',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          tuesdayStart = mondayStart;
                                          tuesdayEnd = mondayEnd;
                                          wednesdayStart = mondayStart;
                                          wednesdayEnd = mondayEnd;
                                          thursdayStart = mondayStart;
                                          thursdayEnd = mondayEnd;
                                          fridayStart = mondayStart;
                                          fridayEnd = mondayEnd;
                                          saturdayStart = mondayStart;
                                          saturdayEnd = mondayEnd;
                                          sundayStart = mondayStart;
                                          sundayEnd = mondayEnd;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: Text(
                                'Tuesday',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[300],
                                    ),
                                  child: Text(tuesdayStart == null
                                      ? 'Choose'
                                      : '${tuesdayStart!.format(context)}'),
                                  onPressed: () async {
                                    tuesdayStart = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        helpText: 'Select Start Time');
                                    tuesdayEnd = await showTimePicker(
                                        context: context,
                                        initialTime:
                                            tuesdayStart ?? TimeOfDay.now(),
                                        helpText: 'Select To Time');
                                    setState(() {});
                                  },
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[300],
                                    ),
                                  child: Text(tuesdayEnd == null
                                      ? 'Choose'
                                      : '${tuesdayEnd!.format(context)}'),
                                  onPressed: tuesdayStart == null
                                      ? null
                                      : () async {
                                          tuesdayEnd = await showTimePicker(
                                              context: context,
                                              initialTime: tuesdayStart ??
                                                  TimeOfDay.now(),
                                              helpText: 'Select To Time');
                                          setState(() {});
                                        },
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: Text(
                                'Wednesday',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[300],
                                    ),
                                  child: Text(wednesdayStart == null
                                      ? 'Choose'
                                      : '${wednesdayStart!.format(context)}'),
                                  onPressed: () async {
                                    wednesdayStart = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        helpText: 'Select Start Time');
                                    wednesdayEnd = await showTimePicker(
                                        context: context,
                                        initialTime:
                                            tuesdayStart ?? TimeOfDay.now(),
                                        helpText: 'Select To Time');
                                    setState(() {});
                                  },
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[300],
                                    ),
                                  child: Text(wednesdayEnd == null
                                      ? 'Choose'
                                      : '${wednesdayEnd!.format(context)}'),
                                  onPressed: wednesdayStart == null
                                      ? null
                                      : () async {
                                          wednesdayEnd = await showTimePicker(
                                              context: context,
                                              initialTime: tuesdayStart ??
                                                  TimeOfDay.now(),
                                              helpText: 'Select To Time');
                                          setState(() {});
                                        },
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: Text(
                                'Thursday',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[300],
                                    ),
                                  child: Text(thursdayStart == null
                                      ? 'Choose'
                                      : '${thursdayStart!.format(context)}'),
                                  onPressed: () async {
                                    thursdayStart = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        helpText: 'Select Start Time');
                                    thursdayEnd = await showTimePicker(
                                        context: context,
                                        initialTime:
                                            thursdayStart ?? TimeOfDay.now(),
                                        helpText: 'Select To Time');
                                    setState(() {});
                                  },
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[300],
                                    ),
                                  child: Text(thursdayEnd == null
                                      ? 'Choose'
                                      : '${thursdayEnd!.format(context)}'),
                                  onPressed: thursdayStart == null
                                      ? null
                                      : () async {
                                          thursdayEnd = await showTimePicker(
                                              context: context,
                                              initialTime: thursdayStart ??
                                                  TimeOfDay.now(),
                                              helpText: 'Select To Time');
                                          setState(() {});
                                        },
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: Text(
                                'Friday',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[300],
                                    ),
                                  child: Text(fridayStart == null
                                      ? 'Choose'
                                      : '${fridayStart!.format(context)}'),
                                  onPressed: () async {
                                    fridayStart = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        helpText: 'Select Start Time');
                                    fridayEnd = await showTimePicker(
                                        context: context,
                                        initialTime:
                                            fridayStart ?? TimeOfDay.now(),
                                        helpText: 'Select To Time');
                                    setState(() {});
                                  },
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[300],
                                    ),
                                  child: Text(fridayEnd == null
                                      ? 'Choose'
                                      : '${fridayEnd!.format(context)}'),
                                  onPressed: fridayStart == null
                                      ? null
                                      : () async {
                                          fridayEnd = await showTimePicker(
                                              context: context,
                                              initialTime: fridayStart ??
                                                  TimeOfDay.now(),
                                              helpText: 'Select To Time');
                                          setState(() {});
                                        },
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: Text(
                                'Saturday',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[300],
                                    ),
                                  child: Text(saturdayStart == null
                                      ? 'Choose'
                                      : '${saturdayStart!.format(context)}'),
                                  onPressed: () async {
                                    saturdayStart = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        helpText: 'Select Start Time');
                                    saturdayEnd = await showTimePicker(
                                        context: context,
                                        initialTime:
                                            saturdayStart ?? TimeOfDay.now(),
                                        helpText: 'Select To Time');
                                    setState(() {});
                                  },
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.grey[300],
                                  ),
                                  child: Text(saturdayEnd == null
                                      ? 'Choose'
                                      : '${saturdayEnd!.format(context)}'),
                                  onPressed: saturdayStart == null
                                      ? null
                                      : () async {
                                          saturdayEnd = await showTimePicker(
                                              context: context,
                                              initialTime: saturdayStart ??
                                                  TimeOfDay.now(),
                                              helpText: 'Select To Time');
                                          setState(() {});
                                        },
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: Text(
                                'Sunday',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.grey[300],
                                  ),
                                  child: Text(sundayStart == null
                                      ? 'Choose'
                                      : '${sundayStart!.format(context)}'),
                                  onPressed: () async {
                                    sundayStart = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        helpText: 'Select Start Time');
                                    sundayEnd = await showTimePicker(
                                        context: context,
                                        initialTime:
                                            sundayStart ?? TimeOfDay.now(),
                                        helpText: 'Select To Time');
                                    setState(() {});
                                  },
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.grey[300],
                                  ),
                                  child: Text(sundayEnd == null
                                      ? 'Choose'
                                      : '${sundayEnd!.format(context)}'),
                                  onPressed: sundayStart == null
                                      ? null
                                      : () async {
                                          sundayEnd = await showTimePicker(
                                              context: context,
                                              initialTime: sundayStart ??
                                                  TimeOfDay.now(),
                                              helpText: 'Select To Time');
                                          setState(() {});
                                        },
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GlobalFormField(
                        hint: 'Facilities Provided*',
                        prefixIcon: FontAwesomeIcons.building,
                        inputType: TextInputType.name,
                      ),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.orange),
                        onPressed: () {},
                        child: Text('Add'))
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Chip(label: Text('Dispensary')),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Chip(label: Text('Grooming')),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Chip(label: Text('Boarding')),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Chip(label: Text('Inpatient ward')),
                      ),
                    ])),
                SizedBox(
                  height: 32.0,
                ),
                Row(
                  children: [
                    Text('is VGO / NGO?'),
                    Spacer(),
                    Radio(
                      onChanged: (bool? value) {
                        setState(() {
                          isVGOorNGO = value;
                        });
                      },
                      groupValue: isVGOorNGO,
                      value: true,
                    ),
                    Text('Yes'),
                    Spacer(),
                    Radio(
                      onChanged: (bool? value) {
                        setState(() {
                          isVGOorNGO = value;
                        });
                      },
                      groupValue: isVGOorNGO,
                      value: false,
                    ),
                    Text('No'),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                Visibility(
                  visible: isVGOorNGO!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 32.0,
                      ),
                      GlobalFormField(
                        hint: 'Darpan Unique ID',
                        prefixIcon: FontAwesomeIcons.building,
                        inputType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text('Are you proprietor?'),
                    Spacer(),
                    Radio(
                      onChanged: (bool? value) {
                        setState(() {
                          isProprietary = value;
                        });
                      },
                      groupValue: isProprietary,
                      value: true,
                    ),
                    Text('Yes'),
                    Spacer(),
                    Radio(
                      onChanged: (bool? value) {
                        setState(() {
                          isProprietary = value;
                        });
                      },
                      groupValue: isProprietary,
                      value: false,
                    ),
                    Text('No'),
                    Spacer(),
                  ],
                ),
                Visibility(
                  visible: isProprietary!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 32.0,
                      ),
                      UploadForm(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                InkWell(
                  onTap: () {setState(() {});
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GetLocation()),
                    );setState(() {});
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
                  height: 32.0,
                ),
                LoaderButton(
                  btnTxt: 'Sign Up',
                  onPressed: () {
                    // showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return GetLocationDialog();
                    //     });
                    // Navigator.pushNamed(context, EmergencyScreen.routeName);
                  },
                ),
                SizedBox(
                  height: 32.0,
                ),

                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Looking for user sign up?'),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'Sign up here',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 32.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
