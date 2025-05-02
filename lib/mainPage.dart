import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalprojectapp/chooseLocationPage.dart';
import 'package:finalprojectapp/datePickPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'DataController.dart';
import 'profilePage.dart';
import 'settingsPage.dart';

class myAppMain extends StatelessWidget {
  static User user = new User();

  final Stream<QuerySnapshot> tours =
      FirebaseFirestore.instance.collection('tours').snapshots();

  myAppMain();


List<BottomNavigationBarItem> items = [BottomNavigationBarItem(icon: Icon(Icons.person,color: Colors.white,),label: "Profile",),BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.white),label: "Home",backgroundColor: Colors.white),BottomNavigationBarItem(icon: Icon(Icons.settings,color: Colors.white),label: "Settings")];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(onTap: (int index){
        Navigator.pushNamed(context,"/${items[index].label}");
      },items: items,backgroundColor: ThemeColor.main,selectedItemColor: CupertinoColors.activeBlue, ),
      appBar: AppBar(centerTitle: true,
        title: Text(
          " Welcome ${user.username}",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ThemeColor.main,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 50,
          children: [
            Container(
              height: 270,
              decoration: BoxDecoration(color: ThemeColor.secondary),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ThemeColor.secondary,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 3,
                          color: ThemeColor.secondary,
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
                              child: Icon(Icons.travel_explore, size: 110),
                            ),
                            Text(
                              "Plan a Trip",
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
                      return Container(
                        height: 110,
                        child: _tile(
                          new Tour.all(
                            location: snaps[index].get("Location"),
                            startDate: DateTime.parse(snaps[index].get("startDate").toString()),
                            endDate: DateTime.parse(snaps[index].get("endDate").toString()),
                          ),
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
  return Column(
    children: [
      Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        child: ListTile(
          onTap: (){},
          selectedColor: ThemeColor.secondary,
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
      ),
      SizedBox(
        height: 15,
      )
    ],
  );
}
