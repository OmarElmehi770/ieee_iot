import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'full_connection.dart';
import 'OnboardingScreens.dart.dart';
import 'package:permission_handler/permission_handler.dart' hide PermissionStatus;
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Location _location = Location();
  Timer? _locationCheckTimer;

  @override
  void initState() {
    super.initState();
    tonext();
  }

  Future<void> tonext() async {
    // طلب أذونات البلوتوث والموقع
    // await [
    //   Permission.bluetooth,
    //   Permission.bluetoothScan,
    //   Permission.bluetoothConnect,
    //   Permission.bluetoothAdvertise,
    //   Permission.locationWhenInUse,
    // ].request();
    await Permission.bluetooth.request();
    await Permission.locationWhenInUse.request();
    // تحقق أولي من الموقع
    if (!await _ensureLocationService()) {
      _exitApp();
      return;
    }

    // بدء التشييك المستمر كل ثانية
    _locationCheckTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (!await _location.serviceEnabled()) {
        _exitApp();
      }
    });

    // الانتقال بعد 2 ثانية حسب حالة الـ Onboarding
    final prefs = await SharedPreferences.getInstance();
    final seenOnboarding = prefs.getBool('seen_onboarding') ?? false;

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    _locationCheckTimer?.cancel(); // وقف التشييك قبل الانتقال

    if (seenOnboarding) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BluetoothConnectionScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreens()),
      );
    }
  }

  Future<bool> _ensureLocationService() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService(); // يطلع البوب-اب الرسمي
      if (!serviceEnabled) return false;
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return false;
    }

    return true;
  }

  void _exitApp() {
    _locationCheckTimer?.cancel();
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }

  @override
  void dispose() {
    _locationCheckTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/Splash.png",
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}
