import 'package:flutter/material.dart';
import '../main.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkInitialRoute();
  }

  void _checkInitialRoute() async {
    // Simulating some initialization logic
    await Future.delayed(Duration(seconds: 2));

    // Check if user is logged in or needs onboarding
    final appState = Provider.of<AppState>(context, listen: false);

    if (appState.phoneNumber == null) {
      // If no phone number, redirect to onboarding
      Navigator.of(context).pushReplacementNamed('/onboarding');
    } else {
      // If phone number exists, go to home screen
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/coinboost_logo.png', // Replace with your logo
              width: 200,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
