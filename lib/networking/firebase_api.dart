// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// Future<void> backgroundHandler(RemoteMessage message) async {
//   if (message.notification != null) {
//     FirebaseApi().showNotification(message);
//     print('message ===  ${message.data}  ===   ${message.notification?.body}   ====   ${message.notification?.title}');
//   }
// }
//
// class FirebaseApi {
//
//   final _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   Future<void> initNotifications() async {
//     if (Platform.isIOS) {
//
//       NotificationSettings settings = await _firebaseMessaging.requestPermission(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//
//       if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//         print('User granted permission for notifications');
//       } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//         print('User granted provisional permission');
//       } else {
//         print('User declined or has not accepted notification permission');
//         return;
//       }
//     } else {
//       await _firebaseMessaging.requestPermission();
//     }
//
//     final fCMToken = await _firebaseMessaging.getToken();
//     print('FCM Token: $fCMToken');
//
//     initPushNotifications();
//   }
//
//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return;
//
//     print('Received a message: ${message.notification?.title} - ${message.notification?.body}');
//   }
//
//   Future<void> initPushNotifications() async {
//     FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//
//     // FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
//       if (message != null) {
//         showNotification(message);
//       }
//       print('FirebaseMessaging.instance.getInitialMessage');
//     });
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       showNotification(message);
//       print('Received a foreground message: ${message.notification?.title} - ${message.notification?.body}');
//     });
//
//
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//   }
//
//   Future<void> showNotification(RemoteMessage message) async {
//     try {
//       final id = DateTime.now().microsecond;
//
//       const androidNotificationDetails = AndroidNotificationDetails(
//         'PlusOne',
//         'PlusOne',
//         importance: Importance.max,
//         priority: Priority.max,
//         icon: '@drawable/ic_launcher',
//         visibility: NotificationVisibility.public,
//         channelShowBadge: true,
//       );
//       const iosNotificationDetails = DarwinNotificationDetails();
//
//       NotificationDetails notificationDetails = const NotificationDetails(
//           android: androidNotificationDetails, iOS: iosNotificationDetails);
//       await _localNotificationsPlugin.show(id, message.notification!.title,
//           message.notification!.body, notificationDetails);
//     } catch (e) {
//       print('notification error  ---  ${e.toString()}');
//     }
//   }
//
// }
//


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    FirebaseApi().showNotification(message);
    print(
        'message ===  ${message.data}  ===   ${message.notification?.body}   ====   ${message.notification?.title}');
  }
}

class FirebaseApi {
  static String? fcmToken;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification() async {
    await _requestPermission();
    await _getToken();
    await _initializeLocalNotification();
    await _handleNotification();
  }

  Future<void> _requestPermission() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: true,
    );
  }

  Future<void> _getToken() async {
    fcmToken = await _firebaseMessaging.getToken();
    print(
        '==========================   fcmToken   ==============================');
    print('  ${fcmToken}');
    print(
        '==========================   fcmToken   ==============================');
  }

  // Future<void> _initializeLocalNotification() async {
  //   const DarwinInitializationSettings iosInitializationSettings =
  //   DarwinInitializationSettings(
  //     requestAlertPermission: true,
  //     requestBadgePermission: true,
  //     requestSoundPermission: true,
  //   );
  //
  //   final InitializationSettings initializationSettings =
  //   const InitializationSettings(iOS: iosInitializationSettings);
  //
  //   await _localNotificationsPlugin.initialize(
  //     initializationSettings,
  //     onDidReceiveNotificationResponse: (details) {
  //       print(
  //           'no details  =  ${details.id}  ===  ${details.notificationResponseType}  ==  ${details.input}   ===  ${details.payload}');
  //     },
  //   );
  // }

  Future<void> _initializeLocalNotification() async {
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInitializationSettings =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings);
    _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {
          print('notification type =   ${details.notificationResponseType}');
          print(
              'no details  =  ${details.id}  ===  ${details.notificationResponseType}  ==  ${details.input}   ===  ${details.payload}');
        } else {
          print(
              'no details  =  ${details.id}  ===  ${details.notificationResponseType}  ==  ${details.input}   ===  ${details.payload}');
        }
      },
    );
  }

  Future<void> _handleNotification() async {
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   AndroidNotification? androidNotification = message.notification?.android;
    //   AppleNotification? appleNotification = message.notification?.apple;
    //   print('Received a foreground message');
    //   if (message.notification != null && appleNotification != null) {
    //     showNotification(message);
    //   }
    // });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AndroidNotification? androidNotification = message.notification?.android;
      AppleNotification? appleNotification = message.notification?.apple;
      print('Received a foreground message');
      if (message.notification != null && androidNotification != null) {
        print(
            'message ===  ${message.data}  ===   ${message.notification?.body}   ====   ${message.notification?.title}');
        showNotification(message);
      } else if (message.notification != null && appleNotification != null) {
        print(
            'messageSSSS ===  ${message.data}  ===   ${message.notification?.body}   ====   ${message.notification?.title}');
        showNotification(message);
        snackBar1(message.notification!.title.toString(), message.notification!.body.toString());
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
    });

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        showNotification(message);
      }
      print('FirebaseMessaging.instance.getInitialMessage');
    });
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
          iOS: iosNotificationDetails, android: androidNotificationDetails,);
      await _localNotificationsPlugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails);
    } catch (e) {
      print('notification error  ---  ${e.toString()}');
    }
  }

  static snackBar1(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.white54,
      colorText: Colors.black,
      titleText: Text(
        title,
        style: TextStyle(color: Colors.black), // Title text color
      ),
      messageText: Text(
        message,
        style: TextStyle(color: Colors.black), // Message text color
      ),
      icon: Image.asset(
        'assets/images/launcher.png',
      ),
      borderRadius: 20,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.symmetric(vertical: 8),
      duration: Duration(seconds: 3),
    );
  }

}
