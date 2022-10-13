import 'package:bujo/app/get_location.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bujo/screens/professional_signup_screen.dart';
import 'package:bujo/widgets/form_field.dart';
import 'package:bujo/widgets/header_banner.dart';
import 'package:bujo/widgets/loader_button.dart';
import 'package:bujo/widgets/multi_chip.dart';
import 'package:bujo/widgets/upload_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dialog_get_location.dart';
import 'login_screen.dart';

class FireAuth {
  static Future<void> registerUsingEmailPassword({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
      if (user != null) {
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        //print('The account already exists for that email.');
      }
    } catch (e) {
      //print(e);
    }
  }
}

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isPartOfOrganization = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();


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
              title: 'Sign Up',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32.0,
                ),
                GlobalFormField(
                  hint: 'Name*',
                  prefixIcon: Icons.person,
                  inputType: TextInputType.name,
                  controller:_nameController,
                ),
                SizedBox(
                  height: 32.0,
                ),
                GlobalFormField(
                  hint: 'Email*',
                  prefixIcon: Icons.email,
                  inputType: TextInputType.emailAddress,
                  controller:_emailController,
                ),
                SizedBox(
                  height: 32.0,
                ),
                GlobalFormField(
                  hint: 'Phone Number*',
                  prefixIcon: Icons.phone_android,
                  inputType: TextInputType.number,
                ),
                SizedBox(
                  height: 32.0,
                ),
                GlobalFormField(
                  hint: 'Age',
                  prefixIcon: FontAwesomeIcons.calendarDay,
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
                  controller:_passwordController,
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
                Text(
                  'Roles',
                ),
                Divider(),
                MultiSelectChip(
                  willings,
                  onSelectionChanged: (List<String> sdfsd) {},
                ),
                SizedBox(
                  height: 32.0,
                ),
                Row(
                  children: [
                    Text('Part of any Organization?*'),
                    Spacer(),
                    Radio(
                      onChanged: (bool? value) {
                        setState(() {
                          isPartOfOrganization = value;
                        });
                      },
                      groupValue: isPartOfOrganization,
                      value: true,
                    ),
                    Text('Yes'),
                    Spacer(),
                    Radio(
                      onChanged: (bool? value) {
                        setState(() {
                          isPartOfOrganization = value;
                        });
                      },
                      groupValue: isPartOfOrganization,
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
                  visible: isPartOfOrganization!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Organization Information',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20.0),
                        ),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      GlobalFormField(
                        hint: 'Organization Name',
                        prefixIcon: FontAwesomeIcons.building,
                        inputType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      UploadForm(),
                      SizedBox(
                        height: 32.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                InkWell(
                  onTap: () {
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
                  height: 32.0,
                ),
                LoaderButton(
                  btnTxt: 'Sign Up',
                  onPressed: () async{
                    await FireAuth.registerUsingEmailPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                        name: _nameController.text,
                        context: context);
                    // showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return GetLocationDialog();
                    //     });
                    //Navigator.pushNamed(context, EmergencyScreen.routeName);
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
                    Navigator.pushNamed(context, ProfessionalSignUp.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Looking for organization sign up?'),
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
