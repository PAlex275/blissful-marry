import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  final controller = Get.put(AuthController());

  String subscriptionPlan = "";

  @override
  void onReady() async {
    await getSubscription();
  }

  getMaximMese() {
    late int maximMese;
    if (subscriptionPlan == 'base') {
      maximMese = 3;
    } else if (subscriptionPlan == 'advanced') {
      maximMese = 8;
    } else if (subscriptionPlan == 'premium') {
      maximMese = 99;
    }
    return maximMese;
  }

  getMaximInvitati() {
    late int maximInvitati;
    if (subscriptionPlan == 'base') {
      maximInvitati = 30;
    } else if (subscriptionPlan == 'advanced') {
      maximInvitati = 80;
    } else if (subscriptionPlan == 'premium') {
      maximInvitati = 9999;
    }
    return maximInvitati;
  }

  getMaximCheltuieli() {
    late int maximCheltuieli;
    if (subscriptionPlan == 'base') {
      maximCheltuieli = 10;
    } else if (subscriptionPlan == 'advanced') {
      maximCheltuieli = 20;
    } else if (subscriptionPlan == 'premium') {
      maximCheltuieli = 999;
    }
    return maximCheltuieli;
  }

  getSubscription() async {
    var q = FirebaseFirestore.instance
        .collection('Users')
        .doc(controller.getUser()!.email);
    var querySnapshot = await q.get();
    subscriptionPlan = querySnapshot.data()!['subscription'];
  }
}
