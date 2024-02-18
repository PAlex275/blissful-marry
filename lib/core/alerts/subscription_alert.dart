import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionAlert extends StatelessWidget {
  const SubscriptionAlert({
    super.key,
    required this.categorie,
  });
  final String categorie;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        ' Numărul maxim de $categorie a fost atins!',
        textAlign: TextAlign.center,
        style: GoogleFonts.robotoSerif(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 19,
        ),
      ),
      content: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Vă informăm că numărul maxim de $categorie pentru subscriptia dvs. a fost atins."
              " Din acest moment, nu mai puteți adăuga $categorie în cadrul "
              "acestei subscriptii până când nu eliberați"
              " locuri prin eliminarea unor "
              "$categorie sau actualizarea planului de subscriptie.",
              style: GoogleFonts.robotoSerif(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            TextButton(
                onPressed: () {
                  Get.close(1);
                },
                child: Text(
                  'Ok',
                  style: GoogleFonts.robotoSerif(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 19,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
