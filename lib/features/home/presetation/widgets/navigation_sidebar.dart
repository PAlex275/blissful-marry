import 'package:blissful_marry/core/style/colors.dart';
import 'package:blissful_marry/features/expense_tracker/presentation/screens/expense_tracker_screen.dart';
import 'package:blissful_marry/features/guest_list/presentation/screens/guest_list_screen.dart';
import 'package:blissful_marry/features/home/presetation/screens/home_screen.dart';
import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';
import 'package:blissful_marry/features/notes/presentation/screens/notes.dart';
import 'package:blissful_marry/features/seat_management/presentation/screens/seat_management.dart';
import 'package:blissful_marry/features/subscription/presentation/screens/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationSideBar extends GetView<AuthController> {
  const NavigationSideBar({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: Container(
          decoration: const BoxDecoration(color: ivory),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildHeader(context),
                const SizedBox(
                  height: 5,
                ),
                buildMenuItems(context),
              ],
            ),
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        color: nude,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 52,
              backgroundImage:
                  NetworkImage(controller.getUser()?.photoURL ?? ''),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              controller.getUser()?.displayName ?? '',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              controller.getUser()?.email ?? '',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 11,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        color: ivory,
        child: Wrap(
          runSpacing: 10,
          children: [
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.black,
              ),
              title: Text(
                'Home',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Get.back();
                Get.toNamed(HomeScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.people,
                color: Colors.black,
              ),
              title: Text(
                'Gestionarea Invitați',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Get.back();
                Get.toNamed(GuestListScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.table_bar,
                color: Colors.black,
              ),
              title: Text(
                'Gestionarea Meselor',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Get.back();
                Get.toNamed(SeatManagement.routeName);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.notes,
                color: Colors.black,
              ),
              title: Text(
                'Notițe',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Get.back();
                Get.toNamed(NotesScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.attach_money,
                color: Colors.black,
              ),
              title: Text(
                'Buget și Cheltuieli',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Get.back();
                Get.toNamed(ExpenseTrackerScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.subscriptions_outlined,
                color: Colors.black,
              ),
              title: Text(
                'Abonamentul Tău',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Get.back();
                Get.toNamed(SubscriptionScreen.routeName);
              },
            ),
            const Divider(
              color: nude,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: Text(
                  'Deconectează-te',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  controller.signOut();
                },
              ),
            ),
          ],
        ),
      );
}
