import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

class SeatManagementController extends GetxController {
  final authController = Get.put(AuthController());

  changeID(int deletedID, controller) async {
    var tables = FirebaseFirestore.instance
        .collection('Users')
        .doc(controller.getUser()!.email)
        .collection("Wedding")
        .doc("Tables")
        .collection("Tables");
    var querySnapshots = await tables.get();
    for (var doc in querySnapshots.docs) {
      var id = doc['TableID'];
      id--;
      if (doc['TableID'] > deletedID) {
        await doc.reference.update({
          'TableID': id,
        });
      }
    }
  }

  Future<int> getIndex(controller) async {
    AggregateQuerySnapshot query = await FirebaseFirestore.instance
        .collection('Users')
        .doc(controller.getUser()!.email)
        .collection("Wedding")
        .doc("Tables")
        .collection("Tables")
        .count()
        .get();
    int tableIndex = query.count!;
    tableIndex++;
    return tableIndex;
  }
}
