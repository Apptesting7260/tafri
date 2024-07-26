import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/onbording/introone/binding/intro_binding.dart';
import 'package:plusone/utils/colors.dart';

void main() {

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: 'PlusOne',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Nunito",
       scaffoldBackgroundColor: clrWhite,
        colorScheme: ColorScheme.fromSeed(seedColor: clrWhite),
        useMaterial3: true,
      ),
      initialRoute: Routes.initialPage,
      initialBinding: IntroBinding(),
      getPages: Routes.listRoutes,
      // home:const IntroOneUi(),
    );
  }
}
