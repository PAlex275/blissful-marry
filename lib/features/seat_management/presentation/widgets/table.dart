import 'package:blissful_marry/core/style/colors.dart';
import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';
import 'package:blissful_marry/features/seat_management/presentation/screens/seat_management.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WeddingTable extends StatefulWidget {
  const WeddingTable({
    super.key,
    required this.doc,
    required this.voidCallback,
  });
  final QueryDocumentSnapshot doc;
  final VoidCallback voidCallback;

  @override
  State<WeddingTable> createState() => _WeddingTableState();
}

class _WeddingTableState extends State<WeddingTable> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    List<String> guests = List.from(widget.doc['Invitati']);
    int tableSize = widget.doc['Marime'];
    final TextEditingController nameController = TextEditingController();
    final TextEditingController tableNameController = TextEditingController();
    double widgetHeight = guests.length < tableSize
        ? (guests.length + 1) * 53.5 + 68
        : guests.length * 53.5 + 75;
    final formKey = GlobalKey<FormState>();
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: widgetHeight,
      decoration: BoxDecoration(
        color: light,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            height: 43,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    children: [
                      Text(
                        widget.doc['NumeMasa'],
                        style: GoogleFonts.robotoSerif(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          '${guests.length}/$tableSize',
                          style: GoogleFonts.robotoSerif(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        tableNameController.text = widget.doc['NumeMasa'];
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
                                'Invitat',
                                style: GoogleFonts.robotoSerif(
                                  fontSize: 16,
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
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                          controller: tableNameController,
                                          validator: (text) {
                                            if (text == null || text.isEmpty) {
                                              return 'Acest camp nu poate fi gol';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Nume Masa',
                                            labelStyle: GoogleFonts.robotoSerif(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: DropdownButtonFormField(
                                          elevation: 2,
                                          dropdownColor: light,
                                          value: tableSize,
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.black,
                                          ),
                                          items: SeatManagement.items
                                              .map((int item) {
                                            return DropdownMenuItem<int>(
                                              value: item,
                                              child: Text(
                                                item.toString(),
                                                style: GoogleFonts.robotoSerif(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
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
                                            widget.voidCallback();
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
                                    "Actualizeaza",
                                    style: GoogleFonts.robotoSerif(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {});
                                    if (formKey.currentState!.validate()) {
                                      FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(controller.getUser()!.email)
                                          .collection("Nunta")
                                          .doc("Mese")
                                          .collection("Mese")
                                          .doc(widget.doc.id)
                                          .update({
                                            'NumeMasa':
                                                tableNameController.text,
                                            'Marime': tableSize,
                                            'Invitati': guests.take(tableSize),
                                          })
                                          .then((value) => {
                                                Get.close(1),
                                                widget.voidCallback(),
                                                setState(() {}),
                                              })
                                          .catchError((error) => {
                                                // ignore: avoid_print
                                                print(
                                                    "Failed to add new Note due to $error")
                                              });
                                    }
                                  },
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.close(1);
                                  },
                                  child: Text(
                                    'Anuleaza',
                                    style: GoogleFonts.robotoSerif(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.edit_square,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(controller.getUser()!.email)
                            .collection("Nunta")
                            .doc("Mese")
                            .collection("Mese")
                            .doc(widget.doc.id)
                            .delete()
                            .then((value) => {
                                  nameController.clear(),
                                  setState(() {}),
                                  widget.voidCallback(),
                                })
                            .catchError((error) => {
                                  // ignore: avoid_print
                                  print("Failed to add new Note due to $error")
                                });
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              height: guests.length * 53.5,
              decoration: const BoxDecoration(
                color: light,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 5,
                    color: light,
                  );
                },
                padding: EdgeInsets.zero,
                itemCount: guests.length < tableSize
                    ? guests.length + 1
                    : guests.length,
                itemBuilder: (context, index) {
                  if (index < tableSize && index == guests.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        dense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        tileColor: light.withOpacity(0.7),
                        visualDensity: const VisualDensity(
                          vertical: 0,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.doc['Invitati'][index],
                              style: GoogleFonts.robotoSerif(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            InkWell(
                              onTap: () {
                                guests.removeAt(index);
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(controller.getUser()!.email)
                                    .collection("Nunta")
                                    .doc("Mese")
                                    .collection("Mese")
                                    .doc(widget.doc.id)
                                    .update({'Invitati': guests})
                                    .then((value) => {
                                          widget.voidCallback(),
                                          setState(() {}),
                                        })
                                    .catchError((error) => {
                                          // ignore: avoid_print
                                          print(
                                              "Failed to add new Note due to $error")
                                        });
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.black,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          guests.length < tableSize
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    height: 43.5,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: IconButton(
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
                                    'Invitat',
                                    style: GoogleFonts.robotoSerif(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      child: Column(
                                        children: <Widget>[
                                          TextFormField(
                                            controller: nameController,
                                            decoration: InputDecoration(
                                              labelText: 'Nume',
                                              labelStyle:
                                                  GoogleFonts.robotoSerif(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              icon: const Icon(
                                                Icons.account_box,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
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
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () {
                                        if (nameController.text != '') {
                                          guests.add(nameController.text);
                                          FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(controller.getUser()!.email)
                                              .collection("Nunta")
                                              .doc("Mese")
                                              .collection("Mese")
                                              .doc(widget.doc.id)
                                              .update({'Invitati': guests})
                                              .then((value) => {
                                                    nameController.clear(),
                                                    Get.close(1),
                                                    setState(() {}),
                                                    widget.voidCallback(),
                                                  })
                                              .catchError((error) => {
                                                    // ignore: avoid_print
                                                    print(
                                                        "Failed to add new Note due to $error")
                                                  });
                                        }
                                      },
                                    ),
                                    TextButton(
                                      child: Text(
                                        "Anuleaza",
                                        style: GoogleFonts.robotoSerif(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      onPressed: () {
                                        Get.close(1);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
