import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ieee_iot/home/home.dart';
import 'package:ieee_iot/rooms&halls/views/halls.dart';
import 'package:ieee_iot/rooms&halls/views/rooms.dart';

import 'on_boarding/splashscreen.dart';

void main() {
  runApp(
     const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
