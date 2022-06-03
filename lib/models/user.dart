import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {

  int workoutsCompleted;
  int workoutsIP;
  int timeSpent;

  UserData({
    required this.workoutsCompleted,
    required this.workoutsIP,
    required this.timeSpent
    }
  );

  factory UserData.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UserData(
      workoutsCompleted: data?['workoutsCompleted'],
      workoutsIP: data?['workoutsIP'],
      timeSpent: data?['timeSpent']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'workoutsCompleted': workoutsCompleted,
      'workoutsIP': workoutsIP,
      'timeSpent': timeSpent
    };
  }

  Map<String, dynamic> toJson() => {
    'workoutsCompleted': workoutsCompleted,
    'workoutsIP': workoutsIP,
    'timeSpent': timeSpent
  };

  UserData.fromSnapshot(snapshot)
    : workoutsCompleted = snapshot.data()['workoutsCompleted'],
      workoutsIP = snapshot.data()['workoutsIP'],
      timeSpent = snapshot.data()['timeSpent'];

}