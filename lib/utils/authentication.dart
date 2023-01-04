import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;

  static Future<dynamic> signUp({required String email, required String password}) async{
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch(e) {
      print(e);
      return false;
    }
  }
}
