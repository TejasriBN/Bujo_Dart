import 'package:flutter/material.dart';
import 'package:bujo/app/theme.dart';
import 'package:bujo/screens/adopt_list_screen.dart';
import 'package:bujo/screens/blood_donation_screen.dart';
import 'package:bujo/screens/create_adoption_screen.dart';
import 'package:bujo/screens/create_blood_donation.dart';
import 'package:bujo/screens/create_distress_screen.dart';
import 'package:bujo/screens/create_events_screen.dart';
import 'package:bujo/screens/create_near_me_screen.dart';
import 'package:bujo/screens/emergency_chat_screen.dart';
import 'package:bujo/screens/emergency_screen.dart';
import 'package:bujo/screens/events_lists.dart';
import 'package:bujo/screens/filter_screen.dart';
import 'package:bujo/screens/forum_list_screen.dart';
import 'package:bujo/screens/login_screen.dart';
import 'package:bujo/screens/near_me_list_screen.dart';
import 'package:bujo/screens/professional_signup_screen.dart';
import 'package:bujo/screens/query_list_screen.dart';
import 'package:bujo/screens/signup_screen.dart';

class Bujo extends StatefulWidget {
  @override
  _BujoState createState() => _BujoState();
}

class _BujoState extends State<Bujo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: LoginScreen(),
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        EmergencyScreen.routeName: (context) => EmergencyScreen(),
        ProfessionalSignUp.routeName: (context) => ProfessionalSignUp(),
        FilterScreen.routeName: (context) => FilterScreen(),
        CreateDistressScreen.routeName: (context) => CreateDistressScreen(),
        EmergencyChatScreen.routeName: (context) => EmergencyChatScreen(),
        BloodDonationScreen.routeName: (context) => BloodDonationScreen(),
        CreateBloodDonationScreen.routeName: (context) =>
            CreateBloodDonationScreen(),
        QueryList.routeName: (context) => QueryList(),
        AdoptAndFosterList.routeName: (context) => AdoptAndFosterList(),
        //AdoptionDetailsScreen.routeName: (context) => AdoptionDetailsScreen(),
        CreateAdoption.routeName: (context) => CreateAdoption(),
        ForumList.routeName: (context) => ForumList(),
        EventsListsScreen.routeName: (context) => EventsListsScreen(),
        //EventDetailsScreen.routeName: (context) => EventDetailsScreen(),
        CreateEvents.routeName: (context) => CreateEvents(),
        NearMeList.routeName: (context) => NearMeList(),
        CreateNearMeScreen.routeName: (context) => CreateNearMeScreen(),

      },
    );
  }
}
