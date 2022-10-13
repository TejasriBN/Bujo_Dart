import 'package:bujo/repos/adoptRepo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bujo/screens/create_adoption_screen.dart';
import 'package:bujo/widgets/adoption_list_item.dart';
import 'package:bujo/widgets/navigation_drawer.dart';

import 'adopt_filter_screen.dart';

final repo = AdoptRepo();
class AdoptAndFosterList extends StatefulWidget {
  static const routeName = '/adoptList';

  @override
  _AdoptAndFosterListState createState() => _AdoptAndFosterListState();
}

class _AdoptAndFosterListState extends State<AdoptAndFosterList> {
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {});
          Navigator.pushNamed(context, CreateAdoption.routeName);
          setState(() {});
        },
        label: Text('Create Adoption/Foster'),
        icon: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : null,
        title: _isSearching ? _buildSearchField() : Text('Adopt & Foster'),
        actions: _buildActions(),
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
                                (data)=>AdoptionListItem(data)
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
          setState(() {});
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AFilterScreen()),
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
