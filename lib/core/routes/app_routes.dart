import 'package:blissful_marry/features/expense_tracker/presentation/screens/expense_tracker_screen.dart';
import 'package:blissful_marry/features/guest_list/presentation/screens/guest_list_screen.dart';
import 'package:blissful_marry/features/home/presetation/screens/home_screen.dart';
import 'package:blissful_marry/features/login/presentation/screens/login_screen.dart';
import 'package:blissful_marry/features/login/presentation/screens/splash_screen.dart';
import 'package:blissful_marry/features/notes/presentation/screens/note_editor.dart';
import 'package:blissful_marry/features/notes/presentation/screens/note_reader.dart';
import 'package:blissful_marry/features/notes/presentation/screens/notes.dart';
import 'package:blissful_marry/features/seat_management/presentation/screens/seat_management.dart';
import 'package:blissful_marry/features/subscription/presentation/screens/subscription_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(
          name: "/",
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: HomeScreen.routeName,
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: GuestListScreen.routeName,
          page: () => const GuestListScreen(),
        ),
        GetPage(
          name: SeatManagement.routeName,
          page: () => const SeatManagement(),
        ),
        GetPage(
          name: ExpenseTrackerScreen.routeName,
          page: () => const ExpenseTrackerScreen(),
        ),
        GetPage(
          name: NotesScreen.routeName,
          page: () => const NotesScreen(),
        ),
        GetPage(
          name: NoteReaderScreen.routeName,
          page: () => const NoteReaderScreen(),
        ),
        GetPage(
          name: NoteEditorScreen.routeName,
          page: () => const NoteEditorScreen(),
        ),
        GetPage(
          name: SubscriptionScreen.routeName,
          page: () => const SubscriptionScreen(),
        ),
      ];
}
