 import UIKit
 import Flutter
 import FirebaseCore
 import FirebaseMessaging
 import FirebaseAuth
 import GoogleMaps
 import app_links


 @main
 @objc class AppDelegate: FlutterAppDelegate {
   override func application(
     _ application: UIApplication,
     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
   ) -> Bool {
     FirebaseApp.configure()
     GMSServices.provideAPIKey("AIzaSyAP3QLpyPPT0ba8RnZCCEIHpMLnh_hPNRM")


     GeneratedPluginRegistrant.register(with: self)
       
       
     if let url = AppLinks.shared.getLink(launchOptions: launchOptions) {
             // We have a link, propagate it to your Flutter app or not
             AppLinks.shared.handleLink(url: url)
             return true // Returning true will stop the propagation to other packages
     }
       
     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
   }
     override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let firebaseAuth = Auth.auth()
        firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.sandbox) //AuthAPNSTokenType.sandbox

    }

     override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let firebaseAuth = Auth.auth()
        if (firebaseAuth.canHandleNotification(userInfo)){
            print(userInfo)
            return
        }
    }
 }



//
// import UIKit
// import Flutter
// import FirebaseCore
// import FirebaseMessaging
// import UserNotifications
//
// @main
// @objc class AppDelegate: FlutterAppDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
//
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     // Configure Firebase
//     FirebaseApp.configure()
//
//     // Register generated plugins
//     GeneratedPluginRegistrant.register(with: self)
//
//     // Set the messaging delegate
//     Messaging.messaging().delegate = self
//
//     // Request notification permissions
//     UNUserNotificationCenter.current().delegate = self
//     UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
//       print("Permission granted: \(granted)")
//     }
//
//     // Register for remote notifications
//     application.registerForRemoteNotifications()
//
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
//
//   // MARK: - Firebase Messaging Delegate Methods
//
//   // Called when a new FCM token is generated
//   func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//     print("Firebase registration token: \(String(describing: fcmToken))")
//     // Optionally, send the token to your server
//   }
//
//   // MARK: - UNUserNotificationCenter Delegate Methods
//
//   // Handle notification when the app is in the foreground
//   func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//     // Show the notification even if the app is in the foreground
//     completionHandler([.alert, .badge, .sound])
//   }
//
//   // Handle tapping the notification when the app is in the background or terminated
//   func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//     let userInfo = response.notification.request.content.userInfo
//     // Handle the notification data
//     if let messageId = userInfo["gcm.message_id"] {
//       print("Message ID: \(messageId)")
//     }
//     // Do something with the notification data
//     completionHandler()
//   }
//
//   // Handle background notifications
//   override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//     print("Received remote notification in background: \(userInfo)")
//     completionHandler(.newData)
//   }
//
//   // This function is called when APNs successfully registers the app with the device token
//   override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//     Messaging.messaging().apnsToken = deviceToken
//     print("APNs Token: \(deviceToken)")
//   }
// }
