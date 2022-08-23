import 'package:flutter/material.dart';
import 'package:test_test_dart/database/db_constant.dart';
import 'package:test_test_dart/database/db_helper.dart';
import 'package:test_test_dart/notification/notification_helper.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child:RaisedButton(onPressed: () async{
           NotificationHelper().showNotification();


          },child: Text("now"),),

        ),
        SizedBox(height: 20,),
        RaisedButton(onPressed: () async{
          NotificationHelper().showNotificationSchedule(Duration(seconds: 5));

        },child: Text("schedule"),),
        SizedBox(height: 20,),
        RaisedButton(onPressed: () async{
          NotificationHelper().showNotificationPerodicRepeat();

        },child: Text("repeat"),),


      ],
    ));
  }
}
