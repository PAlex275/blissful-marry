import 'package:blissful_marry/core/style/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String routeName = "/splashscreen";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: softIvory,
      body: Center(
        child: SizedBox(
          height: 500,
          width: 500,
          child: Image(image: AssetImage("assets/images/logo.png")),
        ),
      ),
    );
  }
}
