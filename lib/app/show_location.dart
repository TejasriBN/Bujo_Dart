import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class ShowLocation extends StatefulWidget {
  final LatLng loc;
  ShowLocation(this.loc);
  @override
  _ShowLocationState createState() => _ShowLocationState(this.loc);
}

class _ShowLocationState extends State<ShowLocation> {

  _ShowLocationState(this._initialCameraPosition);
  LatLng _initialCameraPosition;
  late GoogleMapController _controller;
  Location _location = Location();
  //late StreamSubscription _locationSubscription;

  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _cntlr;
    //_locationSubscription=
    _location.onLocationChanged().listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 40),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(target: _initialCameraPosition,
                  zoom: 40),
              mapType: MapType.hybrid,
              //onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              markers: Set<Marker>.of(
                <Marker>[
                  Marker(
                    onTap: () {
                      //print('Tapped');
                    },
                    draggable: true,
                    markerId: MarkerId('MarkerS'),
                    position: _initialCameraPosition
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}