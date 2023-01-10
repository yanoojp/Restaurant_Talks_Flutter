import 'package:cloud_firestore/cloud_firestore.dart';
import '../../fixedDatas/variables.dart';
import '../../model/item.dart';

class ItemFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference items = _firestoreInstance.collection('Items');

  static Future<bool> setItem(newItem) async{
    try {
      FirebaseFirestore.instance
          .collection(itemCollection)
          .doc()
          .set(newItem);
      return true;
    } on FirebaseException catch(e) {
      return false;
    }
  }

  static Future<bool> updateItem(updateItem, docId) async{
    try {
      await items.doc(docId).update(updateItem);
      return true;
    } on FirebaseException catch(e) {
      return false;
    }
  }

  static Future<dynamic> deleteItem(docId) async{
    items.doc(docId).delete();
  }
}