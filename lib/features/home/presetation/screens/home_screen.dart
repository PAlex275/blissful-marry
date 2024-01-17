import 'package:blissful_marry/core/style/colors.dart';
import 'package:blissful_marry/features/core/widgets/app_bar.dart';
import 'package:blissful_marry/features/home/presetation/widgets/days_counter.dart';
import 'package:blissful_marry/features/home/presetation/widgets/navigation_sidebar.dart';
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: ivory,
        ),
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: DaysCounter(),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     vertical: 10,
              //     horizontal: 30,
              //   ),
              //   child: Container(
              //     height: 140,
              //     width: MediaQuery.of(context).size.width,
              //     decoration: const BoxDecoration(
              //       color: nude,
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(
              //           50,
              //         ),
              //         bottomRight: Radius.circular(
              //           50,
              //         ),
              //       ),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(12.0),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(
              //               left: 10,
              //             ),
              //             child: Text(
              //               'Total Cheltuieli',
              //               style: GoogleFonts.dancingScript(
              //                 color: Colors.black,
              //                 fontSize: 27,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     vertical: 10,
              //     horizontal: 30,
              //   ),
              //   child: Container(
              //     height: 140,
              //     width: MediaQuery.of(context).size.width,
              //     decoration: const BoxDecoration(
              //       color: nude,
              //       borderRadius: BorderRadius.only(
              //         topRight: Radius.circular(
              //           50,
              //         ),
              //         bottomLeft: Radius.circular(
              //           50,
              //         ),
              //       ),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(12.0),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(
              //               left: 10,
              //             ),
              //             child: Text(
              //               'Total Cheltuieli',
              //               style: GoogleFonts.dancingScript(
              //                 color: Colors.black,
              //                 fontSize: 27,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     vertical: 20,
              //   ),
              //   child: Image.asset(
              //     'assets/images/wave.png',
              //     width: MediaQuery.of(context).size.width * 0.85,
              //     height: 150,
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
