import 'package:blissful_marry/core/style/colors.dart';
import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key});
  static const String routeName = "/noteeditorscreen";
  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: ivory,
      appBar: AppBar(
        backgroundColor: dustyRose,
        elevation: 0.0,
        title: Text(
          'Adauga o notita',
          style: GoogleFonts.roboto(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                fillColor: nude,
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: nude.withOpacity(0.8), width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: nude.withOpacity(0.8), width: 1.0),
                ),
                hintText: 'Titlu',
                hintStyle: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 16),
              ),
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 150,
              child: TextFormField(
                controller: _contentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  fillColor: nude,
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: nude.withOpacity(0.8), width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: nude.withOpacity(0.8), width: 1.0),
                  ),
                  hintText: 'Continut...',
                  hintStyle: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 100,
        child: FloatingActionButton(
          elevation: 0,
          onPressed: () {
            FirebaseFirestore.instance
                .collection('Users')
                .doc(controller.getUser()!.email)
                .collection("Notes")
                .add({
                  "note_title": _titleController.text,
                  "creation_date": DateFormat.yMMMEd().format(DateTime.now()),
                  "note_content": _contentController.text,
                })
                .then((value) => {Get.close(1)})
                .catchError((error) => {
                      // ignore: avoid_print
                      print("Failed to add new Note due to $error"),
                    });
          },
          backgroundColor: nude,
          // isExtended: true,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Adauga',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
