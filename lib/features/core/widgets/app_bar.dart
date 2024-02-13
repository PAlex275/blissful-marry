import 'package:blissful_marry/core/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({
    super.key,
    this.backButton = false,
  });
  final bool backButton;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: dustyRose,
      toolbarHeight: 70,
      title: Text(
        'Blissful Marry',
        style: GoogleFonts.robotoSerif(
          fontSize: 23,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: const SizedBox(
              height: 60,
              child: Image(image: AssetImage("assets/images/logo.png")),
            ),
          ),
        ),
      ],
      // leading: backButton
      //     ? IconButton(
      //         icon: const Icon(Icons.arrow_back, color: Colors.black),
      //         onPressed: () => Get.back(),
      //       )
      //     : const SizedBox.shrink(),
      // leadingWidth: backButton ? 50 : 0,
      elevation: 0,
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
