import 'package:android/auth/auth.dart';
import 'package:android/firebase_options.dart';
import 'package:android/theme/dark_mode.dart';
import 'package:android/theme/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import flutter_screenutil

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        home: const AuthPage(),
      ),
    );
  }
}
