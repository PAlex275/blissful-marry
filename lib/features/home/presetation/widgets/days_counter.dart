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
      width: MediaQuery.of(context).size.width * 0.85,
      height: 150,
      decoration: BoxDecoration(
        color: nude,
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
                  .collection("Wedding")
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
                          .data!.docs.first["wedding_date"]
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
                                Text(
                                  daysRemaining == 0
                                      ? 'Începeți o nouă călătorie: Acum sunteți soț și soție! '
                                      : daysRemaining < 0
                                          ? daysRemaining == -1
                                              ? 'Acum ${0 - daysRemaining} zi, v-ați unit destinele și ați început să scrieți povestea voastră de dragoste.'
                                              : 'Acum ${0 - daysRemaining} zile, v-ați unit destinele și ați început să scrieți povestea voastră de dragoste.'
                                          : daysRemaining == 1
                                              ? 'Ne apropiem pas cu pas: Doar $daysRemaining zi până la marea zi! '
                                              : 'Ne apropiem pas cu pas: Doar $daysRemaining zile până la marea zi! ',
                                  style: GoogleFonts.dancingScript(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Add your Wedding Date',
                              style: GoogleFonts.nunito(
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: dustyRose),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
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
                                                )
                                              }
                                          }),
                                  child: Text(
                                    'Add Date',
                                    style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                }

                return Container(
                  color: dustyRose,
                  child: Text(
                    'Add Your Wedding Date',
                    style: GoogleFonts.nunito(
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

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
