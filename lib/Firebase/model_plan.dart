import 'package:cloud_firestore/cloud_firestore.dart';

class ModelPlan {
  static CollectionReference _plans =
      FirebaseFirestore.instance.collection('plans');

  static Future<DocumentReference> addPlan(
      Map<String, dynamic> map, String uid) async {
    map.remove("id");
    map.addAll({"uid": uid});
    DocumentReference doc = await _plans.add(map);
    return doc;
  }

  static Future<List<QueryDocumentSnapshot>> getPlans(uid) async {
    QuerySnapshot querySnapshot =
        await _plans.where('uid', isEqualTo: uid).get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    return docs;
  }

  static Future<void> deletePlan(String id) async {
    return await _plans.doc(id).delete();
  }
}
