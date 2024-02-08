import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  updateWeddingDate(DateTime dateTime, controller, snapshot) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(controller.getUser()!.email)
        .collection("Nunta")
        .doc(snapshot.data!.docs.first.id)
        .update({
      "data_nuntii": dateTime,
    });
  }

  addWeddingDate(DateTime dateTime, controller, snapshot) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(controller.getUser()!.email)
        .collection("Nunta")
        .add({
      "data_nuntii": dateTime,
    });
  }
}
