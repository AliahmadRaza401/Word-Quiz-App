import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qapp/screens/home_screen.dart';

import '../utils/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      AppRoutes.pushAndRemoveUntil(
          context, PageTransitionType.fade, const HomeScreen());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 340.h,
          width: 320.w,
          decoration: BoxDecoration(
            color: Colors.black
          )
        ),
      ),
    );
  }
}
