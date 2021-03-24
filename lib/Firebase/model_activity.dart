import 'package:cloud_firestore/cloud_firestore.dart';

class ModelActivity {
  static CollectionReference _activity =
      FirebaseFirestore.instance.collection("activities");

  static Future<void> addActivity(Map<String, dynamic> map) {
    map.remove("id");
    return _activity.add(map).then((value) {
      print("berhasil");
    }).catchError((error) {
      print(error);
    });
  }

  static Future<List<QueryDocumentSnapshot>> getActivities(planId) async {
    QuerySnapshot querySnapshot =
        await _activity.where('planId', isEqualTo: planId).get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    return docs;
  }

  static Future<void> deleteActivity(String id) {
    return _activity
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
