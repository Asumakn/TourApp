import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DataController.dart';
import 'chooseDestinationsPage.dart';

class chooseLocationPage extends StatelessWidget {
  Tour currentTour;

  chooseLocationPage({required this.currentTour});
  final Stream<QuerySnapshot> cities =
      FirebaseFirestore.instance.collection('cities').snapshots();
  @override
  Widget build(BuildContext context) {
    tile(City city1) {
      return ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        onTap: () {
          currentTour.location = city1.name;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      chooseDestinationPage(city: city1, tour: currentTour),
            ),
          );
        },
        title: Text(
          city1.name,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(""),
        trailing: Icon(Icons.travel_explore, size: 55),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose a City to Explore ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: cities,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    print("object");
                  }

                  var snaps = snapshot.data!.docs.toList();
                  return ListView.builder(
                    itemCount: snaps.length,
                    itemBuilder: (BuildContext context, int index) {
                      return tile(
                        new City(
                          name: snaps[index].get("name"),
                          Lng: double.parse(snaps[index].get("lng").toString()),
                          Lat: double.parse(snaps[index].get("lat").toString()),
                        ),
                      );
                    },
                  );

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
