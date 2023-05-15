import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:money_calc/view/home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network(
            'https://assets8.lottiefiles.com/packages/lf20_06a6pf9i.json'),
      ),
    );
  }

  void goToHome(context) async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    ));
  }
}
