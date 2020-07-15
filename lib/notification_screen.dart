import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'main.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  showNotification() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 5));
    var scheduledNotificationDateTime2 =
        DateTime.now().add(Duration(seconds: 10));
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'channel_ID', 'channel name', 'channel description',
        priority: Priority.High,
        importance: Importance.Max,
        ticker: 'test ticker');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'New Video is out',
        'Flutter Local Notification',
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        payload: 'test payload');
    await flutterLocalNotificationsPlugin.schedule(
        1,
        'Notification2',
        'Flutter Local Notification2',
        scheduledNotificationDateTime2,
        platformChannelSpecifics,
        payload: 'test payload');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Local Notification'),
      ),
      body: Center(
        child: RaisedButton(
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
