import 'package:cloud_firestore/cloud_firestore.dart';

class ModelActivity {
  static CollectionReference _activity =
      FirebaseFirestore.instance.collection("activities");

  static Future<void> addActivity(Map<String, dynamic> map) {
    map.remove("id");
    return _activity.add(map).then((value) {
      print("berhasil add activity");
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

  static Future<List<QueryDocumentSnapshot>> getAllActivities(
      List<String> plansId) async {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime tommorow = DateTime(now.year, now.month, now.day + 1);
    QuerySnapshot querySnapshot = await _activity
        .where('planId', whereIn: plansId)
        .where('time', isGreaterThanOrEqualTo: today)
        .where('time', isLessThan: tommorow)
        .get();
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
