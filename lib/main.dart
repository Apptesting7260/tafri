import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plusone/networking/checkconnection.dart';
import 'package:plusone/networking/firebase_api.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/explore/explorelist/controller/explorelist_controller.dart';
import 'package:plusone/uis/onbording/introone/binding/intro_binding.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
    if(Platform.isAndroid) {
      await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyAeb1sP2mDZj5suUJWIZ-WNpKg-fjBfNic',
              appId: '1:396232712466:android:dc6facfeb7e7d2e9cd53cb',
              messagingSenderId: '396232712466',
              projectId: 'plusones-28b9f')
      );
    }else{
      await Firebase.initializeApp(

        options: const FirebaseOptions(apiKey: 'AIzaSyASa_0oM2J4ORmJZB5wln3qPv9OmOj6qWA',
         appId: '1:396232712466:ios:94b6b60828824257cd53cb',
          messagingSenderId: '396232712466',
           projectId: 'plusones-28b9f')
      );
    }
  }catch(e){
    print('firebase error == ${e.toString()}');
  }
  InternetService();
  await GetStorage.init();
  runApp(const MyApp());
  await FirebaseApi().initializeNotification();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    initDeepLink();
  }

  late AppLinks _appLinks;

  Future<void> initDeepLink() async {
    try{
      _appLinks = AppLinks();

      _appLinks.uriLinkStream.listen((Uri? uri) {
        if (uri != null) {
          print('act id == ${uri.queryParameters['activityid']}');
          print('host id == ${uri.queryParameters['hostId']}');
          if(LocalStorage.getUid() == null || LocalStorage.getUid()!.isEmpty){
            Get.toNamed(Routes.initialPage,);
          } else if(uri.queryParameters['hostId'].toString() == LocalStorage.getUid()){
            Get.toNamed(Routes.hostUpcommingActiview, arguments: uri.queryParameters['activityid'].toString());
          }else{
            Get.put(ExploreListController());
            Get.toNamed(Routes.exploreView,
                arguments: uri.queryParameters['activityid'].toString()
            );
          }
        }
      });
    }catch(e){
      print('deep link error == ${e.toString()}');
    }
  }

  // void openAppLink(Uri uri) {
  //   _navigatorKey.currentState?.pushNamed(uri.fragment);
  // }

  @override
  Widget build(BuildContext context) {
    String? token = LocalStorage.getToken();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));

    return GetMaterialApp(
      title: 'PlusOne',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Nunito",
        scaffoldBackgroundColor: clrWhite,
        colorScheme: ColorScheme.fromSeed(seedColor: clrWhite),
        useMaterial3: true,
      ),
      initialRoute: token != null && token.isNotEmpty
          ? Routes.navbarUi
          : Routes.initialPage,
      initialBinding: IntroBinding(),
      getPages: Routes.listRoutes,
      // home:const IntroOneUi(),
    );
  }
}
