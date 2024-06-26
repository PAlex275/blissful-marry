import 'package:blissful_marry/core/style/colors.dart';
import 'package:blissful_marry/features/core/widgets/app_bar.dart';
import 'package:blissful_marry/features/home/presetation/widgets/adaugare_invitat.dart';
import 'package:blissful_marry/features/home/presetation/widgets/days_counter.dart';
import 'package:blissful_marry/features/home/presetation/widgets/navigation_sidebar.dart';
import 'package:blissful_marry/features/home/presetation/widgets/tabel_cheltuieli.dart';
import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends GetView<AuthController> {
  const HomeScreen({super.key});
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationSideBar(),
      backgroundColor: ivory,
      appBar: const CustomAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: ivory,
          ),
          child: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: DaysCounter(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: TabelCheltuieli(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 30,
                  ),
                  child: AdaugareInvitat(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
