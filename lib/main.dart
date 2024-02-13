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
        primaryColor: light,
        colorScheme: ColorScheme.dark(
          primary: Colors.black.withOpacity(0.1),
          background: light,
        ),
        datePickerTheme: DatePickerThemeData(
          backgroundColor: light,
          dayOverlayColor:
              MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
          confirmButtonStyle: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(light),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
          cancelButtonStyle: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(light),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
          todayBorder: BorderSide.none,
          todayBackgroundColor:
              MaterialStateProperty.all(light.withOpacity(0.4)),
          todayForegroundColor: MaterialStateProperty.all(Colors.black),
        ),
      ),
      getPages: AppRoutes.routes(),
    );
  }
}
