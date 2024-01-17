import 'package:blissful_marry/core/style/colors.dart';
import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final SearchController searchController = SearchController();
  // ignore: no_leading_underscores_for_local_identifiers
  String _attendAnswerController = "Da";
  final List<String> attendLabels = ["Da", "Neconfirmat"];
  final controller = Get.put(AuthController());
  final formKey = GlobalKey<FormState>();
  List allResults = [];
  List resultList = [];

  getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(controller.getUser()!.email)
        .collection("Wedding")
        .doc("GuestIDS")
        .collection("Guests")
        .get();
    allResults = data.docs;
    searchResultList();
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
        var name = clientSnapShot['GuestName'].toString().toLowerCase();
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
          style: GoogleFonts.roboto(
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                height: 70,
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
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: resultList.length,
                  itemBuilder: (context, index) {
                    return resultList.isEmpty
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            color: ivory,
                            child: Center(
                              child: Text(
                                'Adaugati Invitati',
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 11,
                            ),
                            child: SizedBox(
                              height: context.height,
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1.15,
                                ),
                                itemCount: resultList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Card(
                                      semanticContainer: true,
                                      color: nude,
                                      elevation: 0,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Nume: ${resultList[index]['GuestName']}',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Numar de telefon: ${resultList[index]['GuestPhoneNumber']}',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Confirmat: ${resultList[index]['GuestAttendance']}',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              FirebaseFirestore.instance
                                                  .collection('Users')
                                                  .doc(controller
                                                      .getUser()!
                                                      .email)
                                                  .collection("Wedding")
                                                  .doc("GuestIDS")
                                                  .collection("Guests")
                                                  .doc(resultList[index].id)
                                                  .delete();
                                              getClientStream();
                                              setState(() {});
                                            },
                                            child: const Icon(
                                              Icons.delete_outline,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        backgroundColor: dustyRose,
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
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _nameController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Introduceti numele';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Nume',
                            icon: Icon(Icons.account_box),
                          ),
                        ),
                        TextFormField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Numar de telefon',
                            icon: Icon(Icons.phone_iphone_outlined),
                          ),
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
                            const Text('A confirmat prezenta?'),
                            const SizedBox(
                              height: 10,
                            ),
                            ToggleSwitch(
                              inactiveBgColor: Colors.white,
                              inactiveFgColor: Colors.black,
                              activeBgColor: const [ivory],
                              initialLabelIndex: 0,
                              totalSwitches: 2,
                              minWidth: 100,
                              fontSize: 12,
                              labels: attendLabels,
                              onToggle: (index) {
                                _attendAnswerController = attendLabels[index!];
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
                            .doc(controller.getUser()!.email)
                            .collection("Wedding")
                            .doc("GuestIDS")
                            .collection("Guests")
                            .add({
                              "GuestName": _nameController.text,
                              "GuestPhoneNumber": _phoneNumberController.text,
                              "GuestAttendance": _attendAnswerController,
                            })
                            .then((value) => {
                                  _nameController.clear(),
                                  _phoneNumberController.clear(),
                                  getClientStream(),
                                  setState(() {}),
                                  Get.close(1),
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
        label: const Icon(
          Icons.add,
          size: 26,
          color: Colors.white,
        ),
      ),
    );
  }
}
