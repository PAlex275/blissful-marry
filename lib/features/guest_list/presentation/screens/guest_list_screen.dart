import 'package:blissful_marry/core/alerts/subscription_alert.dart';
import 'package:blissful_marry/core/controllers/subscription_controller.dart';
import 'package:blissful_marry/core/style/colors.dart';
import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:toggle_switch/toggle_switch.dart';

class GuestListScreen extends StatefulWidget {
  const GuestListScreen({super.key});
  static const String routeName = "/guestlist";

  @override
  State<GuestListScreen> createState() => _GuestListScreenState();
}

class _GuestListScreenState extends State<GuestListScreen> {
  // ignore: no_leading_underscores_for_local_identifiers
  final TextEditingController _nameController = TextEditingController();
  // ignore: no_leading_underscores_for_local_identifiers
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _darController = TextEditingController();
  final SearchController searchController = SearchController();
  // ignore: no_leading_underscores_for_local_identifiers
  String _attendAnswerController = "Confirmat";
  String _currencyController = 'Lei';
  final List<String> attendLabels = ["Confirmat", "Neconfirmat"];
  final List<String> monede = ['Lei', 'Euro', 'Dolari', 'Lire'];
  final controller = Get.put(AuthController());
  final subscriptionController = Get.put(SubscriptionController());
  final formKey = GlobalKey<FormState>();
  List allResults = [];
  List resultList = [];
  late int selectedIndex;

  getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(controller.getUser()!.email)
        .collection("Nunta")
        .doc("Invitati")
        .collection("Invitati")
        .get();
    allResults = data.docs;
    searchResultList();
  }

  @override
  void initState() {
    selectedIndex = -1;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
    searchController.addListener(onSearchChanged);
  }

  onSearchChanged() {
    searchResultList();
  }

  searchResultList() {
    var showResults = [];
    if (searchController.text != '') {
      for (var clientSnapShot in allResults) {
        var name = clientSnapShot['Nume'].toString().toLowerCase();
        if (name.contains(searchController.text.toLowerCase())) {
          showResults.add(clientSnapShot);
        }
      }
    } else {
      showResults = List.from(allResults);
    }

    setState(() {
      resultList = showResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gestionarea Invitatilor',
          style: GoogleFonts.robotoSerif(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: dustyRose,
      ),
      backgroundColor: ivory,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 13,
              ),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 42,
                    child: CupertinoSearchTextField(
                      placeholder: 'Cautati...',
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 25,
                        color: Colors.black,
                      ),
                      suffixIcon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(
                              0.4,
                            ),
                            width: 0.5,
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      controller: searchController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 5,
                    ),
                    child: InkWell(
                      onTap: () {
                        allResults.length <
                                subscriptionController.getMaximInvitati()
                            ? showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    scrollable: true,
                                    title: const Text(
                                      'Invitat',
                                    ),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Form(
                                        key: formKey,
                                        child: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              controller: _nameController,
                                              validator: (text) {
                                                if (text == null ||
                                                    text.isEmpty) {
                                                  return 'Introduceti numele';
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                labelText: 'Nume',
                                                icon: Icon(
                                                  Icons.account_box,
                                                ),
                                              ),
                                            ),
                                            TextFormField(
                                              cursorColor: Colors.black,
                                              controller:
                                                  _phoneNumberController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                labelText: 'Numar de telefon',
                                                icon: Icon(Icons
                                                    .phone_iphone_outlined),
                                              ),
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                  12,
                                                )
                                              ],
                                              validator: (phoneNumber) {
                                                if (phoneNumber == '') {
                                                  return 'Introduceti numarul de telefon';
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              children: [
                                                const Text(
                                                    'A confirmat prezenta?'),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                ToggleSwitch(
                                                  inactiveBgColor: Colors.white,
                                                  inactiveFgColor: Colors.black,
                                                  activeBgColor: const [
                                                    dustyRose
                                                  ],
                                                  initialLabelIndex: 0,
                                                  totalSwitches: 2,
                                                  minWidth: 100,
                                                  fontSize: 12,
                                                  labels: attendLabels,
                                                  onToggle: (index) {
                                                    _attendAnswerController =
                                                        attendLabels[index!];
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          "Anuleaza",
                                          style: GoogleFonts.robotoSerif(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        onPressed: () {
                                          _nameController.clear();
                                          _phoneNumberController.clear();
                                          Get.close(1);
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          "Adauga",
                                          style: GoogleFonts.robotoSerif(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            FirebaseFirestore.instance
                                                .collection('Users')
                                                .doc(
                                                    controller.getUser()!.email)
                                                .collection("Nunta")
                                                .doc("Invitati")
                                                .collection("Invitati")
                                                .add({
                                                  "Nume": _nameController.text,
                                                  "Telefon":
                                                      _phoneNumberController
                                                          .text,
                                                  "Confirmare":
                                                      _attendAnswerController,
                                                  "Dar": 0,
                                                  "Moneda": "Lei",
                                                })
                                                .then((value) => {
                                                      _nameController.clear(),
                                                      _phoneNumberController
                                                          .clear(),
                                                      getClientStream(),
                                                      setState(() {}),
                                                      Get.close(1),
                                                    })
                                                .catchError((error) => {
                                                      // ignore: avoid_print
                                                      print(
                                                          "Failed to add new Note due to $error")
                                                    });
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                },
                              )
                            : showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const SubscriptionAlert(
                                    categorie: 'invitati',
                                  );
                                });
                      },
                      child: Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                          color: light,
                          borderRadius: BorderRadius.circular(5),
                          // border: Border.all(
                          //   color: Colors.black,
                          //   width: 0.4,
                          // ),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: resultList.isNotEmpty ? resultList.length : 1,
                itemBuilder: (context, index) {
                  return resultList.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Adaugati Invitati',
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex == index
                                    ? selectedIndex = -1
                                    : selectedIndex = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: light,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: selectedIndex == index ? 115 : 75,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            resultList[index]['Confirmare']
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'confirmat'
                                                ? const Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green,
                                                    size: 23,
                                                  )
                                                : const Icon(
                                                    Icons.question_mark,
                                                    color: Colors.black,
                                                    size: 23,
                                                  ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '${resultList[index]['Nume']}',
                                              style: GoogleFonts.robotoSerif(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('Users')
                                                    .doc(controller
                                                        .getUser()!
                                                        .email)
                                                    .collection("Nunta")
                                                    .doc("Invitati")
                                                    .collection("Invitati")
                                                    .doc(resultList[index].id)
                                                    .delete();
                                                getClientStream();
                                                setState(() {});
                                              },
                                              child: const Icon(
                                                Icons.delete_outline,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    selectedIndex == index
                                        ? Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 35, top: 5),
                                                    child: Text(
                                                      resultList[index]
                                                          ['Telefon'],
                                                      style: GoogleFonts
                                                          .robotoSerif(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5, top: 5),
                                                    child: Text(
                                                      '${resultList[index]['Dar']} ${resultList[index]['Moneda']}',
                                                      style: GoogleFonts
                                                          .robotoSerif(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15, left: 35),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Detalii',
                                                      style: GoogleFonts
                                                          .robotoSerif(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontSize: 13),
                                                    ),
                                                    const Icon(
                                                      Icons.arrow_drop_up,
                                                      color: Colors.black,
                                                      size: 20,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                left: 35, top: 7),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Detalii',
                                                      style: GoogleFonts
                                                          .robotoSerif(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontSize: 13),
                                                    ),
                                                    const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.black,
                                                      size: 20,
                                                    )
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return SizedBox(
                                                            child: AlertDialog(
                                                              backgroundColor:
                                                                  light,
                                                              shape:
                                                                  const RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                              ),
                                                              title: Text(
                                                                'Dar de nunta',
                                                                style: GoogleFonts
                                                                    .robotoSerif(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              content: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Form(
                                                                    key:
                                                                        formKey,
                                                                    child:
                                                                        TextFormField(
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      controller:
                                                                          _darController,
                                                                      validator:
                                                                          (text) {
                                                                        if (text ==
                                                                                null ||
                                                                            text.isEmpty) {
                                                                          return 'Introduceti suma';
                                                                        }
                                                                        return null;
                                                                      },
                                                                      cursorColor:
                                                                          Colors
                                                                              .black,
                                                                      style: GoogleFonts
                                                                          .robotoSerif(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'Suma',
                                                                        labelStyle:
                                                                            GoogleFonts.robotoSerif(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .monetization_on_sharp,
                                                                          color:
                                                                              Color(0xFF272c33),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            20),
                                                                    child:
                                                                        ToggleSwitch(
                                                                      inactiveBgColor:
                                                                          Colors
                                                                              .white,
                                                                      inactiveFgColor:
                                                                          Colors
                                                                              .black,
                                                                      activeBgColor: const [
                                                                        dustyRose
                                                                      ],
                                                                      initialLabelIndex:
                                                                          0,
                                                                      totalSwitches:
                                                                          4,
                                                                      minWidth:
                                                                          55,
                                                                      fontSize:
                                                                          10,
                                                                      labels:
                                                                          monede,
                                                                      customTextStyles: [
                                                                        GoogleFonts
                                                                            .robotoSerif(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ],
                                                                      onToggle:
                                                                          (index) {
                                                                        _currencyController =
                                                                            monede[index!];
                                                                      },
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      if (formKey
                                                                          .currentState!
                                                                          .validate()) {
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                'Users')
                                                                            .doc(controller
                                                                                .getUser()!
                                                                                .email)
                                                                            .collection(
                                                                                "Nunta")
                                                                            .doc(
                                                                                "Invitati")
                                                                            .collection(
                                                                                "Invitati")
                                                                            .doc(
                                                                              resultList[index].id,
                                                                            )
                                                                            .update(
                                                                              {
                                                                                "Dar": _darController.text,
                                                                                "Moneda": _currencyController
                                                                              },
                                                                            )
                                                                            .then((value) =>
                                                                                {
                                                                                  _darController.clear(),
                                                                                  getClientStream(),
                                                                                  setState(() {}),
                                                                                  Get.close(1),
                                                                                })
                                                                            .catchError((error) =>
                                                                                {
                                                                                  // ignore: avoid_print
                                                                                  print("Failed to add new Note due to $error")
                                                                                });
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                      'Adauga',
                                                                      style: GoogleFonts
                                                                          .robotoSerif(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Get.close(
                                                                          1);
                                                                    },
                                                                    child: Text(
                                                                      'Anuleaza',
                                                                      style: GoogleFonts
                                                                          .robotoSerif(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w200,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Icon(
                                                    Icons
                                                        .monetization_on_rounded,
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                    size: 28,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
