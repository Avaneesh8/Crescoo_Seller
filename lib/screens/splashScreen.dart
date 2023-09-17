import 'dart:async';

import 'package:flutter/material.dart';

import 'authentication/MinimalistLogin.dart';

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
        Duration(seconds: 1),
            () => Navigator.pushReplacement(
            context as BuildContext, MaterialPageRoute(builder: (context) => MinimalistLogin())));
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          color: Color.fromRGBO(26, 50, 81, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(width: 150, image: AssetImage('images/CrescooLogo.png')),
              Text(
                "Crescoo\nSellers",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
