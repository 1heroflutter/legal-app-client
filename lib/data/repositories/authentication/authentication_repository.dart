import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart' as google;

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final _auth = FirebaseAuth.instance;
  final google.GoogleSignIn _googleSignIn = google.GoogleSignIn();

  late final Rx<User?> _firebaseUser;

  @override
  void onReady() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
  }

  // --- Actions ---

  // Email/Password Login
  Future<UserCredential> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw 'Lỗi đăng nhập: $e';
    }
  }

  // Email/Password Register
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw 'Lỗi đăng ký: $e';
    }
  }

  // Google Sign-in
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final google.GoogleSignInAccount? googleUser = await _googleSignIn
          .signIn();
      if (googleUser == null) return null;

      final google.GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credentials);
    } catch (e) {
      throw 'Lỗi đăng nhập Google: $e';
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      throw 'Lỗi đăng xuất: $e';
    }
  }
}
