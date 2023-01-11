import 'package:cloud_firestore/cloud_firestore.dart';
import '../../fixedDatas/variables.dart';

class ItemFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference items =
      _firestoreInstance.collection('Items');

  static Future<bool> setItem(Map<String, dynamic> newItem) async {
    try {
      await FirebaseFirestore.instance.collection(itemCollection).doc().set(newItem);
      return true;
    } on FirebaseException {
      return false;
    }
  }

  static Future<bool> updateItem(Map<String, Object?> updateItem, String docId) async {
    try {
      await items.doc(docId).update(updateItem);
      return true;
    } on FirebaseException {
      return false;
    }
  }

  static Future<dynamic> deleteItem(String docId) async {
    await items.doc(docId).delete();
  }

  static Stream<QuerySnapshot<Object?>>? getItem(accountId, selectedCategoryValue) {
    try {
      if (selectedCategoryValue == sortByCategoryLabel) {
        return items.where('accountId', isEqualTo: accountId).orderBy('updatedAt').snapshots();
      } else if (selectedCategoryValue == appetizerLabel) {
        return items.where('accountId', isEqualTo: accountId).where('category', isEqualTo: appetizerLabel).orderBy('updatedAt').snapshots();
      } else if (selectedCategoryValue == mainDishLabel) {
        return items.where('accountId', isEqualTo: accountId).where('category', isEqualTo: mainDishLabel).orderBy('updatedAt').snapshots();
      } else if (selectedCategoryValue == beverageLabel) {
        return items.where('accountId', isEqualTo: accountId).where('category', isEqualTo: beverageLabel).orderBy('updatedAt').snapshots();
      }
    } on FirebaseException catch(e) {
      return null;
    }
  }
}
