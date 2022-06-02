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

//   // create new document for user with ID
//
//   // final start = Timestamp(DateTime.now().millisecondsSinceEpoch, 0);
//   // final end = Timestamp(DateTime.now().millisecondsSinceEpoch, 0);
//   // final date = Timestamp(DateTime.now().millisecondsSinceEpoch, 0);
//
//   await DatabaseService(uid: credential?.idToken).updateUserData(0, 0, 0);
