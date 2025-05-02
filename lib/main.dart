import 'dart:async';

import 'package:finalprojectapp/chooseDestinationsPage.dart';
import 'package:finalprojectapp/datePickPage.dart';
import 'package:finalprojectapp/profilePage.dart';
import 'package:finalprojectapp/settingsPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'DataController.dart';
import 'mainPage.dart';
import 'registerPage.dart';
import 'chooseLocationPage.dart';
import 'package:firestore_cache/firestore_cache.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDaEvv07d_PgP5LlHDFvd0lbC0WtiASUPI",
        appId: "481547494451",
        messagingSenderId: "1:481547494451:android:210ea67f36fef2e2b2ef46",
        projectId: "finalappdb-99596"),
  );
  runApp(MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/Home",
      routes: {
        "/": (context)=>myAppLogin(),
        "/Home":(context)=>myAppMain(),
        "/register": (context)=> myAppRegister(),
        "/date": (context)=> datePickPage(),
        "/dest": (context)=> chooseDestinationPage(city: new City(name: "Munich", Lng: 48.137154, Lat: 11.576124), tour: tour),
        "/Profile": (context)=> profilePage.user(User.all(username: "username", password: "password")),
        "/Settings": (context)=> settingsPage(),
      },

    );
  }
}

class myAppHome extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return myAppLogin();
  }
}

class myAppLogin extends StatefulWidget {

  @override
  State<myAppLogin> createState() => _myAppLoginState();
}


class _myAppLoginState extends State<myAppLogin> {

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {



    return  Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Login Page",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),backgroundColor: Colors.blue,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(60),
              child:TextField(
                decoration:InputDecoration(
                  hintText: 'Enter Username',
                ) ,
                controller: usernameController,
                style: TextStyle(fontSize: 25),
              ),
            ),
            Container(
              margin: EdgeInsets.all(60),
              child:TextField(
                decoration:InputDecoration(
                  hintText: 'Enter Password',
                ) ,
                controller: passwordController,
                style: TextStyle(fontSize: 25),
                obscureText: true,
              ),
            ),
SizedBox(
  height: 110,
),
            SizedBox(
              width: 400,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder()),
                  onPressed: (){
            for(var item in DataController.userList){
            if(usernameController.text == item.username){
            if(passwordController.text == item.password){
            _clear();
            myAppMain.user=item;
            Navigator.push(context, MaterialPageRoute(builder: (context)=>myAppMain()));
            }
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password is Incorrect")));
            }
            }
            setState(() {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Username is Invalid")));
            });
            }, child: Text("Enter")),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 400,
              child:  ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> myAppRegister()));
              }, child: Text("Register"),
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder()),

              ),
            )

          ],
        ),
      ),
    );
  }
  _clear(){
    usernameController.clear();
    passwordController.clear();
  }
  }
   _tile(Tour tour) {
     return ListTile(
       title: Text("Tour in ${tour.location}",
           style: TextStyle(fontWeight: FontWeight.bold)),
       subtitle: Text("From ${tour.startDate} to ${tour.endDate}",),
       trailing: Text(tour.destinations.length.toString(),
         style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
     );
   }

