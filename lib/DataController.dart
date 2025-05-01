import 'dart:collection';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_cache/firestore_cache.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'chooseDestinationsPage.dart';

void main() {}

class DataController {
  static int test = 0;
  static late Database database;
  static List<User> userList = [];
  static List<City> cityList = [];
  static List<Tour> tourList = [];
  static List<Destination> destinationList = [];

  static initiateDatabase() async {}

  static final CollectionReference users = FirebaseFirestore.instance
      .collection('users');

  static createUser({required username, required password}) async {
    final CollectionReference users = FirebaseFirestore.instance.collection(
      'users',
    );

    if (username.isNotEmpty && password.isNotEmpty) {
      try {
        await users.add({'username': username, 'password': password});
        print('User added');
      } catch (error) {
        print("Failed to add user: $error");
      }
    } else {
      print("Enter valid name and password");
    }
  }

  static addTour({required Tour tour}) async {
    final CollectionReference tours = FirebaseFirestore.instance.collection(
      'tours',
    );
    try {
      await tours.add({
        'Location': tour.location,
        'startDate': tour.startDate.toString(),
        'endDate': tour.endDate.toString(),
      });
      print('User added');
    } catch (error) {
      print("Failed to add user: $error");
    }
  }

  static Widget readCities({required Tour currenTour}) {
    final Stream<QuerySnapshot> cities = FirebaseFirestore.instance.collection('cities').snapshots();

    StreamBuilder<QuerySnapshot>(
      stream: cities,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        snapshot.data!.docs.map((DocumentSnapshot document) {
          if (snapshot.hasError) {
            return Text('Something is wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("object");
            return Text("Loading...");
          }

          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          tile(City city1) {
            return ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              onTap: () {
                currenTour.location = city1.name;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => chooseDestinationPage(
                      city: city1,
                      tour: currenTour,
                    ),
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

          return tile(
            City(
              name: data["name"] as String,
              Lng: data["lng"] as double,
              Lat: data["lat"] as double,
            ),
          );

        });
        return ListTile(title: Text("Failed2"));
      },
    );
    return ListTile(title: Text("Failed1"));
  }
}

class User {
  var username;
  var password;

  User();

  User.all({required this.username, required this.password});

  @override
  String toString() {
    return 'User{username: $username, password: $password}';
  }

  Map<String, Object?> toMap() {
    return {'username': username, 'password': password};
  }
}

class Tour {
  var startDate = DateTime.now();
  var endDate = DateTime.now();
  var location;

  List destinations = [];

  Tour();

  Tour.all({
    required this.startDate,
    required this.endDate,
    required this.location,
  });
}

class City {
  var name;
  double Lat;
  double Lng;
  List destinationList = [];
  City({required this.name, required this.Lng, required this.Lat});
  Map<String, Object?> toMap() {
    return {'name': name};
  }
}

class Destination {
  var name;
  var city;

  Destination({required this.name, required this.city});
}
