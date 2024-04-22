import 'package:android/auth/login_or_register.dart';
import 'package:android/theme/dark_mode.dart';
import 'package:android/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import flutter_screenutil

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Android',
        theme: lightMode,
        darkTheme: darkMode,
        home: const LoginOrRegister(),
      ),
    );
  }
}
