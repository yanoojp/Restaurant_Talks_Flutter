import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_talks_flutter/utils/authentication.dart';
import '../../model/account.dart';

class UserFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference users =
      _firestoreInstance.collection('Users');

  static Future<bool> setUser(Account newAccount, String email) async {
    try {
      await users.doc(newAccount.id).set({
        'hotelName': newAccount.hotelName,
        'email': email,
        'nameOfRepresentative': newAccount.nameOfRepresentative,
        'prefecture': newAccount.prefecture,
      });
      return true;
    } on FirebaseException {
      return false;
    }
  }

  static Future<dynamic> getUser(String uid, String email) async {
    try {
      final documentSnapshot = await users.doc(uid).get();
      final data =
          documentSnapshot.data() as Map<String, dynamic>;
      final myAccount = Account(
        id: uid,
        email: email,
        hotelName: data['hotelName'],
        nameOfRepresentative: data['nameOfRepresentative'],
        prefecture: data['prefecture'],
      );

      Authentication.myAccount = myAccount;
      return myAccount;
    } on FirebaseException {
      return false;
    }
  }

  static Future<bool> updateUser(Account updateAccount) async {
    try {
      await users.doc(updateAccount.id).update({
        'hotelName': updateAccount.hotelName,
        'email': updateAccount.email,
        'nameOfRepresentative': updateAccount.nameOfRepresentative,
        'prefecture': updateAccount.prefecture,
      });
      return true;
    } on FirebaseException {
      return false;
    }
  }

  static Future<dynamic> deleteUser(String accountId) async {
    await users.doc(accountId).delete();
  }
}
