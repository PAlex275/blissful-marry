import 'package:blissful_marry/core/style/colors.dart';
import 'package:blissful_marry/features/home/presetation/widgets/days_counter.dart';
import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWidget extends GetView<AuthController> {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime weddingDate = DateTime.now();
    return Container(
      height: 170,
      width: 170,
      decoration: BoxDecoration(
        color: light,
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(controller.getUser()!.email)
            .collection("Nunta")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (snapshot.hasData) {
            snapshot.data!.docs.isNotEmpty
                ? weddingDate = DateTime.parse(snapshot
                    .data!.docs.first["data_nuntii"]
                    .toDate()
                    .toString())
                : null;

            int daysRemaining =
                DaysCounter.daysBetween(DateTime.now(), weddingDate);
            return snapshot.data!.docs.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          daysRemaining == 0
                              ? Text(
                                  'Începeți o nouă călătorie: Acum sunteți soț și soție!',
                                  style: GoogleFonts.robotoSerif(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : daysRemaining < 0
                                  ? daysRemaining == -1
                                      ? RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                              text: 'Acum ',
                                              style: GoogleFonts.robotoSerif(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${0 - daysRemaining} zi',
                                                  style:
                                                      GoogleFonts.robotoSerif(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      ', v-ați unit destinele și ați început să scrieți povestea voastră de dragoste.',
                                                  style:
                                                      GoogleFonts.robotoSerif(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ]),
                                        )
                                      : RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                              text: 'Acum ',
                                              style: GoogleFonts.robotoSerif(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200,
                                                color: Colors.black,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${0 - daysRemaining} zile ',
                                                  style:
                                                      GoogleFonts.robotoSerif(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      ', v-ați unit destinele și ați început să scrieți povestea voastră de dragoste.',
                                                  style:
                                                      GoogleFonts.robotoSerif(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w200,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ]),
                                        )
                                  : daysRemaining == 1
                                      ? RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                              text:
                                                  'Ne apropiem pas cu pas:\n Doar ',
                                              style: GoogleFonts.robotoSerif(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200,
                                                color: Colors.black,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: '$daysRemaining zi ',
                                                  style:
                                                      GoogleFonts.robotoSerif(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'până la marea zi!',
                                                  style:
                                                      GoogleFonts.robotoSerif(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w200,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ]),
                                        )
                                      : RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                              text:
                                                  'Ne apropiem pas cu pas:\n Doar ',
                                              style: GoogleFonts.robotoSerif(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200,
                                                color: Colors.black,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: '$daysRemaining  zile',
                                                  style:
                                                      GoogleFonts.robotoSerif(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' până la marea zi! ',
                                                  style:
                                                      GoogleFonts.robotoSerif(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w200,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ]),
                                        ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Adaugati data nuntii',
                          style: GoogleFonts.robotoSerif(
                            fontSize: 23,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
          }

          return Container(
            color: dustyRose,
            child: Text(
              'Adaugati data nuntii',
              style: GoogleFonts.robotoSerif(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
