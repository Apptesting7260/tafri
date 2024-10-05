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


import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  if (message.data.containsKey('content-available')) {
    print('Silent background notification received');
    // Perform any background tasks here
  } else if (message.notification != null) {
    FirebaseApi().showNotification(message);
    // FirebaseApi.snackBar1( message.notification!.title.toString(), message.notification!.body.toString());
    print(
        'message ===  ${message.data}  ===   ${message.notification?.body}   ====   ${message.notification?.title}');
  }
}


class FirebaseApi {
  static String? fcmToken;
  static String? apnToken;

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
      // alert: true,
      // badge: true,
      // sound: true,
      // announcement: true,
    );
  }

  Future<void> _getToken() async {
    fcmToken = await _firebaseMessaging.getToken();
    if(Platform.isIOS) {
      apnToken = await _firebaseMessaging.getAPNSToken();
    }
    print(
        '==========================   fcmToken   ==============================');
    print('  ${fcmToken}');
    print(
        '==========================   fcmToken   ==============================');
    print(" APNS token is -> $apnToken");
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
        // snackBar1(message.notification!.title.toString(), message.notification!.body.toString());

      } else if (message.notification != null && appleNotification != null) {
        print(
            'messageSSSS ===  ${message.data}  ===   ${message.notification?.body}   ====   ${message.notification?.title}');
        // showNotification(message);
        snackBar1(message.notification!.title.toString(), message.notification!.body.toString());
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
    });

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        showNotification(message);
        // snackBar1(message.notification!.title.toString(), message.notification!.body.toString());

      }
      print('FirebaseMessaging.instance.getInitialMessage');
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().microsecond;

      // BigTextStyleInformation allows the notification to display larger content
      final bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body ?? '', // Use the message body
        htmlFormatBigText: true, // For rich content (if HTML is used)
        contentTitle: message.notification!.title, // Notification title
        htmlFormatContentTitle: true,
      );

       var androidNotificationDetails = AndroidNotificationDetails(
        'PlusOne',
        'PlusOne kdfjldskjflsdkjfldsjflsddfldsjfldsfldskjfldsjfldsfldsjfdslkjfdlsjfldskjfd',
        importance: Importance.max,
        priority: Priority.max,
        icon: '@drawable/ic_launcher',
        visibility: NotificationVisibility.public,
        channelShowBadge: true,
        styleInformation: bigTextStyleInformation, // Assign BigTextStyle
      );
      const iosNotificationDetails = DarwinNotificationDetails();

      NotificationDetails notificationDetails =  NotificationDetails(
          iOS: iosNotificationDetails, android: androidNotificationDetails,);
      await _localNotificationsPlugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails);
    } catch (e) {
      print('notification error  ---  ${e.toString()}');
    }
  }

  // static snackBar1(String title, String message) {
  //   Get.snackbar(
  //     title,
  //     message,
  //     backgroundColor: Colors.white54,
  //     colorText: Colors.black,
  //     titleText: Text(
  //       title,
  //       style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold), // Title text color
  //     ),
  //     messageText: Text(
  //       message,
  //       style: TextStyle(color: Colors.black), // Message text color
  //     ),
  //     icon: Image.asset(
  //       'assets/images/launcher.png',
  //     ),
  //     borderRadius: 20,
  //     snackPosition: SnackPosition.TOP,
  //     margin: EdgeInsets.only(left: 10, right: 10),
  //     padding: EdgeInsets.symmetric(vertical: 8),
  //     duration: Duration(seconds: 3),
  //   );
  // }

  static snackBar1(String title, String message) {
    Get.snackbar(
      '',
      '',
      backgroundColor: Colors.white,
      colorText: Colors.black,
      borderRadius: 20,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 0),
      duration: Duration(seconds: 3),
      // Custom layout using Column
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15, bottom: 8), // Space from the left and bottom of the image
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5), // Circular border with radius of 15
              child: Image.asset(
                'assets/images/launcher.png',
                width: 40,  // Set width for the image
                height: 40, // Set height for the image
                fit: BoxFit.cover, // Ensures the image covers the container evenly
              ),
            ),
          ),
          SizedBox(width: 10,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),

                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
                SizedBox(height: 4), // Space between title and message
                Flexible(
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.black),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

 // static void snackBar1(BuildContext context,String title, String message) {
 //    final snackBar = SnackBar(
 //      backgroundColor: Colors.red,
 //      content: Row(
 //        crossAxisAlignment: CrossAxisAlignment.start,
 //        children: [
 //          Container(
 //            margin: EdgeInsets.only(right: 10), // Space from the right of the image
 //            child: ClipRRect(
 //              borderRadius: BorderRadius.circular(5), // Circular border with radius of 5
 //              child: Image.asset(
 //                'assets/images/launcher.png',
 //                width: 40,  // Set width for the image
 //                height: 40, // Set height for the image
 //                fit: BoxFit.cover, // Ensures the image covers the container evenly
 //              ),
 //            ),
 //          ),
 //          Expanded( // Use Expanded to ensure the text takes the remaining space
 //            child: Column(
 //              crossAxisAlignment: CrossAxisAlignment.start,
 //              children: [
 //                Text(
 //                  title,
 //                  style: TextStyle(
 //                    color: Colors.black,
 //                    fontWeight: FontWeight.bold,
 //                  ),
 //                  softWrap: true,
 //                ),
 //                SizedBox(height: 4), // Space between title and message
 //                Text(
 //                  message,
 //                  style: TextStyle(color: Colors.black),
 //                  softWrap: true,
 //                ),
 //              ],
 //            ),
 //          ),
 //        ],
 //      ),
 //      duration: Duration(seconds: 3),
 //      behavior: SnackBarBehavior.floating, // Make it float above the content
 //      margin: EdgeInsets.symmetric(horizontal: 10), // Adjust margin if needed
 //      shape: RoundedRectangleBorder(
 //        borderRadius: BorderRadius.circular(20), // Rounded corners
 //      ),
 //    );
 //
 //    // Show the snackbar
 //    ScaffoldMessenger.of(context).showSnackBar(snackBar);
 //  }


  // static void snackBar1(BuildContext context, String title, String message) {
  //   // Create the overlay entry for the snackbar
  //   OverlayEntry overlayEntry = OverlayEntry(
  //     builder: (context) => Positioned(
  //       top: MediaQuery.of(context).padding.top + 10, // Top padding
  //       left: 10,
  //       right: 10,
  //       child: Material(
  //         color: Colors.transparent,
  //         child: Container(
  //           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Container(
  //                 margin: EdgeInsets.only(right: 10), // Space from the right of the image
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(5),
  //                   child: Image.asset(
  //                     'assets/images/launcher.png',
  //                     width: 40, // Set width for the image
  //                     height: 40, // Set height for the image
  //                     fit: BoxFit.cover, // Ensures the image covers the container evenly
  //                   ),
  //                 ),
  //               ),
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       title,
  //                       style: TextStyle(
  //                         color: Colors.black,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                       softWrap: true,
  //                     ),
  //                     SizedBox(height: 4), // Space between title and message
  //                     Text(
  //                       message,
  //                       style: TextStyle(color: Colors.black),
  //                       softWrap: true,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  //
  //   // Show the snackbar
  //   Overlay.of(context)?.insert(overlayEntry);
  //
  //   // Remove the snackbar after a delay
  //   Future.delayed(Duration(seconds: 3), () {
  //     overlayEntry.remove();
  //   });
  // }



}
