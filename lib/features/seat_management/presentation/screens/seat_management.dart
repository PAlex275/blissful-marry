import 'dart:async';

import 'package:blissful_marry/core/style/colors.dart';
import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';
import 'package:blissful_marry/features/seat_management/data/controllers/seat_management_controller.dart';
import 'package:blissful_marry/features/seat_management/presentation/widgets/table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SeatManagement extends StatefulWidget {
  const SeatManagement({super.key});
  static const String routeName = "/seatManagement";
  static List<int> items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  @override
  State<SeatManagement> createState() => _SeatManagementState();
}

class _SeatManagementState extends State<SeatManagement> {
  final TextEditingController nameController = TextEditingController();
  late int tableSize;

  final authController = Get.put(AuthController());
  final controller = Get.put(SeatManagementController());
  final SearchController searchController = SearchController();
  late int tableID;
  late Timer timer;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tableSize = 1;
    getClientStream();
    setIndex();
    searchController.addListener(onSearchChanged);
  }

  List allResults = [];
  List resultList = [];

  onSearchChanged() {
    searchResultList();
  }

  searchResultList() {
    var showResults = [];
    if (searchController.text != '') {
      for (var clientSnapShot in allResults) {
        var name = clientSnapShot['NumeMasa'].toString().toLowerCase();
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

  getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(authController.getUser()!.email)
        .collection("Nunta")
        .doc("Mese")
        .collection("Mese")
        .orderBy('IDMasa')
        .get();
    allResults = data.docs;
    searchResultList();
  }

  setIndex() async {
    tableID = await controller.getIndex(authController);

    setState(() {
      tableID;
    });
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ivory,
      appBar: AppBar(
        backgroundColor: dustyRose,
        title: Text(
          'Gestionarea Meselor',
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          padding: const EdgeInsets.only(top: 15),
          decoration: const BoxDecoration(
            color: ivory,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: SizedBox(
                  height: 50,
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
                        border:
                            Border.all(color: Colors.black.withOpacity(0.7)),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10)),
                    controller: searchController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 210,
                  child: ListView.builder(
                    itemCount: resultList.isNotEmpty ? resultList.length : 1,
                    itemBuilder: (context, index) {
                      return resultList.isEmpty
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal:
                                      MediaQuery.of(context).size.width / 4),
                              child: Text(
                                'Adaugati Mese',
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          : Container(
                              color: ivory,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 20,
                                  left: 15,
                                  right: 15,
                                ),
                                child: WeddingTable(
                                  voidCallback: getClientStream,
                                  doc: resultList[index],
                                ),
                              ),
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: light,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                scrollable: true,
                title: Text(
                  'Masa',
                  style: GoogleFonts.robotoSerif(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        Form(
                          key: formKey,
                          child: TextFormField(
                            style: GoogleFonts.robotoSerif(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            controller: nameController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Acest camp nu poate fi gol';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: 'Nume Masa',
                              labelStyle: GoogleFonts.robotoSerif(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                              icon: const Icon(
                                Icons.account_box,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Locuri',
                          style: GoogleFonts.robotoSerif(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: DropdownButtonFormField(
                            dropdownColor: light,
                            elevation: 2,
                            value: tableSize,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                            items: SeatManagement.items.map((int item) {
                              return DropdownMenuItem<int>(
                                value: item,
                                child: Text(
                                  item.toString(),
                                  style: GoogleFonts.robotoSerif(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (int? newValue) {
                              tableSize = newValue!;
                              setState(() {
                                tableSize;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      "Adauga",
                      style: GoogleFonts.robotoSerif(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(authController.getUser()!.email)
                            .collection("Nunta")
                            .doc("Mese")
                            .collection("Mese")
                            .add({
                              "NumeMasa": nameController.text,
                              "Marime": tableSize,
                              "IDMasa": tableID,
                              "Invitati": [],
                            })
                            .then((value) => {
                                  nameController.clear(),
                                  Get.close(1),
                                  getClientStream(),
                                  setState(() {}),
                                })
                            .catchError((error) => {
                                  // ignore: avoid_print
                                  print("Failed to add new Note due to $error")
                                });
                      }
                    },
                  )
                ],
              );
            },
          );
        },
        backgroundColor: dustyRose,
        child: const Icon(
          Icons.add,
          size: 26,
          color: Colors.white,
        ),
      ),
    );
  }
}
