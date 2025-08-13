import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'full_connection.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final PageController pcontroller = PageController();
  int currentPage = 0;

  void pageChanged(int x) {
    setState(() {
      currentPage = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 89, 162),
        body: Stack(alignment: Alignment.bottomCenter, children: [
          PageView(
              controller: pcontroller,
              onPageChanged: pageChanged,
              children: [
                Onboard1(
                  image: Image.asset("assets/o1.png"),
                  title: const Text("Manage Home",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  desc: const Text(
                      "Easily monitor and control every room in your villa - from lighting to air systems - all in one place.",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  onNext: () {
                    pcontroller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  },
                ),
                Onboard1(
                    image: Image.asset("assets/o2.png"),
                    title: const Text("Control Devices",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    desc: const Text(
                        "Turn on the lights, adjust fan speed, or switch TV channels with just a tap - smart living at your fingertips.",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    onNext: () {
                      pcontroller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    }),
                Onboard1(
                    image: Image.asset("assets/o3.jpg"),
                    title: const Text("Get Notified",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    desc: const Text(
                        "Receive real-time updates about your home's status and stay in control, wherever you are.",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    isLastPage: true,
                    onGetStarted: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('seen_onboarding', true);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const BluetoothConnectionScreen()));
                    })
              ]),
          SizedBox(height: 60),
          if (currentPage != 2)
            Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: Container(
                        width: 40,
                        height: 40,
                        key: ValueKey(currentPage),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Center(
                            child: Text('${currentPage + 1}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.blue))))))
        ]));
  }
}

class Onboard1 extends StatelessWidget {
  final Image image;
  final Text title;
  final Text desc;
  final VoidCallback? onNext;
  final VoidCallback? onGetStarted;
  final bool isLastPage;

  const Onboard1(
      {super.key,
      required this.image,
      required this.title,
      required this.desc,
      this.onNext,
      this.onGetStarted,
      this.isLastPage = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 520, child: image),
            Expanded(
              child: Container(
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 40),
                          Center(child: title),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20,),
                            child: desc,
                          ),
                        ],
                      ),
                      if (isLastPage)
                        ElevatedButton(
                            onPressed: onGetStarted,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF01497C),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            child: const Text('Get Started',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                    ],
                  )),
            ),
          ],
        ),
        if (!isLastPage)
          Positioned(
            top: 500,
            left: 25,
            child: ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                ),
                child: const Text("NEXT",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold))),
          ),
      ],
    );
  }
}
