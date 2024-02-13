import 'package:blissful_marry/core/style/colors.dart';
import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});
  static const String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: softIvory,
        body: Column(
          children: [
            const SizedBox(
              height: 450,
              width: 450,
              child: Image(image: AssetImage("assets/images/logo.png")),
            ),
            const SizedBox(
              height: 40,
            ),
            googleButton(context),
            const SizedBox(
              height: 20,
            ),
            facebookButton(context),
            const SizedBox(
              height: 20,
            ),
            appleButton(context),
          ],
        ));
  }

  InkWell googleButton(BuildContext context) {
    return InkWell(
      onTap: () => controller.signInWithGoogle(),
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              child: Image(
                image: AssetImage("assets/images/google.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 20,
              ),
              child: Text(
                'Login with Google',
                style: GoogleFonts.robotoSerif(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell facebookButton(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(66, 103, 178, 1),
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            // BoxShadow(
            //   color: Colors.grey.withOpacity(0.5),
            //   spreadRadius: 1,
            //   blurRadius: 1,
            //   offset: const Offset(0, 1), // changes position of shadow
            // ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SvgPicture.asset(
                  'assets/images/facebook.svg',
                  height: 50,
                  width: 50,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Text(
                'Login with Facebook',
                style: GoogleFonts.robotoSerif(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell appleButton(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(85, 85, 85, 1),
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            // BoxShadow(
            //   color: Colors.grey.withOpacity(0.4),
            //   spreadRadius: 1,
            //   blurRadius: 1,
            //   offset: const Offset(0, 1), // changes position of shadow
            // ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              child: Image(
                image: AssetImage("assets/images/apple.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Text(
                'Login with Apple',
                style: GoogleFonts.robotoSerif(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
