import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qapp/screens/splash_screen.dart';

import 'providers/all_providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return MultiProvider(
            providers: allProvider,
            child: const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            ));
      },
    );
  }
}
