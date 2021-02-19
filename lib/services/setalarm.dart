import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_active_prf/main.dart';

DateTime _alarmTime;

//helper function to scheduel notifications using #local_notifications package.
void scheduleAlarm(DateTime scheduledNotificationDateTime) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'alarm_notif',
    'alarm_notif',
    'Channel for Alarm notification',
    icon: 'ucon',
    largeIcon: DrawableResourceAndroidBitmap('ucon'),
  );

  var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true);
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.schedule(0, 'Active time!',
      "let's workout", scheduledNotificationDateTime, platformChannelSpecifics);
}

void onSaveAlarm() {
  DateTime scheduleAlarmDateTime;
  if (_alarmTime.isAfter(DateTime.now()))
    scheduleAlarmDateTime = _alarmTime;
  else
    scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));
  scheduleAlarm(scheduleAlarmDateTime);
}
