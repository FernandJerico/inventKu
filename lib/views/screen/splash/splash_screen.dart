import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inventku/utils/const/app_colors.dart';
import 'package:inventku/views/screen/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const LoginScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                final tween = Tween(begin: 0.0, end: 1.0);
                return FadeTransition(
                  opacity: animation.drive(tween),
                  child: child,
                );
              },
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
            child: Image.asset(
          'assets/images/InventKu.png',
          scale: 3,
        )),
      )),
    );
  }
}
