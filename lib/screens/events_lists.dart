import 'package:bujo/repos/eventRepo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bujo/widgets/events_and_fundraisers_item.dart';
import 'package:bujo/widgets/navigation_drawer.dart';

import 'create_events_screen.dart';
import 'event_filter_screen.dart';

class EventsListsScreen extends StatefulWidget {
  static const routeName = '/eventsList';

  @override
  _EventsListsScreenState createState() => _EventsListsScreenState();
}

class _EventsListsScreenState extends State<EventsListsScreen> {
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";
  final repo = EventRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {});
          Navigator.pushNamed(context, CreateEvents.routeName);
          setState(() {});
        },
        label: Text('Create Events'),
        icon: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : null,
        title:
        _isSearching ? _buildSearchField() : Text('Events'),
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
                                (data)=>EventsAndFundraisersItem(data)
                        )
                            .toList()
                    )
                  ],
                ),
              ),
            );
          }
      )
      // ListView.builder(
      //     itemCount: 5,
      //     itemBuilder: (ctx, index) {
      //       return EventsAndFundraisersItem(index);
      //     }),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Event...",
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
                builder: (context) => EFilterScreen()),
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