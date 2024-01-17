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
import 'package:info_popup/info_popup.dart';

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
        var name = clientSnapShot['TableName'].toString().toLowerCase();
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
        .collection("Wedding")
        .doc("Tables")
        .collection("Tables")
        .orderBy('TableID')
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
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: InfoPopupWidget(
              contentTitle: 'Gliseasa stanga pentru a sterge un invitat',
              child: Icon(
                Icons.info,
                color: Colors.white,
              ),
            ),
          ),
        ],
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
                  horizontal: 25,
                ),
                child: SizedBox(
                  height: 50,
                  child: CupertinoSearchTextField(
                    placeholder: 'Cautati',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    suffixIcon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    controller: searchController,
                    backgroundColor: nude,
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
                    itemCount: resultList.length,
                    itemBuilder: (context, index) {
                      return resultList.isEmpty
                          ? Container(
                              height: MediaQuery.of(context).size.height,
                              color: ivory,
                              child: Center(
                                child: Text(
                                  'Adaugati Mese',
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              color: ivory,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 20,
                                  left: 25,
                                  right: 25,
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
                    child: Column(
                      children: <Widget>[
                        Form(
                          key: formKey,
                          child: TextFormField(
                            controller: nameController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Acest camp nu poate fi gol';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Nume Masa',
                              icon: Icon(Icons.account_box),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text('Locuri'),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: DropdownButtonFormField(
                            elevation: 2,
                            value: tableSize,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: SeatManagement.items.map((int item) {
                              return DropdownMenuItem<int>(
                                value: item,
                                child: Text(item.toString()),
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
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(authController.getUser()!.email)
                            .collection("Wedding")
                            .doc("Tables")
                            .collection("Tables")
                            .add({
                              "TableName": nameController.text,
                              "TableSize": tableSize,
                              "TableID": tableID,
                              "guests": [],
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
