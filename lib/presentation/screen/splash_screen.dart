import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optimal_cutting/presentation/screen/cutting/cutting_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      context.go(CuttingScreen.routeName);
    });

    return const Scaffold(
      body: Center(
        child: Text('Optimal Cutting'),
      ),
    );
  }
}
