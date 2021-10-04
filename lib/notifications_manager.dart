import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

BuildContext context1;
void notificationsManager(BuildContext context) {
  context1 = context;
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(
      callbackDispatcher,
      isInDebugMode: false
  );
// Periodic task registration
  Workmanager.registerPeriodicTask(
    "2",
    "simplePeriodicTask",
    frequency: Duration(hours: 6),
  );
}
Future notificationSelected(String payload) async {
  Navigator.of(context1)
      .pushNamed('/');
}


void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {

    FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('logo1');
    var IOS = new IOSInitializationSettings();

    var settings = new InitializationSettings(android: android, iOS: IOS);
    flip.initialize(settings, onSelectNotification: notificationSelected);
    _showNotificationWithDefaultSound(flip);
    return Future.value(true);
  });
}

Future _showNotificationWithDefaultSound(flip) async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: InboxStyleInformation(
        ['<p>How do you feel now? Please fill in the details.</p>', '<div style="float : right;"><strong >Tap to go to the app</strong></div>'],
        contentTitle: "<i>CoviApp</i>",
        summaryText: "summary",
        htmlFormatContent: true,
        htmlFormatContentTitle: true,
        htmlFormatSummaryText: true,
        htmlFormatLines: true,
        htmlFormatTitle: true,
      ),
  );
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

// initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics
  );
  await flip.show(0, 'CoviApp',
      ' How do you feel now?\n Please fill in the details in the App\n so that we can help you better',
      platformChannelSpecifics, payload: 'Default_Sound'
  );
}
