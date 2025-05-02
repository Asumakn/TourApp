import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'DataController.dart';
import 'settingsPage.dart';

class profilePage extends StatefulWidget {
  User user = new User();

  profilePage();

  profilePage.user(this.user);

  @override
  State<profilePage> createState() => _profilePageState();
}

List<BottomNavigationBarItem> items = [
  BottomNavigationBarItem(
    icon: Icon(Icons.person, color: Colors.white),
    label: "Profile",
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.home, color: Colors.white),
    label: "Home",
    backgroundColor: Colors.white,
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.settings, color: Colors.white),
    label: "Settings",
  ),
];
final Stream<QuerySnapshot> tours =
    FirebaseFirestore.instance.collection('tours').snapshots();

class _profilePageState extends State<profilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text(
          "Profile Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ThemeColor.main,
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          Navigator.pushNamed(context, "/${items[index].label}");
        },
        items: items,
        backgroundColor: ThemeColor.main,
        selectedItemColor: CupertinoColors.activeBlue,
      ),

      body: Center(
        child: Column(
          children: [
            Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 5,
              child: Container(
                height: 100,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text( widget.user.username,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.start,),


                  ],
                ),
              ),
            ),
            Text("Next Trip:",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
            Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 5,
              child: Container(
                height: 100,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: tours,
                  builder: (
                      context,
                      AsyncSnapshot<QuerySnapshot> snapshot,
                      ) {
                    if (snapshot.hasError) {}
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      print("object");
                    }
                    var snaps = snapshot.data!.docs.toList();
                    return _tile(
                      new Tour.all(
                        location: snaps[0].get("Location"),
                        startDate: DateTime.parse(
                          snaps[0].get("startDate").toString(),
                        ),
                        endDate: DateTime.parse(
                          snaps[0].get("endDate").toString(),
                        ),
                      ),
                    );
                  },
                ),
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
