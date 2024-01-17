import 'package:blissful_marry/core/firebase_references/references.dart';
import 'package:blissful_marry/features/home/presetation/screens/home_screen.dart';
import 'package:blissful_marry/features/login/presentation/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;
  late final _user = Rxn<User>();
  late double _expenseTotalAmount = 0;
  late Stream<User?> _authStateChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });

    if (isLoggedIn() == true) {
      navigateToHomePage();
    } else {
      navigateToLoginPage();
    }
  }

  signInWithGoogle() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _authAccount = await account.authentication;
        // ignore: no_leading_underscores_for_local_identifiers
        final _credentials = GoogleAuthProvider.credential(
          idToken: _authAccount.idToken,
          accessToken: _authAccount.accessToken,
        );
        await _auth.signInWithCredential(_credentials);
        await saveUser(account);
        navigateToHomePage();
      }
    } on Exception catch (error) {
      // ignore: avoid_print
      print(error);
    }
  }

  setExpenseAmount(double total) {
    _expenseTotalAmount = total;
  }

  double getExpenseAmount() {
    return _expenseTotalAmount;
  }

  saveUser(GoogleSignInAccount account) async {
    userRF.doc(account.email).set({
      "email": account.email,
      "name": account.displayName,
      "profilepic": account.photoUrl,
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('email', account.email);
    account.displayName != null
        ? await prefs.setString('name', account.displayName!)
        : null;
    account.photoUrl != null
        ? await prefs.setString('profilePic', account.photoUrl!)
        : null;
  }

  void navigateToLoginPage() {
    Get.offAllNamed(LoginScreen.routeName);
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  void navigateToHomePage() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      navigateToLoginPage();
    } on FirebaseAuthException catch (exception) {
      // ignore: avoid_print
      print(exception);
    }
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }
}
