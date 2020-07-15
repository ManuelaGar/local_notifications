import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'second_screen.dart';

void main() => runApp(new MaterialApp(home: new MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var initializationSettingsAndroid;
  var initializationSettingsiOS;
  var initializationSettings;

  scheduleNotification1() async {
    var scheduledNotificationDateTime =
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
  }

  scheduleNotification2() async {
    var scheduledNotificationDateTime2 =
        DateTime.now().add(Duration(seconds: 20));
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'channel_ID', 'channel name', 'channel description',
        priority: Priority.High,
        importance: Importance.Max,
        ticker: 'test ticker');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        1,
        'Notification2',
        'Flutter Local Notification2',
        scheduledNotificationDateTime2,
        platformChannelSpecifics,
        payload: 'test payload');
  }

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
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    initializationSettingsiOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsiOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondScreen(payload),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      print("payload : $payload");
    }
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => SecondScreen(payload)));
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
