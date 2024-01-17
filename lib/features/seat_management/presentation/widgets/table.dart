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
    List<String> guests = List.from(widget.doc['guests']);
    int tableSize = widget.doc['TableSize'];
    final TextEditingController nameController = TextEditingController();
    final TextEditingController tableNameController = TextEditingController();
    double widgetHeight = (guests.length + 1) * 50.0 + 35;
    final formKey = GlobalKey<FormState>();

    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: widgetHeight,
      decoration: BoxDecoration(
        color: dustyRose,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 5,
            ),
            height: 35,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    children: [
                      Text(
                        widget.doc['TableName'],
                        style: GoogleFonts.roboto(
                          fontSize: 23,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 2,
                          left: 10,
                        ),
                        child: Text(
                          '${guests.length}/$tableSize',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    guests.length < tableSize
                        ? IconButton(
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
                                              TextFormField(
                                                controller: nameController,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Nume',
                                                  icon: Icon(Icons.account_box),
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
                                            style: GoogleFonts.roboto(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () {
                                            if (nameController.text != '') {
                                              guests.add(nameController.text);
                                              FirebaseFirestore.instance
                                                  .collection('Users')
                                                  .doc(controller
                                                      .getUser()!
                                                      .email)
                                                  .collection("Wedding")
                                                  .doc("Tables")
                                                  .collection("Tables")
                                                  .doc(widget.doc.id)
                                                  .update({'guests': guests})
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
                                        )
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.white,
                            ),
                          )
                        : const SizedBox.shrink(),
                    IconButton(
                      onPressed: () {
                        tableNameController.text = widget.doc['TableName'];
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
                                          controller: tableNameController,
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
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          items: SeatManagement.items
                                              .map((int item) {
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
                                    style: GoogleFonts.roboto(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    setState(() {});
                                    if (formKey.currentState!.validate()) {
                                      FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(controller.getUser()!.email)
                                          .collection("Wedding")
                                          .doc("Tables")
                                          .collection("Tables")
                                          .doc(widget.doc.id)
                                          .update({
                                            'TableName':
                                                tableNameController.text,
                                            'TableSize': tableSize,
                                            'guests': guests.take(tableSize),
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
                                )
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(controller.getUser()!.email)
                            .collection("Wedding")
                            .doc("Tables")
                            .collection("Tables")
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
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            height: (guests.length + 1) * 50.0,
            decoration: const BoxDecoration(
              color: dustyRose,
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
                  color: dustyRose,
                );
              },
              padding: EdgeInsets.zero,
              itemCount:
                  guests.length < tableSize ? guests.length + 1 : guests.length,
              itemBuilder: (context, index) {
                if (index < tableSize && index == guests.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: nude, borderRadius: BorderRadius.circular(10)),
                    child: Dismissible(
                      direction: DismissDirection.endToStart,
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.delete,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onDismissed: (DismissDirection direction) {
                        setState(() {
                          guests.removeAt(index);
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(controller.getUser()!.email)
                              .collection("Wedding")
                              .doc("Tables")
                              .collection("Tables")
                              .doc(widget.doc.id)
                              .update({'guests': guests}).catchError(
                                  (error) => {
                                        // ignore: avoid_print
                                        print(
                                            "Failed to add new Note due to $error")
                                      });
                        });
                        widget.voidCallback();
                      },
                      child: ListTile(
                        dense: true,
                        tileColor: ivory,
                        visualDensity: const VisualDensity(
                          vertical: 0,
                        ),
                        title: Text(
                          widget.doc['guests'][index],
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                          ),
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
    );
  }
}
