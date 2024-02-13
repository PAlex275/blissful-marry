import 'package:blissful_marry/core/style/colors.dart';
import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';
import 'package:blissful_marry/features/notes/presentation/screens/note_editor.dart';
import 'package:blissful_marry/features/notes/presentation/screens/note_reader.dart';
import 'package:blissful_marry/features/notes/presentation/widgets/note_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});
  static const String routeName = "/notesscreen";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notite',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w700,
            fontSize: 27,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: dustyRose,
      ),
      backgroundColor: ivory,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(controller.getUser()!.email)
                    .collection("Notite")
                    .orderBy('data', descending: true)
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
                    List<Widget> notes = snapshot.data!.docs
                        .map(
                          (note) => noteCard(
                            () => Get.to(() => NoteReaderScreen(doc: note)),
                            note,
                            150,
                            150,
                          ),
                        )
                        .toList();
                    notes.add(Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: light,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 150,
                      height: 150,
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            Get.to(() => const NoteEditorScreen());
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 25,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ));
                    return snapshot.data!.docs.isEmpty
                        ? Center(
                            child: Text(
                              'Adauga notite',
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 26,
                              ),
                            ),
                          )
                        : GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            children: notes,
                          );
                  }
                  return Text(
                    'There\'s no Notes',
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
