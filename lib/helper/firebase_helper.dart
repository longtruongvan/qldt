import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  static void getDataRealTime({
    required String collection,
    required String doc,
  }) {
    FirebaseFirestore.instance
        .collection(collection)
        .doc(doc)
        .snapshots()
        .listen((data) {
      if (data.data() != null) {
      } else {}
    }).onError((error) {});
  }

  static void getData({
    required String collection,
    required String doc,
  }) {
    FirebaseFirestore.instance
        .collection(collection)
        .doc(doc)
        .get()
        .then((value) {
      if (value.data() != null) {}
    }).catchError((onError) {});
  }

  static void addData(
      {required String collection,
      required String doc,
      required Map<String, dynamic> obj}) {
    FirebaseFirestore.instance
        .collection(collection)
        .doc(doc)
        .set(obj)
        .then((value) {})
        .catchError((onError) {});
  }

  static void updateData(
      {required String collection,
      required String doc,
      required Map<String, dynamic> obj}) {
    FirebaseFirestore.instance
        .collection(collection)
        .doc(doc)
        .update(obj)
        .then((value) {})
        .catchError((onError) {});
  }

  static void deleteData({required String collection, required String doc}) {
    FirebaseFirestore.instance
        .collection(collection)
        .doc(doc)
        .delete()
        .then((value) {})
        .catchError((onError) {});
  }
}
