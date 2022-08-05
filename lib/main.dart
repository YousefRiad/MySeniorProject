import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wqm/const.dart';
import 'package:wqm/pages/homepage.dart';
import 'package:device_preview/device_preview.dart';
import 'dart:ui';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
    [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // const MyApp(DevicePreview devicePreview, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Water Quality Monitoring',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(backgroundColor: kBackgroundColor),
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: Colors.white,
        accentColor: kAccentColorGreen,
        iconTheme: IconThemeData(color: Colors.white),
        fontFamily: GoogleFonts.montserrat().fontFamily,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: homePage(),
    );
  }
}

// AnimatedSplashScreen(
//         splash: new Image.network(
//             'https://www.geeksforgeeks.org/wp-content/uploads/gfg_200X200.png'),
//         nextScreen: homePage(),
//         splashTransition: SplashTransition.slideTransition,
//       ),


// class Splash extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SplashScreen(
//       seconds: 6,
//       navigateAfterSeconds: homePage(),
//       title: new Text(
//         'GeeksForGeeks',
//         textScaleFactor: 2,
//       ),
//       image: new Image.network(
//           'https://www.geeksforgeeks.org/wp-content/uploads/gfg_200X200.png'),
//       loadingText: Text("Loading"),
//       photoSize: 100.0,
//       loaderColor: Colors.blue,
//     );
//   }
// }
