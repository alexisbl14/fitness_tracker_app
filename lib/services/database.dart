import 'package:cloud_firestore/cloud_firestore.dart';

// https://www.youtube.com/watch?v=mtNA1neFNVo
class DatabaseService {

  // collection reference

  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference activityCollection = FirebaseFirestore.instance.collection('activity');

  Future updateUserData(int workoutsCompleted, int workoutsIP, int timeSpent) async {
    return await activityCollection.doc(uid).set({
      'workoutsCompleted': workoutsCompleted,
      'workoutsIP': workoutsIP,
      'timeSpent': timeSpent

    });
  }


}