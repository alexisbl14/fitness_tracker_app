
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_tracker_app/services/FBAuthentication.dart';
import 'package:flutter/cupertino.dart';

import '../models/user.dart';
import '../models/workout.dart';

// https://www.youtube.com/watch?v=mtNA1neFNVo
class DatabaseService {


  final String uid;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('userData');

  DatabaseService({required this.uid});

  Future updateUserData(int workoutsCompleted, int workoutsIP, int timeSpent) async {

    // create workouts subcollection if it does not already exist
    FirebaseFirestore.instance.collection('userData').doc(uid).collection('workouts');

    // default population of new user data
    return await userCollection.doc(uid).set({
      'workoutsCompleted': workoutsCompleted,
      'workoutsIP': workoutsIP,
      'timeSpent': timeSpent,
    });
  }

  Future addWorkoutData(Workout workout) async {
    var list = workout.exercises;

    return await userCollection.doc(uid).collection('workouts').add({
      'startTime': workout.startTime,
      'endTime': workout.endTime,
      'date': workout.date,
      'exercises': list,
    });
  }

  Future<List<dynamic>> getPrevworkouts() async {

    List<dynamic> send = [];

    final uid = FBAuthentication().currentUser!.uid;
    final ref = FirebaseFirestore.instance.collection("userData").doc(uid).collection('workouts').orderBy('startTime', descending: true);
    QuerySnapshot snapshot = await ref.get();

    final alldata = snapshot.docs.map((doc) => doc.data()).toList();
    
    return alldata;
  }

  Future<UserData?> getUserStats()  async {
    final uid = FBAuthentication().currentUser!.uid;
    final ref = FirebaseFirestore.instance.collection("userData").doc(uid).withConverter(
      fromFirestore: UserData.fromFirestore,
      toFirestore: (UserData userData, _) => userData.toFirestore(),
    );
    final docSnap = await ref.get();
    final userData = docSnap.data();

    return userData;
  }

  Stream<QuerySnapshot> get userData {
    return userCollection.snapshots();
  }


}

