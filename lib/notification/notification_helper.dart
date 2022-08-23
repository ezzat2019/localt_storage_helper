import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  late AndroidNotificationDetails androidPlatformChannelSpecifics;
  NotificationDetails? platformChannelSpecifics;

  init() async {
    tz.initializeTimeZones();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');


    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

  }

  onDidReceiveLocalNotification(id, title, body, payload) {
    print("ios notification clicked");
  }

  selectNotification(paylod) {
    print("android notification clicked");
  }

  showNotification() async {
    buildChannelSpecifics();
    await flutterLocalNotificationsPlugin.show(
        1, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  buildChannelSpecifics(){
    androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'high_importance_channel',  'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
  }
  showNotificationSchedule(Duration duration) async {
    buildChannelSpecifics();
    tz.TZDateTime dateTime = tz.TZDateTime.now(tz.local).add(duration);
    await flutterLocalNotificationsPlugin.zonedSchedule(2, 'scheduled title',
        'scheduled body', dateTime, platformChannelSpecifics!,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  showNotificationPerodicRepeat() async {
    buildChannelSpecifics();
    int i = Random(5).nextInt(100);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        3,
        'repeating title $i',
        'repeating body',
        RepeatInterval.everyMinute,
        platformChannelSpecifics!,
        androidAllowWhileIdle: true);
  }
}
