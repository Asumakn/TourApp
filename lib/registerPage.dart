
import 'package:finalprojectapp/main.dart';
import 'package:finalprojectapp/settingsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'mainPage.dart';
import 'DataController.dart';

class myAppRegister extends StatefulWidget {

  @override
  State<myAppRegister> createState() => _myAppRegisterState();
}

class _myAppRegisterState extends State<myAppRegister> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Register Page",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),backgroundColor: ThemeColor.main,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 50,
          children: [
            Container(
              margin: EdgeInsets.all(30),
              child:TextField(
                decoration:InputDecoration(
                hintText: 'Enter Username',
              ),
                controller: usernameController,
                style: TextStyle(fontSize: 25),
              ),
            ),
            Container(
              margin: EdgeInsets.all(30),
              child:TextField(
                decoration:InputDecoration(
                hintText: 'Enter Password',
              ),
                controller: passwordController,
                style: TextStyle(fontSize: 25),
                obscureText: true,
              ),
            ),
           SizedBox(
             height: 50,
           ),
           SizedBox(
             width: 400,
             child:  ElevatedButton(
                 style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder()),
                 onPressed: (){


                DataController.createUser(username: usernameController.text, password: passwordController.text);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:Text("The User ${usernameController.text} has been added"),
                  duration: Duration(seconds: 3),));
                _clear();
             }, child: Text("Register")),
           ),
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