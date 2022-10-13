import 'package:bujo/app/show_location.dart';
import 'package:bujo/repos/nearRepo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bujo/screens/create_near_me_screen.dart';
import 'package:bujo/widgets/navigation_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'emergency_chat_screen.dart';
import 'nearme_filter_screen.dart';
import 'package:bujo/classes/nearme.dart';

final repo = NearRepo();
class NearMeList extends StatefulWidget {
  static const String routeName = '/nearMeList';

  @override
  _NearMeListState createState() => _NearMeListState();
}


// List<NearMe> nmb = [
//   NearMe('Paws for Paws','NGO','Chennai, Tamil Nadu','Foster', 'Boarding','Training'),
//   NearMe('All in one Pets','Pet Shop','Hyderabad, Telangana','Pet Food', 'Accessories','Grooming Center'),
//   NearMe('iAdopt','VO','Pune, Maharashtra','Adoption', 'Foster','Volunteer'),
//   NearMe('BMAD','NGO','Chennai, Tamil Nadu','Rescue','Dispensary','Shelter'),
//   NearMe('Furr Purr','Pharmacy','Bangalore, Karnataka','Medicines','Food','Accessories'),
//   NearMe('Blue Cross India','NGO','Vellore, Tamil Nadu','Rescue','Adoption','Dispensary'),
//
//   NearMe('PWV','VO','Bombay, Maharashtra','Adoption', 'Foster','Volunteer'),
//   NearMe('Everyone Fur','NGO','Kanchipuram, Tamil Nadu','Rescue','Dispensary','Shelter'),
//   NearMe('Paws','NGO','Chennai, Tamil Nadu','Foster', 'Boarding','Training'),
//   NearMe('Blue Cross India','NGO','Hyderabad, Telangana','Rescue','Adoption','Dispensary'),
//   NearMe('All in one Gen','Pharmacy','Mysore, Karnataka','Medicines','Food','Accessories'),
//   NearMe('Pets101','Pet Shop','Hyderabad, Telangana','Pet Food', 'Accessories','Grooming Center'),
// ];

class NearMeListView extends StatelessWidget{
  // final int ind;
  // NearMeListView(this.ind);
  final DocumentSnapshot ds;
  NearMeListView(this.ds);

  @override
  Widget build(BuildContext context) {
    final element = nearFromSnapshot(this.ds);
    return ExpansionTile(
      title: Text(element.title),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            element.commodity+' | ',
            style: TextStyle(),
          ),
          Text(
            'Chennai, Tamil Nadu',
            style: TextStyle(),
          ),
        ],
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Facilities',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(children: [
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Chip(label: Text(element.s1)),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Chip(label: Text(element.s2)),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Chip(label: Text(element.s3)),
                      ),

                    ])),
                Divider(),
                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: () {
                        launch("tel://"+element.phone);
                      },
                      child: Expanded(
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(34.0))),
                            onPressed: () {
                              launch("tel://"+element.phone);
                            },
                            icon: Icon(Icons.call),
                            label: Text('Call')),
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    InkWell(
                      onTap: () {

                        Navigator.of(context)
                            .pushNamed(EmergencyChatScreen.routeName);
                      },
                      child: Expanded(
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(34.0))),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, EmergencyChatScreen.routeName);
                              },
                            icon: Icon(Icons.chat),
                            label: Text('Chat')),
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => ShowLocation(
                              element.location
                            )
                        ),
                        );
                      },

                      child: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _NearMeListState extends State<NearMeList> {
  TextEditingController _searchQueryController = TextEditingController();

  bool _isSearching = false;

  String searchQuery = "Search query";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : null,
        title: _isSearching ? _buildSearchField() : Text('Near Me'),
        actions: _buildActions(),
      ),
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, CreateNearMeScreen.routeName);
      //   },
      //   child: Icon(Icons.add),
      // ),
      body: StreamBuilder<QuerySnapshot>(
          stream: repo.getStream(),
          builder: (context,snapshot){
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 16.0,
                    ),
                    ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: (snapshot.data?.docs?? [])
                            .map(
                                (data)=>NearMeListView(data)
                        )
                            .toList()
                    )
                  ],
                ),
              ),
            );
          }
      )
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
      IconButton(
        icon: const Icon(Icons.filter_list),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NFilterScreen()),
          );
        },
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}
