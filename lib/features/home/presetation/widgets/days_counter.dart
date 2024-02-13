import 'package:blissful_marry/core/style/colors.dart';
import 'package:blissful_marry/features/home/data/controllers/home_controller.dart';
import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DaysCounter extends GetView<AuthController> {
  const DaysCounter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    DateTime weddingDate = DateTime.now();
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 120,
      decoration: BoxDecoration(
        color: light,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
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

                  int daysRemaining = daysBetween(DateTime.now(), weddingDate);
                  return snapshot.data!.docs.isNotEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: InkWell(
                                    onTap: () => showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2030))
                                        .then(
                                      (value) => {
                                        if (value != null)
                                          {
                                            homeController.updateWeddingDate(
                                              value,
                                              controller,
                                              snapshot,
                                            ),
                                          }
                                      },
                                    ),
                                    child: Container(
                                      width: 45,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        color: Colors.transparent,
                                      ),
                                      child: GestureDetector(
                                        onTap: () => showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(2030))
                                            .then((value) => {
                                                  if (value != null)
                                                    {
                                                      homeController
                                                          .updateWeddingDate(
                                                        value,
                                                        controller,
                                                        snapshot,
                                                      ),
                                                    }
                                                }),
                                        child: const Center(
                                          child: Icon(
                                            Icons.edit,
                                            size: 22,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                daysRemaining == 0
                                    ? Text(
                                        'Începeți o nouă călătorie: Acum sunteți soț și soție!',
                                        style: GoogleFonts.robotoSerif(
                                          fontSize: 18,
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
                                                    style:
                                                        GoogleFonts.robotoSerif(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            '${0 - daysRemaining} zi',
                                                        style: GoogleFonts
                                                            .robotoSerif(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            ', v-ați unit destinele și ați început să scrieți povestea voastră de dragoste.',
                                                        style: GoogleFonts
                                                            .robotoSerif(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ]),
                                              )
                                            : RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                    text: 'Acum ',
                                                    style:
                                                        GoogleFonts.robotoSerif(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      color: Colors.black,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            '${0 - daysRemaining} zile ',
                                                        style: GoogleFonts
                                                            .robotoSerif(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            ', v-ați unit destinele și ați început să scrieți povestea voastră de dragoste.',
                                                        style: GoogleFonts
                                                            .robotoSerif(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w200,
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
                                                    style:
                                                        GoogleFonts.robotoSerif(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      color: Colors.black,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            '$daysRemaining zi ',
                                                        style: GoogleFonts
                                                            .robotoSerif(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            'până la marea zi!',
                                                        style: GoogleFonts
                                                            .robotoSerif(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w200,
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
                                                    style:
                                                        GoogleFonts.robotoSerif(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      color: Colors.black,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            '$daysRemaining  zile',
                                                        style: GoogleFonts
                                                            .robotoSerif(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            ' până la marea zi! ',
                                                        style: GoogleFonts
                                                            .robotoSerif(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w200,
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
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: InkWell(
                                    onTap: () => showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2030))
                                        .then((value) => {
                                              if (value != null)
                                                {
                                                  homeController.addWeddingDate(
                                                    value,
                                                    controller,
                                                    snapshot,
                                                  )
                                                }
                                            }),
                                    child: Text(
                                      'Adauga',
                                      style: GoogleFonts.robotoSerif(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
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
          ),
        ],
      ),
    );
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
