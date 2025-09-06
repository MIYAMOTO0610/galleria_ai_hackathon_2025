import 'package:flutter/material.dart';
import 'package:galleria_ai_hackathon_2025/gen/assets.gen.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.images.bg.image().image,
          fit: BoxFit.fitHeight,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(child: child),
        ),
      ),
    );
  }
}
