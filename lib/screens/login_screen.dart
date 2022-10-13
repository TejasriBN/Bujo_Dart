import 'package:flutter/material.dart';
import 'package:bujo/screens/emergency_screen.dart';
import 'package:bujo/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bujo/widgets/form_field.dart';
import 'package:bujo/widgets/header_banner.dart';
import 'package:bujo/widgets/loader_button.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginScreen extends StatefulWidget {

  static const routeName = '/loginscreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool viewPassword = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  Future<User?> signIn(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user;
    try {
      user = (await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text))
          .user;
      if (user != null) {
        Navigator.of(context).pushReplacementNamed(EmergencyScreen.routeName);
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "";
      if (e.code == 'user-not-found') {
        errorMessage = "Provided credentials are not right";
      } else if (e.code == 'internal-error') {
        errorMessage = "There was an internal error. Try again later";
      }
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
    }
    return user;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context,snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: HeaderBanner(
                      title: 'Sign In',
                    ),
                  ),

                  Expanded(
                    flex: 6,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 24.0,
                            ),
                            Text(
                              'Welcome Back!',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24.0),
                            ),
                            SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              'Please login with your credentials.',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 18.0,
                            ),
                            Spacer(
                              flex: 4,
                            ),
                            GlobalFormField(
                              hint: 'Email/Phone Number',
                              prefixIcon: Icons.person,
                              controller: _emailController,
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            GlobalFormField(
                              hint: 'Password',
                              isPassword: true,
                              prefixIcon: Icons.vpn_key,
                              controller: _passwordController,
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            LoaderButton(
                              btnTxt: 'Login',
                              onPressed: () async{
                                signIn(context);
                              },
                            ),
                            Spacer(
                              flex: 7,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, SignUpScreen
                                    .routeName);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Don\'t have an account?'),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    'Sign up',
                                    style: TextStyle(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        fontWeight: FontWeight.w600
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                    ),
                  ),
                ],
              );
            }
            else{
              return Text('Cannot reach Database');
            }
          }
        )
      );
  }
}
