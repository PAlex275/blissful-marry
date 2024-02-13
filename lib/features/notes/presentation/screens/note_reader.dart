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
        title: Text(widget.doc!["titlu"],
            style: GoogleFonts.robotoSerif(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.doc!["data"],
                  style: GoogleFonts.robotoSerif(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  widget.doc!["continut"],
                  style: GoogleFonts.robotoSerif(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                FirebaseFirestore.instance
                    .collection('Users')
                    .doc(controller.getUser()!.email)
                    .collection("Notite")
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
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(controller.getUser()!.email)
                          .collection("Notite")
                          .doc(widget.doc!.id)
                          .delete();
                      Get.close(1);
                    },
                  ),
                  Text(
                    'Sterge notita',
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
