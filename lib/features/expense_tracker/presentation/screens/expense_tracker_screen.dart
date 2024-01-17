import 'package:blissful_marry/core/style/colors.dart';
import 'package:blissful_marry/features/expense_tracker/presentation/widgets/expense_tracker_card.dart';
import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ExpenseTrackerScreen extends StatelessWidget {
  const ExpenseTrackerScreen({super.key});
  static const String routeName = "/expensetracker";

  @override
  Widget build(BuildContext context) {
    bool shouldDelete = true;
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _title = TextEditingController();
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _description = TextEditingController();
    final controller = Get.put(AuthController());
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _amount = TextEditingController();
    double expenseTotalAmount = 0;
    SnackBar snackBar = SnackBar(
      content: const Text(
        'You\'ll delete this expense',
      ),
      action: SnackBarAction(
        label: 'ok',
        onPressed: () {
          shouldDelete = false;
        },
      ),
    );
    return Scaffold(
      backgroundColor: ivory,
      appBar: AppBar(
        title: const Text(
          'Gestionarea Bugetului',
        ),
        backgroundColor: dustyRose,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(controller.getUser()!.email)
                .collection("Wedding")
                .doc("Expenses")
                .collection("Expenses")
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
                snapshot.data!.docs.toList().forEach((element) {
                  expenseTotalAmount += element["expense_amount"];
                });
                if (expenseTotalAmount > 0) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 170,
                            color: ivory,
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: ExpenseTrackerCard(
                                child: Flexible(
                                  child: Text(
                                    '$expenseTotalAmount Lei \n'
                                    'Investiti pentru marea zi!',
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //Expenses list
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              color: ivory,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 30.0,
                                  top: 10,
                                ),
                                child: Text(
                                  'Raport de cheltuieli',
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: ivory,
                        child: const Padding(
                          padding:
                              EdgeInsets.only(left: 30, right: 30, top: 10),
                          child: Divider(
                            thickness: 3,
                            height: 5,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 350,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.toList().length,
                          itemBuilder: (context, index) {
                            var expenses = snapshot.data!.docs.toList();
                            return Dismissible(
                              confirmDismiss:
                                  (DismissDirection dismissDirection) async {
                                if (dismissDirection ==
                                    DismissDirection.endToStart) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  return shouldDelete;
                                }
                                return null;
                              },
                              background: Container(
                                alignment: Alignment.centerRight,
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 20.0),
                                  child: Icon(CupertinoIcons.delete),
                                ),
                              ),
                              key: Key(expenses[index].toString()),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20, top: 5, bottom: 5),
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: nude,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  expenses[index]
                                                      ["expense_title"],
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  '${expenses[index]["expense_amount"]} lei',
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  expenses[index]
                                                      ["expense_description"],
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  '${expenses[index]["expense_date"]}',
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: ExpenseTrackerCard(
                          child: Text(
                            'Add Your Expenses',
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
              return Text(
                '',
                style: GoogleFonts.nunito(
                  color: Colors.black,
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        label: const Icon(
          Icons.add,
          color: Colors.black,
          size: 18,
        ),
        backgroundColor: nude,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: nude,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(26.0))),
                contentPadding: const EdgeInsets.only(top: 10.0),
                content: SizedBox(
                  width: 400.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Adaugare cheltuiala",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Divider(
                        color: nude,
                        height: 4.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: TextField(
                          controller: _title,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Titlu",
                            hintStyle: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            labelStyle: GoogleFonts.roboto(
                              color: Colors.black,
                            ),
                          ),
                          maxLines: 1,
                        ),
                      ),
                      const Divider(
                        color: dustyRose,
                        height: 4.0,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: TextField(
                          controller: _description,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Descriere",
                            hintStyle: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            labelStyle: GoogleFonts.roboto(
                              color: Colors.black,
                            ),
                          ),
                          maxLines: 1,
                        ),
                      ),
                      const Divider(
                        color: dustyRose,
                        height: 4.0,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: TextField(
                          controller: _amount,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Suma",
                            hintStyle: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            labelStyle: GoogleFonts.roboto(
                              color: Colors.black,
                            ),
                          ),
                          maxLines: 1,
                        ),
                      ),
                      const Divider(
                        color: dustyRose,
                        height: 4.0,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      InkWell(
                        onTap: () {
                          expenseTotalAmount = 0;
                          if (_amount.text != '' &&
                              _title.text != '' &&
                              _description.text != '') {
                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(controller.getUser()!.email)
                                .collection("Wedding")
                                .doc("Expenses")
                                .collection("Expenses")
                                .add({
                              "expense_title": _title.text,
                              "expense_description": _description.text,
                              "expense_amount": int.tryParse(_amount.text),
                              "expense_date":
                                  DateFormat.yMMMEd().format(DateTime.now()),
                            }).then((value) => {
                                      _amount.clear(),
                                      _title.clear(),
                                      _description.clear(),
                                      Get.close(1)
                                    });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 40.0,
                            right: 40,
                            bottom: 3,
                          ),
                          child: Container(
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 15.0),
                            decoration: BoxDecoration(
                              color: ivory,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "Adauga",
                              style: TextStyle(
                                color: Colors.black,
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
                                const EdgeInsets.only(top: 10.0, bottom: 15.0),
                            decoration: BoxDecoration(
                              color: ivory,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Cancel",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: Colors.black,
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
      ),
    );
  }
}
