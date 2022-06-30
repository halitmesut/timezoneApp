import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_timezone_app/constants.dart';
import 'package:flutter_timezone_app/screens/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 3),
        (() => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: kTextColor,
          ),
          child: Image.asset(
            'assets/images/DOP logo.png',
            height: 133,
            width: 200,
          )),
    );
  }
}
