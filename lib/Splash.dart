import 'package:flutter/material.dart';
import 'dart:async';

import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0; 
  final Duration fadeDuration = const Duration(seconds: 2); 

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1; 
      });
    });

    Timer(const Duration(seconds: 3), () {
      GoRouter.of(context).go('/signin'); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity, 
          duration: fadeDuration,
          child: Image.asset(
            'assets/images/burgan.jpg',  
            width: 500, 
            height: 500,
          ),
        ),
      ),
    );
  }
}
