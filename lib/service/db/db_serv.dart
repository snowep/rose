// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rose_project/service/db/data_class.dart';

CollectionReference db_user = FirebaseFirestore.instance.collection('users');

class Database {
  static Stream<QuerySnapshot> getUserData(String name) {
    if (name == "") {
      return db_user.snapshots();
    } else {
      return db_user
          .orderBy("firstName")
          .startAt([name]).endAt(['$name\uf8ff']).snapshots();
    }
  }

  static Future<void> registerUser({required UserObject item}) async {
    DocumentReference docRef = db_user.doc();

    await docRef
        .set(item.toJson())
        .whenComplete(() => print('Success'))
        .catchError((e) => print(e));
  }
}
