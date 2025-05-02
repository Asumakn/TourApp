
import 'package:finalprojectapp/chooseLocationPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'DataController.dart';
import 'settingsPage.dart';

void main(){


}
Tour tour = new Tour();
class datePickPage extends StatefulWidget {

  @override
  State<datePickPage> createState() => _datePickPageState();

  datePickPage();


}

class _datePickPageState extends State<datePickPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,leading: Icon(Icons.calendar_month,size: 50,),title: Text("Enter your Trip Dates", style: TextStyle(color: Colors.white),),backgroundColor: ThemeColor.main,),
    body: Center(
      child: Column(children: [
        Title(color: ThemeColor.main, child: Text("Pick Start Date",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
        CalendarDatePicker( initialDate: DateTime.now(), firstDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day), lastDate: DateTime(DateTime.now().year+1,DateTime.now().month,DateTime.now().day), onDateChanged: (DateTime date){
          tour.startDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(date));
        }),

        Title(color:ThemeColor.main, child: Text("Pick End Date ", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
        CalendarDatePicker(initialDate: DateTime.now(), firstDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day), lastDate: DateTime(DateTime.now().year+1,DateTime.now().month,DateTime.now().day), onDateChanged: (DateTime date){
          tour.endDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(date));
        },),
        ElevatedButton(onPressed: (){
          if(tour.startDate.isBefore(tour.endDate)) {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => chooseLocationPage(currentTour: tour)));
          }else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Please enter Valid Dates"),
              duration: Duration(seconds: 3),));
          }
        }, style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder())
            ,child: Text("Next"))

      ],),
    ),
    );
  }
}
