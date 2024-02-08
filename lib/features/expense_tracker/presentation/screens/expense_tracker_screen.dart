import 'package:blissful_marry/core/style/colors.dart';
import 'package:blissful_marry/features/expense_tracker/presentation/widgets/expense_tracker_card.dart';
import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ExpenseTrackerScreen extends StatelessWidget {
  const ExpenseTrackerScreen({super.key});
  static const String routeName = "/expensetracker";

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _title = TextEditingController();
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _description = TextEditingController();
    final controller = Get.put(AuthController());
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _amount = TextEditingController();
    double expenseTotalAmount = 0;

    return Scaffold(
      backgroundColor: ivory,
      appBar: AppBar(
        title: Text(
          'Gestionarea Bugetului',
          style: GoogleFonts.robotoSerif(
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
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
                expenseTotalAmount = 0;
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
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: ExpenseTrackerCard(
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total Cheltuieli',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.robotoSerif(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '$expenseTotalAmount Lei',
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.robotoSerif(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      //Expenses list
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
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
                          Padding(
                            padding: const EdgeInsets.only(top: 10, right: 30),
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
                                                      .collection("Wedding")
                                                      .doc("Expenses")
                                                      .collection("Expenses")
                                                      .add({
                                                    "expense_title":
                                                        _title.text,
                                                    "expense_description":
                                                        _description.text,
                                                    "expense_amount":
                                                        int.tryParse(
                                                            _amount.text),
                                                    "expense_date":
                                                        DateFormat.yMMMEd()
                                                            .format(
                                                                DateTime.now()),
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
                                Icons.add_box_rounded,
                                color: dustyRose,
                                size: 30,
                              ),
                            ),
                          )
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
                        height: MediaQuery.of(context).size.height * 0.60,
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.toList().length,
                            itemBuilder: (context, index) {
                              var expenses = snapshot.data!.docs.toList();
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, top: 5, bottom: 5),
                                child: Container(
                                  height: 75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: light,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              expenses[index]["expense_title"],
                                              style: GoogleFonts.robotoSerif(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              '${expenses[index]["expense_amount"]} lei',
                                              style: GoogleFonts.robotoSerif(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                expenses[index]
                                                    ["expense_description"],
                                                style: GoogleFonts.robotoSerif(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  FirebaseFirestore.instance
                                                      .collection('Users')
                                                      .doc(controller
                                                          .getUser()!
                                                          .email)
                                                      .collection("Wedding")
                                                      .doc("Expenses")
                                                      .collection("Expenses")
                                                      .doc(expenses[index].id)
                                                      .delete();
                                                },
                                                child: Icon(
                                                  Icons.delete_outlined,
                                                  color: Colors.black
                                                      .withOpacity(0.8),
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Adauga cheltuieli',
                                style: GoogleFonts.robotoSerif(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, right: 30),
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text(
                                                      "Adaugare cheltuiala",
                                                      style: GoogleFonts
                                                          .robotoSerif(
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 30.0,
                                                          right: 30.0),
                                                  child: TextField(
                                                    style:
                                                        GoogleFonts.robotoSerif(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                    ),
                                                    controller: _title,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: InputDecoration(
                                                      hintText: "Titlu",
                                                      hintStyle: GoogleFonts
                                                          .robotoSerif(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.8),
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      labelStyle:
                                                          GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 30.0,
                                                          right: 30.0),
                                                  child: TextField(
                                                    controller: _description,
                                                    style:
                                                        GoogleFonts.robotoSerif(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                    ),
                                                    cursorColor: Colors.black,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: InputDecoration(
                                                      hintText: "Descriere",
                                                      hintStyle: GoogleFonts
                                                          .robotoSerif(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.8),
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      labelStyle:
                                                          GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 30.0,
                                                          right: 30.0),
                                                  child: TextField(
                                                    style:
                                                        GoogleFonts.robotoSerif(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                    ),
                                                    cursorColor: Colors.black,
                                                    controller: _amount,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      suffix: Text(
                                                        'Lei',
                                                        style: GoogleFonts
                                                            .robotoSerif(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      hintText: "Suma",
                                                      hintStyle: GoogleFonts
                                                          .robotoSerif(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.8),
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      labelStyle:
                                                          GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                          .collection("Wedding")
                                                          .doc("Expenses")
                                                          .collection(
                                                              "Expenses")
                                                          .add({
                                                        "expense_title":
                                                            _title.text,
                                                        "expense_description":
                                                            _description.text,
                                                        "expense_amount":
                                                            int.tryParse(
                                                                _amount.text),
                                                        "expense_date":
                                                            DateFormat.yMMMEd()
                                                                .format(DateTime
                                                                    .now()),
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
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                        color:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Text(
                                                        "Adauga",
                                                        style: GoogleFonts
                                                            .robotoSerif(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                        color:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Text(
                                                        "Cancel",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .robotoSerif(
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
                                    Icons.add_box_rounded,
                                    color: dustyRose,
                                    size: 50,
                                  ),
                                ),
                              )
                            ],
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
    );
  }
}
