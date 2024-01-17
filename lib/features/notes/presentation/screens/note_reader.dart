import 'package:blissful_marry/core/style/colors.dart';
import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteReaderScreen extends StatefulWidget {
  const NoteReaderScreen({this.doc, super.key});
  final QueryDocumentSnapshot? doc;
  static const String routeName = "/notereader";
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ivory,
      appBar: AppBar(
        backgroundColor: dustyRose,
        elevation: 0.0,
        title: Text(widget.doc!["note_title"],
            style: GoogleFonts.roboto(
              fontSize: 25,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc!["creation_date"],
              style: GoogleFonts.roboto(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: dustyRose,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              widget.doc!["note_content"],
              style: GoogleFonts.roboto(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: dustyRose,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                FirebaseFirestore.instance
                    .collection('Users')
                    .doc(controller.getUser()!.email)
                    .collection("Notes")
                    .doc(widget.doc!.id)
                    .delete();
                Get.close(1);
              },
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('Users')
                          .doc(controller.getUser()!.email)
                          .collection("Notes")
                          .doc(widget.doc!.id)
                          .delete();
                      Get.close(1);
                    },
                  ),
                  Text(
                    'Delete Note',
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
