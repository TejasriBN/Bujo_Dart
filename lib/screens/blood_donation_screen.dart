import 'package:bujo/widgets/donor_blood_item.dart';
import 'package:bujo/widgets/request_blood_item.dart';
import 'package:flutter/material.dart';
import 'package:bujo/widgets/TabIndicator.dart';
import 'package:bujo/widgets/navigation_drawer.dart';
import 'package:bujo/repos/requestRepo.dart';
import 'package:bujo/repos/donorRepo.dart';
import 'blood_filter_screen.dart';
import 'create_blood_donation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BloodDonationScreen extends StatefulWidget {
  static const routeName = '/bloodDonations';

  @override
  _BloodDonationScreenState createState() => _BloodDonationScreenState();
}

class _BloodDonationScreenState extends State<BloodDonationScreen> {

  DonorRepo donorRepo = DonorRepo();
  RequestRepo requestRepo = RequestRepo();
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {});
            Navigator.pushNamed(context, CreateBloodDonationScreen.routeName);
          },
          label: Text('Create Donor/Request'),
          icon: Icon(Icons.add),
        ),

        drawer: Drawer(
          child: DrawerWidget(),
        ),
        appBar: AppBar(
          leading: _isSearching ? BackButton() : null,
          title: _isSearching ? _buildSearchField() : Text('Blood Donations'),
          actions: _buildActions(),
          bottom: TabBar(
            indicator: CircleTabIndicator(color: Colors.black, radius: 3),
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Tab(
                child: Text(
                  'Donors',
                ),
              ),
              Tab(
                child: Text('Requests'),
              ),
            ],
          ),
        ),
        body: TabBarView(
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: donorRepo.getStream(),
                  builder: (context,snapshot) {
                    return ListView(
                      children: (snapshot.data?.docs ?? []).map(
                        (data) => DonorBloodDonationItem(data)
                      ).toList()
                    );
                  }
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: requestRepo.getStream(),
                  builder: (context,snapshot) {
                    return ListView(
                      children: (snapshot.data?.docs ?? []).map(
                              (data) => RequestBloodDonationItem(data)
                      ).toList()
                    );
                  }
                )
          ],
        )
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
          setState(() {});
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BFilterScreen()),
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