import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'OnboardingScreens.dart.dart';
import 'Connectionscreen.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    tonext();
  }

  Future<void> tonext() async {
    await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.locationWhenInUse,
    ].request();

    final prefs = await SharedPreferences.getInstance();
    final seenOnboarding = prefs.getBool('seen_onboarding') ?? false;

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

/* connection screen بتروح لل  */
    /**************************************************************************************************** */
    if (seenOnboarding) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Connectionscreen()));
    }
    /*************************************************************************************************** */

    else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const OnboardingScreens()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Image.asset(
      "assets/Splash.png",
      fit: BoxFit.cover,
      width: double.infinity,
      // height: double.infinity,
    ));
  }
}
