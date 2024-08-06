import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/onbording/introone/binding/intro_binding.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyAeb1sP2mDZj5suUJWIZ-WNpKg-fjBfNic',
            appId: '1:396232712466:android:ab306fc1cb994f1ccd53cb',
            messagingSenderId: '396232712466',
            projectId: 'plusones-28b9f')
    );
  }catch(e){
    print('firebase error == ${e.toString()}');
  }
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
