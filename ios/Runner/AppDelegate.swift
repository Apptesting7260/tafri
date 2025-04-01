//  import UIKit
//  import Flutter
//  import FirebaseCore
//  import FirebaseMessaging
//  import FirebaseAuth
//  import GoogleMaps
//  import app_links
//
//
//  @main
//  @objc class AppDelegate: FlutterAppDelegate {
//    override func application(
//      _ application: UIApplication,
//      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//    ) -> Bool {
//      FirebaseApp.configure()
//      GMSServices.provideAPIKey("AIzaSyAP3QLpyPPT0ba8RnZCCEIHpMLnh_hPNRM")
//
//
//      GeneratedPluginRegistrant.register(with: self)
//
//
//      if let url = AppLinks.shared.getLink(launchOptions: launchOptions) {
//              // We have a link, propagate it to your Flutter app or not
//              AppLinks.shared.handleLink(url: url)
//              return true // Returning true will stop the propagation to other packages
//      }
//
//      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//    }
//      override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//         let firebaseAuth = Auth.auth()
//         firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.prod) //AuthAPNSTokenType.sandbox
//
//     }
//
//      override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//         let firebaseAuth = Auth.auth()
//         if (firebaseAuth.canHandleNotification(userInfo)){
//             print(userInfo)
//             return
//         }
//     }
//  }
//



import UIKit
import Flutter
import FirebaseCore
import FirebaseMessaging
import FirebaseAuth
import GoogleMaps
import app_links
import StoreKit

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
            AppLinks.shared.handleLink(url: url)
            return true
        }

        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "external_purchase_channel", binaryMessenger: controller.binaryMessenger)

        channel.setMethodCallHandler { (call, result) in
            if call.method == "canPresent" {
                if #available(iOS 17.4, *) {
                    result(SKExternalPurchase.canPresent)
                } else {
                    result(false)
                }
            } else if call.method == "presentNoticeSheet" {
                if #available(iOS 17.4, *) {
                    Task {
                        do {
                            let noticeResult = try await SKExternalPurchase.presentNoticeSheet()
                            switch noticeResult {
                            case .continuedWithExternalPurchaseToken(let token):
                                result(token)
                            default:
                                result(nil)
                            }
                        } catch {
                            result(nil)
                        }
                    }
                } else {
                    result(nil)
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let firebaseAuth = Auth.auth()
        firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.prod)
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
// class ExternalPurchase {
//   static const MethodChannel _channel =
//       MethodChannel('external_purchase_channel');
//
//   static Future<bool> canPresent() async {
//     return await _channel.invokeMethod<bool>('canPresent') ?? false;
//   }
//
//   static Future<String?> presentNoticeSheet() async {
//     return await _channel.invokeMethod<String>('presentNoticeSheet');
//   }
// }
//
// void handleExternalPurchase() async {
//   bool canUseExternalPurchase = await ExternalPurchase.canPresent();
//
//   if (canUseExternalPurchase) {
//     String? token = await ExternalPurchase.presentNoticeSheet();
//
//     if (token != null) {
//       // Send this token to your server to process the transaction
//       print("External Purchase Token: $token");
//     } else {
//       print("User canceled the external purchase");
//     }
//   } else {
//     print("External purchases not available on this device");
//   }
// }