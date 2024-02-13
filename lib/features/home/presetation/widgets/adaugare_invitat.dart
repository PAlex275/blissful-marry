import 'package:blissful_marry/core/style/colors.dart';
import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AdaugareInvitat extends StatelessWidget {
  const AdaugareInvitat({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    // ignore: no_leading_underscores_for_local_identifiers
    final TextEditingController _nameController = TextEditingController();
    final List<String> attendLabels = ["Confirmat", "Neconfirmat"];
    // ignore: no_leading_underscores_for_local_identifiers
    String _attendAnswerController = "Confirmat";
    // ignore: no_leading_underscores_for_local_identifiers
    final TextEditingController _phoneNumberController =
        TextEditingController();
    final controller = Get.put(AuthController());
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: light,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
            'Adauga invitat',
            style: GoogleFonts.robotoSerif(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: TextFormField(
                  controller: _nameController,
                  style: GoogleFonts.robotoSerif(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.black,
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Introduceti numele';
                    }
                    return null;
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    label: Text(
                      'Nume',
                      style: GoogleFonts.robotoSerif(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Form(
              key: formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.37,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: TextFormField(
                        controller: _phoneNumberController,
                        style: GoogleFonts.robotoSerif(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Introduceti numele';
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: InputBorder.none,
                          label: Text(
                            'Telefon',
                            style: GoogleFonts.robotoSerif(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.42,
                    decoration: BoxDecoration(
                      color: light,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.white, width: 0.1),
                    ),
                    child: ToggleSwitch(
                      borderWidth: 0.5,
                      borderColor: const [
                        Colors.white,
                      ],
                      minWidth: 80,
                      inactiveBgColor: light,
                      inactiveFgColor: Colors.black,
                      customTextStyles: [
                        GoogleFonts.robotoSerif(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                        GoogleFonts.robotoSerif(
                          color: Colors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                      activeBgColor: [Colors.white.withOpacity(0.5)],
                      initialLabelIndex: 0,
                      totalSwitches: 2,
                      dividerMargin: 0,
                      // minWidth: 70,
                      labels: attendLabels,
                      onToggle: (index) {
                        _attendAnswerController = attendLabels[index!];
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 80,
            ),
            child: Container(
              height: 35,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc(controller.getUser()!.email)
                        .collection("Nunta")
                        .doc("Invitati")
                        .collection("Invitati")
                        .add({
                          "Nume": _nameController.text,
                          "Telefon": _phoneNumberController.text,
                          "Confirmare": _attendAnswerController,
                          "Dar": 0,
                          "Moneda": "Lei",
                        })
                        .then((value) => {
                              _nameController.clear(),
                              _phoneNumberController.clear(),
                            })
                        .catchError((error) => {
                              // ignore: avoid_print
                              print("Failed to add new Note due to $error")
                            });
                  }
                },
                child: Center(
                    child: Text(
                  'Adauga',
                  style: GoogleFonts.robotoSerif(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
