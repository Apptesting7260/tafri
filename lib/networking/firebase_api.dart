import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    FirebaseApi().showNotification(message);
    print('message ===  ${message.data}  ===   ${message.notification?.body}   ====   ${message.notification?.title}');
  }
}

class FirebaseApi {

  final _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    if (Platform.isIOS) {

      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission for notifications');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted notification permission');
        return;
      }
    } else {
      await _firebaseMessaging.requestPermission();
    }

    final fCMToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fCMToken');

    initPushNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    print('Received a message: ${message.notification?.title} - ${message.notification?.body}');
  }

  Future<void> initPushNotifications() async {
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    // FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        showNotification(message);
      }
      print('FirebaseMessaging.instance.getInitialMessage');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
      print('Received a foreground message: ${message.notification?.title} - ${message.notification?.body}');
    });


    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  Future<void> showNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().microsecond;

      const androidNotificationDetails = AndroidNotificationDetails(
        'PlusOne',
        'PlusOne',
        importance: Importance.max,
        priority: Priority.max,
        icon: '@drawable/ic_launcher',
        visibility: NotificationVisibility.public,
        channelShowBadge: true,
      );
      const iosNotificationDetails = DarwinNotificationDetails();

      NotificationDetails notificationDetails = const NotificationDetails(
          android: androidNotificationDetails, iOS: iosNotificationDetails);
      await _localNotificationsPlugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails);
    } catch (e) {
      print('notification error  ---  ${e.toString()}');
    }
  }

}

