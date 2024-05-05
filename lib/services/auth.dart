import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<String?> login (String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  static User? me () {
    return auth.currentUser;
  }

  static Future<void> logout () async {
    auth.signOut();
  }

  static Future<String?> register (String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}