import 'package:cloud_firestore/cloud_firestore.dart';
import '../../fixedDatas/variables.dart';

class ItemFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference items =
      _firestoreInstance.collection('Items');

  static Future<bool> setItem(newItem) async {
    try {
      await FirebaseFirestore.instance.collection(itemCollection).doc().set(newItem);
      return true;
    } on FirebaseException {
      return false;
    }
  }

  static Future<bool> updateItem(updateItem, docId) async {
    try {
      await items.doc(docId).update(updateItem);
      return true;
    } on FirebaseException {
      return false;
    }
  }

  static Future<dynamic> deleteItem(docId) async {
    await items.doc(docId).delete();
  }
}
