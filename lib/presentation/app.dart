import 'package:flutter/material.dart';
import 'package:galleria_ai_hackathon_2025/presentation/pages/home/home_page.dart';
import 'package:galleria_ai_hackathon_2025/presentation/theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: appTheme, home: HomePage());
  }
}
