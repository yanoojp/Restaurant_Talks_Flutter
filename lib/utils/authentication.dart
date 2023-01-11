import 'package:firebase_auth/firebase_auth.dart';
import '../model/account.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;
  static Account? myAccount;

  static Future<dynamic> signUp(
      {required String email, required String password,}) async {
    try {
      final newAccount = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      currentFirebaseUser = newAccount.user;
      return newAccount;
    } on FirebaseAuthException {
      return false;
    }
  }

  static Future<dynamic> login(
      {required String email, required String password,}) async {
    try {
      final result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      currentFirebaseUser = result.user;
      return result;
    } on FirebaseAuthException {
      return false;
    }
  }

  static Future<void> deleteAccount() async {
    await currentFirebaseUser!.delete();
  }

  static Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
