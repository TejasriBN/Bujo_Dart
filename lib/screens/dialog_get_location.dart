import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bujo/widgets/form_field.dart';

class GetLocationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  FontAwesomeIcons.mapPin,
                  color: Theme.of(context).primaryColor,
                  size: 24.0,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Device Location is not enabled',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Please enable device location to get an accurate address',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                Divider(
                  height: 32.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.gps_fixed_rounded,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'Enable Device Location',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 32.0,
                ),
                InkWell(
                  onTap: () {
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
                                    'Search Location',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0),
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  GlobalFormField(
                                    hint: 'Search',
                                    prefixIcon: Icons.search,
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.gps_fixed_rounded,
                                        color: Colors.orange,
                                      ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Text(
                                        'Enable Device Location',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 32.0,
                                  ),
                                  Text(
                                    'Saved Addresses',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.work),
                                    title: Text('Test Sample 1'),
                                    subtitle:
                                        Text('lorem ipsum dolor, lorem ipsum'),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                  )
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
                  child: Text(
                    'Enter Location Manually',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
