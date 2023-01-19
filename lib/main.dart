import 'dart:io';

import 'package:aaviss_motors/screens/personnel_info.dart';
import 'package:flutter/material.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aaviss Motors',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Aaviss Motors'),
      // home: Test(),
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          headline5: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(140, 187, 232, 1)),
          headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          subtitle2: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(0, 0, 0, 0.5)),
          bodyText1: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(0, 0, 0, 0.75)),
          bodyText2: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(0, 0, 0, 1)),
          caption: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
          button: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: Color(0xff1976D2)),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(140, 187, 232, 1),
          secondary: const Color(0xff1976D2),
        ),
        unselectedWidgetColor: const Color(0xff1976D2),
      ),
    );
  }
}
