import 'package:bujo/app/get_location.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bujo/widgets/drop_down_button.dart';
import 'package:bujo/widgets/form_field.dart';
import 'package:bujo/widgets/loader_button.dart';
import 'dialog_get_location.dart';

class CreateNearMeScreen extends StatefulWidget {
  static const routeName = '/createNewNearMe';

  @override
  _CreateNearMeScreenState createState() => _CreateNearMeScreenState();
}

class _CreateNearMeScreenState extends State<CreateNearMeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Near me'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GlobalDropDownButton(
                hint: 'Category*',
                items: [
                  'Vets',
                  'Hospitals',
                  'Grooming' 'centers',
                  'Boarding centers',
                  'NGOs/VOs',
                  'Pharmacy',
                  'Stores'
                ],
                prefixIcon: Icons.info,
              ),
              SizedBox(
                height: 32.0,
              ),
              GlobalFormField(
                hint: 'Name',
                prefixIcon: Icons.info,
                validator: (value) {},
              ),
              SizedBox(
                height: 32.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: GlobalFormField(
                      hint: 'Services Provided*',
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
                      child: Chip(label: Text('Service 1')),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Chip(label: Text('Service 2')),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Chip(label: Text('Service 3')),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Chip(label: Text('Service 4')),
                    ),
                  ])),
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
                btnTxt: 'Post Service',
                onPressed: () {

                  //Navigator.pushNamed(context, EmergencyScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
