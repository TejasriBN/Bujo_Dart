import 'package:bujo/app/videocall.dart';
import 'package:flutter/material.dart';
import 'package:bujo/widgets/form_field.dart';
import 'package:bujo/widgets/loader_button.dart';
import 'package:bujo/widgets/navigation_drawer.dart';
import 'package:bujo/repos/queryRepo.dart';
import 'emergency_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bujo/widgets/query_card.dart';
import 'package:bujo/classes/query.dart' as q;

class QueryList extends StatefulWidget {
  static const routeName = '/queryList';

  @override
  _QueryListState createState() => _QueryListState();
}

class _QueryListState extends State<QueryList> {

  QueryRepo repo = QueryRepo();
  TextEditingController _queryController = TextEditingController();
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {});
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Container(
                padding: MediaQuery.of(context).viewInsets,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ask a Professional',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        GlobalFormField(
                          hint: 'Query',
                          prefixIcon: Icons.help,
                          isMultiLine: true,
                          validator: (value) {},
                          controller: _queryController
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                //////launch("tel://9876543210");
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),

                              ),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {});
                                Navigator.of(context)
                                    .pushNamed(EmergencyChatScreen.routeName);
                                setState(() {});
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.chat,
                                  color: Colors.white,
                                ),
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
                                      builder: (context) => VideoCallW()),
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.blueGrey,
                                child: Icon(
                                  Icons.videocam,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        LoaderButton(
                          btnTxt: 'Post',
                          onPressed: () {
                            repo.addQuery(
                              q.Query(_queryController.text)
                            );
                            setState(() {});
                            Navigator.pop(context);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0))),
              );
            },
          );
        },
        label: Text('Ask Query'),
        icon: Icon(Icons.help),
      ),
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : null,
        title: _isSearching ? _buildSearchField() : Text('Queries'),
        actions: _buildActions(),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: repo.getStream(),
          builder: (context,snapshot) {
            return ListView(
              children: (snapshot.data?.docs ?? []).map<Widget>(
                      (data) => QueryCard(data)
              ).toList(),
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
        hintText: "Search Query...",
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