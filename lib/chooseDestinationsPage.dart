import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'DataController.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Widget> drawerList = [];

Set<Marker> markers = createMarkers();

Set<Marker> createMarkers() {
  final CollectionReference cities = FirebaseFirestore.instance
      .collection('cities').where('name',isEqualTo: 'Munich').firestore.collection("destinations");
  cities.snapshots().forEach((snapshot) {
    var snaps = snapshot.docs;
    Set<Marker> markers = HashSet();
    for (var item in snaps) {
      markers.add(
        Marker(
          infoWindow: InfoWindow(
            title: item.get("name"),
            onTap: () {
              drawerList.add(ListTile(title: Text(item.get("name"))));
            },
          ),
          markerId: MarkerId(item.get("name")),
          position: LatLng(item.get("lat"), item.get("lng")),
        ),
      );
    }
  });

  return markers;
}

class chooseDestinationPage extends StatefulWidget {
  City city;
  Tour tour;

  chooseDestinationPage({required this.city, required this.tour});

  @override
  State<chooseDestinationPage> createState() => _chooseDestinationPageState();
}

class _chooseDestinationPageState extends State<chooseDestinationPage> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    _myDrawerOptions(name, route) {
      return ListTile(
        title: Text(name),
        onTap: () {
          DataController.addTour(tour: widget.tour);
          DataController.tourList.add(widget.tour);
          Navigator.pushNamed(context, route);
        },
      );
    }

    drawerList = [
      DrawerHeader(
        decoration: BoxDecoration(color: Colors.blue),
        child: Column(
          children: [Text('Drawer Header'), Icon(Icons.pin_drop, size: 100)],
        ),
      ),
      _myDrawerOptions("Save Trip", "/main"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Plan Your Trip in ${widget.city.name} ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 2,
        backgroundColor: Colors.blue,
      ),
      drawer: NavigationDrawer(children: drawerList),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.city.Lng, widget.city.Lat),
          zoom: 11.0,
        ),
        markers: createMarkers(),
      ),
    );
  }
}

_tile(Destination destination) {
  return ListTile(
    title: Text(
      destination.name,
      style: TextStyle(fontSize: 150, fontWeight: FontWeight.bold),
    ),
    subtitle: Text("In ${destination.city}"),
    trailing: Text(
      "",
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
  );
}
