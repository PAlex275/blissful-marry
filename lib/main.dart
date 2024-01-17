import 'package:blissful_marry/core/bindings/initial_bindings.dart';
import 'package:blissful_marry/core/routes/app_routes.dart';
import 'package:blissful_marry/core/style/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blissful Marry',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: dustyRose,
        colorScheme: ColorScheme.dark(
          primary: Colors.white.withOpacity(0.9),
          background: dustyRose,
        ),
        datePickerTheme: DatePickerThemeData(
          backgroundColor: dustyRose,
          dayOverlayColor: MaterialStateProperty.all(Colors.white),
          confirmButtonStyle: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(dustyRose),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          cancelButtonStyle: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(dustyRose),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          todayBackgroundColor: MaterialStateProperty.all(dustyRose),
          todayForegroundColor: MaterialStateProperty.all(nude),
        ),
      ),
      getPages: AppRoutes.routes(),
    );
  }
}
