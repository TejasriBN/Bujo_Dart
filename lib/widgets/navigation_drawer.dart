import 'package:bujo/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bujo/screens/adopt_list_screen.dart';
import 'package:bujo/screens/blood_donation_screen.dart';
import 'package:bujo/screens/emergency_screen.dart';
import 'package:bujo/screens/events_lists.dart';
import 'package:bujo/screens/forum_list_screen.dart';
import 'package:bujo/screens/near_me_list_screen.dart';
import 'package:bujo/screens/query_list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;
final User? user = auth.currentUser;

class DrawerWidget extends StatelessWidget {
  final String emergencyCount;
  final String bloodDonationCounts;
  final String channelName;
  final String logo;

  const DrawerWidget(
      {this.emergencyCount = '5',
      this.bloodDonationCounts = '6',
      this.channelName = '',
      this.logo = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Icon(Icons.person,color: Colors.white),
                  radius: 30.0,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  channelName,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  user!.displayName!,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                      color: Colors.grey),
                ),

                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    Text(
                      emergencyCount,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15.0),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      'Emergencies',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          color: Colors.black),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      '|',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      bloodDonationCounts,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15.0),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      'Events',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            endIndent: 16.0,
            height: 24.0,
          ),
          Container(
            child: NavigationDrawerItem(
              title: 'Emergencies',
              icon: Icons.warning_amber_outlined,
              iconBgColor: Colors.redAccent,
              onTap: () {
                Navigator.pushNamed(context, EmergencyScreen.routeName);
              },
            ),
          ),
          NavigationDrawerItem(
            title: 'Blood Donations',
            icon: Icons.invert_colors_rounded,
            iconBgColor: Colors.lightBlue,
            onTap: () {
              Navigator.pushNamed(context, BloodDonationScreen.routeName);
            },
          ),
          NavigationDrawerItem(
            title: 'Adopt & Foster',
            icon: FontAwesomeIcons.hospital,
            iconBgColor: Colors.green,
            onTap: () {
              Navigator.pushNamed(context, AdoptAndFosterList.routeName);
            },
          ),
          NavigationDrawerItem(
            title: 'Events',
            icon: FontAwesomeIcons.calendar,
            iconBgColor: Colors.deepPurple,
            onTap: () {
              Navigator.pushNamed(context, EventsListsScreen.routeName);
            },
          ),
          NavigationDrawerItem(
            title: 'Near Me',
            icon: FontAwesomeIcons.mapPin,
            iconBgColor: Colors.orange,
            onTap: () {
              Navigator.pushNamed(context, NearMeList.routeName);
            },
          ),
          NavigationDrawerItem(
            title: 'Query',
            icon: Icons.help_center_outlined,
            iconBgColor: Colors.pinkAccent,
            onTap: () {
              Navigator.pushNamed(context, QueryList.routeName);
            },
          ),
          NavigationDrawerItem(
            title: 'Forum',
            icon: Icons.forum_outlined,
            iconBgColor: Colors.yellow[700],
            onTap: () {
              Navigator.pushNamed(context, ForumList.routeName);
            },
          ),
          Divider(
            color: Colors.grey,
            endIndent: 16.0,
            height: 24.0,
          ),
          InkWell(
            onTap: () async{
              await FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginScreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {

            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Settings & Privacy',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationDrawerItem extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Color? iconBgColor;
  final void Function()? onTap;
  final Widget? trailing;
  final Widget? subtitle;

  const NavigationDrawerItem(
      {this.title,
      this.icon,
      this.iconBgColor,
      this.onTap,
      this.trailing,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap!,
      child: ListTile(
        subtitle: subtitle,
        leading: Card(
          color: iconBgColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          title!,
          style: TextStyle(fontSize: 16.0),
        ),
        trailing: trailing,
      ),
    );
  }
}
