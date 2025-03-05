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


import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/message/chats/controller/group_chat_controller.dart';
import 'package:plusone/uis/message/chats/controller/socket_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/local_storage.dart';

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

  Future<void> initializeNotification(BuildContext context) async {
    await _requestPermission();
    await _getToken();
    await _initializeLocalNotification();
    await _handleNotification(context);
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

        /// call when app is in running state and tap on notification

        if (details.payload != null) {
          print(
              'details a =  ${details.id}  ===  ${details.notificationResponseType}  ==  ${details.input}   ===  ${details.payload}');
          final Map<String, dynamic> data = jsonDecode(details.payload!);
          print('data == ${data['activity_id']}');

          bool from = data.containsKey('chatType');
          if(from){

            if(data['chatType'] == 'personal'){
              Get.toNamed(Routes.poSupportChat,arguments: data['friendsAndConversationId'])?.then((value) {
                if(Get.isRegistered<SocketController>()){
                  Get.find<SocketController>().fetchGroup();
                }
              },);
            }else if(data['chatType'] == 'group'){
              if(Get.isRegistered<GroupChatController>()){
                Get.delete<GroupChatController>();
                Get.back();
              }
              Future.delayed(Duration(milliseconds: 500),() {
                Get.toNamed(Routes.chatUi,arguments: {
                  'gpID': data['chatGroupId'],
                  'activityId': data['activityId'].toString(),
                  'hostId': data['createdBy'].toString()
                })?.then((value) {
                  if(Get.isRegistered<SocketController>()){
                    Get.find<SocketController>().fetchGroup();
                  }
                },);
              },);
            }

          }else if(LocalStorage.getUid().toString() == data['host_id']){

            if(data['status'] == 'approved'){
              Get.toNamed(Routes.hostUpcommingActiview, arguments: data['activity_id'].toString());
            }else if(data['status'] == 'pending'){
              Get.toNamed(Routes.hostUpcommingActiview, arguments: data['activity_id'].toString());
            }else if(data['status'] == 'completed'){
              Get.toNamed(Routes.previousActivityUi, arguments: {
                "isHost": true,
                'id': data['activity_id'].toString()
              });
            }else if(data['status'] == 'not_approved'){
              Get.toNamed(Routes.hostUpcommingActiview, arguments: data['activity_id'].toString());
            }else{
              Get.toNamed(Routes.navbarUi);
            }

          }else{

            if(data['status'] == 'approved'){
              Get.toNamed(Routes.exploreView, arguments: data['activity_id'].toString());
            }else if(data['status'] == 'pending'){
              Get.toNamed(Routes.navbarUi);
            }else if(data['status'] == 'completed'){
              Get.toNamed(Routes.previousActivityUi, arguments: {
                "isHost": false,
                "id":  data['activity_id'].toString()
              });
            }else if(data['status'] == 'not_approved'){
              Get.toNamed(Routes.navbarUi);
            }else{
              Get.toNamed(Routes.navbarUi);
            }

          }

        } else {
          print(
              'no details  =  ${details.id}  ===  ${details.notificationResponseType}  ==  ${details.input}   ===  ${details.payload}');
          Get.toNamed(Routes.navbarUi);
        }
      },
    );
  }

  Future<void> _handleNotification(BuildContext context) async {
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

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
        // snackBar1(message.notification!.title.toString(), message.notification!.body.toString());
        showCustomSnackbar(message.notification!.title.toString(), message.notification!.body.toString(), context);
      }
    });

    /// call when app is in background and tap on notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
      if(message != null) {
        final Map<String, dynamic> data = message!.data;

        if (data != null) {
          print('data == ${data['activity_id']}');

          bool from = data.containsKey('chatType');
          if(from){

            if(data['chatType'] == 'personal'){
              Get.toNamed(Routes.poSupportChat,arguments: data['friendsAndConversationId'])?.then((value) {
                if(Get.isRegistered<SocketController>()){
                  Get.find<SocketController>().fetchGroup();
                }
              },);
            }else if(data['chatType'] == 'group'){
              if(Get.isRegistered<GroupChatController>()){
                Get.delete<GroupChatController>();
                Get.back();
              }
              Future.delayed(Duration(milliseconds: 500),() {
                Get.toNamed(Routes.chatUi,arguments: {
                  'gpID': data['chatGroupId'],
                  'activityId': data['activityId'].toString(),
                  'hostId': data['createdBy'].toString()
                })?.then((value) {
                  if(Get.isRegistered<SocketController>()) {
                    Get.find<SocketController>().fetchGroup();
                  }
                },);
              },);
            }

          } else if (LocalStorage.getUid().toString() == data['host_id']) {
            if (data['status'] == 'approved') {
              Get.toNamed(Routes.hostUpcommingActiview,
                  arguments: data['activity_id'].toString());
            } else if (data['status'] == 'pending') {
              Get.toNamed(Routes.hostUpcommingActiview,
                  arguments: data['activity_id'].toString());
            } else if (data['status'] == 'completed') {
              Get.toNamed(Routes.previousActivityUi, arguments: {
                "isHost": true,
                'id': data['activity_id'].toString()
              });
            } else if (data['status'] == 'not_approved') {
              Get.toNamed(Routes.hostUpcommingActiview,
                  arguments: data['activity_id'].toString());
            } else {
              Get.toNamed(Routes.navbarUi);
            }
          } else {
            if (data['status'] == 'approved') {
              Get.toNamed(Routes.exploreView,
                  arguments: data['activity_id'].toString());
            } else if (data['status'] == 'pending') {
              Get.toNamed(Routes.navbarUi);
            } else if (data['status'] == 'completed') {
              Get.toNamed(Routes.previousActivityUi, arguments: {
                "isHost": false,
                "id": data['activity_id'].toString()
              });
            } else if (data['status'] == 'not_approved') {
              Get.toNamed(Routes.navbarUi);
            } else {
              Get.toNamed(Routes.navbarUi);
            }
          }
        } else {
          Get.toNamed(Routes.navbarUi);
        }
      }
    });

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        showNotification(message);
        // snackBar1(message.notification!.title.toString(), message.notification!.body.toString());

      }

      if(message != null) {
        final Map<String, dynamic> data = message!.data;

        if (data != null) {
          print('data == ${data['activity_id']}');
          bool from = data.containsKey('chatType');
          if(from){

            if(data['chatType'] == 'personal'){
              Get.toNamed(Routes.poSupportChat,arguments: data['friendsAndConversationId'])?.then((value) {
                if(Get.isRegistered<SocketController>()){
                  Get.find<SocketController>().fetchGroup();
                }
              },);
            }else if(data['chatType'] == 'group'){
              if(Get.isRegistered<GroupChatController>()){
                Get.delete<GroupChatController>();
                Get.back();
              }
              Future.delayed(Duration(milliseconds: 500),() {
                Get.toNamed(Routes.chatUi,arguments: {
                  'gpID': data['chatGroupId'],
                  'activityId': data['activityId'].toString(),
                  'hostId': data['createdBy'].toString()
                })?.then((value) {
                  if(Get.isRegistered<SocketController>()){
                    Get.find<SocketController>().fetchGroup();
                  }
                },);
              },);
            }

          }else if (LocalStorage.getUid().toString() == data['host_id']) {
            if (data['status'] == 'approved') {
              Get.toNamed(Routes.hostUpcommingActiview,
                  arguments: data['activity_id'].toString());
            } else if (data['status'] == 'pending') {
              Get.toNamed(Routes.hostUpcommingActiview,
                  arguments: data['activity_id'].toString());
            } else if (data['status'] == 'completed') {
              Get.toNamed(Routes.previousActivityUi, arguments: {
                "isHost": true,
                'id': data['activity_id'].toString()
              });
            } else if (data['status'] == 'not_approved') {
              Get.toNamed(Routes.hostUpcommingActiview,
                  arguments: data['activity_id'].toString());
            } else {
              Get.toNamed(Routes.navbarUi);
            }
          } else {
            if (data['status'] == 'approved') {
              Get.toNamed(Routes.exploreView,
                  arguments: data['activity_id'].toString());
            } else if (data['status'] == 'pending') {
              Get.toNamed(Routes.navbarUi);
            } else if (data['status'] == 'completed') {
              Get.toNamed(Routes.previousActivityUi, arguments: {
                "isHost": false,
                "id": data['activity_id'].toString()
              });
            } else if (data['status'] == 'not_approved') {
              Get.toNamed(Routes.navbarUi);
            } else {
              Get.toNamed(Routes.navbarUi);
            }
          }
        } else {
          Get.toNamed(Routes.navbarUi);
        }
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
        'PlusOne',
        importance: Importance.max,
        priority: Priority.max,
        icon: '@drawable/ic_launcher',
        visibility: NotificationVisibility.public,
        channelShowBadge: true,
        styleInformation: bigTextStyleInformation, // Assign BigTextStyle
      );
      const iosNotificationDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      NotificationDetails notificationDetails =  NotificationDetails(
          iOS: iosNotificationDetails, android: androidNotificationDetails,);
      await _localNotificationsPlugin.show(
          id, message.notification!.title,
          message.notification!.body,
          notificationDetails,
        payload: message.data.isNotEmpty ? jsonEncode(message.data) : null,
      );
    } catch (e) {
      print('notification error  ---  ${e.toString()}');
    }
  }


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
                'assets/images/launcher.webp',
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


  static showCustomSnackbar(String title, String message,BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            'assets/images/launcher.webp',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold,color: clrBlacke),
                  maxLines: 1,
                ),
                Flexible(
                  child: Text(
                    message,
                    style: TextStyle(color: clrGreyDark),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: clrGreyLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
      padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
      margin: EdgeInsets.only(
        bottom: Get.height - (Get.height*0.28),
        left: 10,
        right: 10
      ),
      dismissDirection: DismissDirection.up,
    );

    // Show the custom Snackbar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }



}
