import 'package:appy_app/pages/add_appy_page.dart';
import 'package:appy_app/pages/add_module_appy_conn.dart';
import 'package:appy_app/pages/add_module_page.dart';
import 'package:appy_app/pages/chat_page.dart';
import 'package:appy_app/pages/home_page.dart';
import 'package:appy_app/pages/onboarding_page.dart';
import 'package:appy_app/pages/setting_page.dart';
import 'package:appy_app/pages/start_page.dart';
import 'package:appy_app/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:appy_app/pages/add_module_page.dart';

void main() {
  runApp(const AppyApp());
  // runApp(const MaterialApp(
  //   home: HomePage(),
  // ));
}

class AppyApp extends StatelessWidget {
  const AppyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: "SUITE",
          primaryColor: AppColors.primary,
          highlightColor: AppColors.accent,
          scaffoldBackgroundColor: AppColors.background,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: AppColors.textHigh),
          )),
      home: const HomePage(),
    );
  }
}
