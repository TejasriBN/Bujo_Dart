import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bujo/screens/create_distress_screen.dart';
import 'package:bujo/widgets/emergency_card.dart';
import 'package:bujo/widgets/navigation_drawer.dart';
import 'package:bujo/repos/emergencyRepo.dart';
import 'filter_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final repo = EmergencyRepo();

class EmergencyScreen extends StatefulWidget {
  static const routeName = '/emergency';

  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : null,
        title: _isSearching ? _buildSearchField() : Text('Emergencies'),
        actions: _buildActions(),
      ),
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          setState(() {});
          Navigator.of(context).pushNamed(CreateDistressScreen.routeName);
          setState(() {});},
        label: Text('  Create Distress'),
        icon: Icon(
          FontAwesomeIcons.broadcastTower,
          size: 20.0,
        ),
      ),
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
                            (data)=>EmergencyCard(data)
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
        hintText: "Search Emergency...",
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
          Navigator.pushNamed(context, FilterScreen.routeName);
          setState(() {});},
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
