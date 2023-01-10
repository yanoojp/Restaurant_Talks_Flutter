import 'package:cloud_firestore/cloud_firestore.dart';

class GuestNumberFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference guestNumber = _firestoreInstance.collection('guestNumbers');
  static final CollectionReference users = _firestoreInstance.collection('Users');

  static Future<bool> setGuestNumber(accountId) async{
    try {
      guestNumber
        .doc()
        .set(
          {
            'guestNumber': 0,
            'accountId': accountId,
          }
        );
      return true;
    } on FirebaseException catch(e) {
      return false;
    }
  }

  static Future<bool> updateGuestNumber(updateGuestNumber, accountId) async{
    try {
      final snapShot = await FirebaseFirestore.instance.collection('guestNumbers').where('accountId', isEqualTo: accountId).get();
      snapShot.docs.forEach((doc) async{
        String docId = doc.reference.id;
        await guestNumber.doc(docId).update(
            {
              'accountId': accountId,
              'guestNumber': updateGuestNumber,
            }
        );
      });
      return true;
    } on FirebaseException catch(e) {
      return false;
    }
  }

  static Future<int> getGuestNumber(accountId) async{
    final snapShot = await FirebaseFirestore.instance.collection('guestNumbers').where('accountId', isEqualTo: accountId).get();
    final gn = snapShot.docs.first.data()['guestNumber'];
    return gn;
  }

  static Future<void> deleteGuestNumber(accountId) async{
    final snapShot = await FirebaseFirestore.instance.collection('guestNumbers').where('accountId', isEqualTo: accountId).get();
    snapShot.docs.forEach((doc) async{
      String docId = doc.reference.id;
      await guestNumber.doc(docId).delete();
    });
  }
}