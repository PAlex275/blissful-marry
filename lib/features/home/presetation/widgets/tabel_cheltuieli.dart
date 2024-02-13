import 'dart:math';

import 'package:blissful_marry/core/style/colors.dart';
import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TabelCheltuieli extends StatelessWidget {
  const TabelCheltuieli({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    TextEditingController _title = TextEditingController();
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _description = TextEditingController();
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _amount = TextEditingController();
    double expenseTotalAmount = 0;
    return Container(
      height: 445,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: light,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 35,
          ),
          Text(
            'Total cheltuieli',
            style: GoogleFonts.robotoSerif(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(controller.getUser()!.email)
                .collection("Nunta")
                .doc("Cheltuieli")
                .collection("Cheltuieli")
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
                expenseTotalAmount = 0;
                snapshot.data!.docs.toList().forEach((element) {
                  expenseTotalAmount += element["suma"];
                });
                if (expenseTotalAmount > 0) {
                  return Column(
                    children: [
                      Text(
                        '$expenseTotalAmount Lei',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoSerif(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: min(5, snapshot.data!.docs.length),
                        itemBuilder: (context, index) {
                          var expenses =
                              snapshot.data!.docs.toList().reversed.toList();
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 30,
                              right: 30,
                              bottom: 10,
                            ),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white.withOpacity(0.5),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          expenses[index]["titlu"],
                                          style: GoogleFonts.robotoSerif(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w200,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '${expenses[index]["suma"]} lei',
                                          style: GoogleFonts.robotoSerif(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w200,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: light,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(26.0))),
                                      contentPadding:
                                          const EdgeInsets.only(top: 10.0),
                                      content: SizedBox(
                                        width: 400.0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  "Adaugare cheltuiala",
                                                  style:
                                                      GoogleFonts.robotoSerif(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30.0, right: 30.0),
                                              child: TextField(
                                                style: GoogleFonts.robotoSerif(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                                controller: _title,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  hintText: "Titlu",
                                                  hintStyle:
                                                      GoogleFonts.robotoSerif(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.black
                                                            .withOpacity(0.8),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  labelStyle:
                                                      GoogleFonts.roboto(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                maxLines: 1,
                                                cursorColor: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30.0, right: 30.0),
                                              child: TextField(
                                                controller: _description,
                                                style: GoogleFonts.robotoSerif(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                                cursorColor: Colors.black,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  hintText: "Descriere",
                                                  hintStyle:
                                                      GoogleFonts.robotoSerif(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.black
                                                            .withOpacity(0.8),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  labelStyle:
                                                      GoogleFonts.roboto(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30.0, right: 30.0),
                                              child: TextField(
                                                style: GoogleFonts.robotoSerif(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                                cursorColor: Colors.black,
                                                controller: _amount,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  suffix: Text(
                                                    'Lei',
                                                    style:
                                                        GoogleFonts.robotoSerif(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  hintText: "Suma",
                                                  hintStyle:
                                                      GoogleFonts.robotoSerif(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.black
                                                            .withOpacity(0.8),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  labelStyle:
                                                      GoogleFonts.roboto(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                textInputAction:
                                                    TextInputAction.done,
                                                maxLines: 1,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15.0,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                expenseTotalAmount = 0;
                                                if (_amount.text != '' &&
                                                    _title.text != '') {
                                                  FirebaseFirestore.instance
                                                      .collection('Users')
                                                      .doc(controller
                                                          .getUser()!
                                                          .email)
                                                      .collection("Nunta")
                                                      .doc("Cheltuieli")
                                                      .collection("Cheltuieli")
                                                      .add({
                                                    "titlu": _title.text,
                                                    "descriere":
                                                        _description.text,
                                                    "suma": int.tryParse(
                                                        _amount.text),
                                                    "data": DateFormat.yMMMEd()
                                                        .format(DateTime.now()),
                                                  }).then((value) => {
                                                            _amount.clear(),
                                                            _title.clear(),
                                                            _description
                                                                .clear(),
                                                            Get.close(1)
                                                          });
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 50,
                                                  right: 50,
                                                  bottom: 3,
                                                ),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0,
                                                          bottom: 15.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Text(
                                                    "Adauga",
                                                    style:
                                                        GoogleFonts.robotoSerif(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 40.0,
                                                right: 40,
                                                bottom: 10,
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  Get.close(1);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0,
                                                          bottom: 15.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Text(
                                                    "Cancel",
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.robotoSerif(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Text(
                        '0 Lei',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoSerif(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }

              return Container(
                color: light,
                child: Text(
                  'Adaugati cheltuieli',
                  style: GoogleFonts.robotoSerif(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
