import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalprojectapp/chooseLocationPage.dart';
import 'package:finalprojectapp/datePickPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'DataController.dart';

class myAppMain extends StatelessWidget {
  User user;

  final Stream<QuerySnapshot> tours =
      FirebaseFirestore.instance.collection('tours').snapshots();
  myAppMain({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " Welcome ${user.username}",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 50,
          children: [
            Container(
              height: 270,
              decoration: BoxDecoration(color: Colors.lightBlueAccent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 3,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      child: SizedBox(
                        height: 160,
                        width: 208,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => datePickPage(),
                                  ),
                                );
                              },
                              child: Icon(Icons.car_rental, size: 110),
                            ),
                            Text(
                              "Local",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 5,
              child: Container(
                height: 100,
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: Text(
                  "Your Tours",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: tours,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {}
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    print("object");
                  }

                  var snaps = snapshot.data!.docs.toList();
                  return ListView.builder(
                    itemCount: snaps.length,
                    itemBuilder: (BuildContext context, int index) {

                      return _tile(
                        new Tour.all(
                          location: snaps[index].get("Location"),
                          startDate: DateTime.parse(snaps[index].get("startDate").toString()),
                          endDate: DateTime.parse(snaps[index].get("endDate").toString()),
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

_tile(Tour tour) {
  return Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(20),
    child: ListTile(
      title: Text(
        "Tour in ${tour.location}",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "From ${DateFormat('yyyy-MM-dd').format(tour.startDate)} to ${DateFormat('yyyy-MM-dd').format(tour.endDate)}",
      ),
      trailing: Text(
        tour.destinations.length.toString(),
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
