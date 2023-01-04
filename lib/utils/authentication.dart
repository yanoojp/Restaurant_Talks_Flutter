import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;

  static Future<bool> signUp({
    required String email,
    required String password
  }) async{
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      return true;
    } on FirebaseAuthException catch(e) {
      return false;
    }
  }

  static Future<bool> login({
    required String email,
    required String password
  }) async{
    try {
      final UserCredential _result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      currentFirebaseUser =_result.user;
      print('ok');
      return true;
    } on FirebaseAuthException catch(e) {
      print('ng');
      return false;
    }
  }
}
