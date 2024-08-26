import 'package:live_score_app/screen/splash_screen.dart';
import 'package:flutter/material.dart';
class LiveScoreApp extends StatelessWidget {
  const LiveScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}