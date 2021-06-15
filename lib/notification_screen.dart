import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import 'main.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  showNotification() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'channel_ID', 'channel name', 'channel description',
        priority: Priority.high,
        importance: Importance.max,
        ticker: 'test ticker');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'New Video is out',
        'Flutter Local Notification',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        'Notification2',
        'Flutter Local Notification2',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Local Notification'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: showNotification,
          child: Text(
            'Demo',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ),
    );
  }
}
