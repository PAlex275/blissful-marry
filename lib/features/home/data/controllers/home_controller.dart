import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  updateWeddingDate(DateTime dateTime, controller, snapshot) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(controller.getUser()!.email)
        .collection("Wedding")
        .doc(snapshot.data!.docs.first.id)
        .update({
      "wedding_date": dateTime,
    });
  }
}
