import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppNotifications {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/launcher_icon');
    var iosInitialize = const DarwinInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iosInitialize);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showNotification(
      {required int id,
      required String ?title,
      required String ?body,
      var playload,
      required FlutterLocalNotificationsPlugin
          flutterLocalNotificationsPlugin}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'top1ive_notifications_id',
      'channelName',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    var not=NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );
    await flutterLocalNotificationsPlugin.show(id, title, body, not);
  }
}
