import 'package:appy_app/pages/chat_page.dart';
import 'package:appy_app/pages/home_page.dart';
import 'package:appy_app/pages/start_page.dart';
import 'package:appy_app/widgets/theme.dart';
import 'package:flutter/material.dart';

void main() {
  // runApp(const AppyApp());
  runApp(const MaterialApp(
    home: HomePage(),
  ));
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
      home: const StartPage(),
    );
  }
}
