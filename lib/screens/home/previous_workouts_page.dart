import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_tracker_app/models/workout.dart';
import 'package:fitness_tracker_app/services/FBAuthentication.dart';
import 'package:fitness_tracker_app/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../../models/exercise.dart';

class PreviousWorkoutsPage extends StatefulWidget {
  const PreviousWorkoutsPage({Key? key}) : super(key: key);

  @override
  State<PreviousWorkoutsPage> createState() => _PreviousWorkoutsPageState();
}

class _PreviousWorkoutsPageState extends State<PreviousWorkoutsPage> {
  final User? _user = FBAuthentication().currentUser;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseService(uid: FBAuthentication().currentUser!.uid)
          .getPrevworkouts(),
      builder: (BuildContext context, snapshot) {

        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("waiting..."),
            );
          }
          else {
            // debugPrint(snapshot.data!.toString());
            List<dynamic> wList = snapshot.data as List<Object?>;
            List<Workout> workouts = [];

            // converts wList into list of workout objects
            for (var item in wList) {
              final objMap = item as Map;
              final Timestamp stt = objMap['startTime'];
              final Timestamp ett = objMap['endTime'];
              final Timestamp dtt = objMap['date'];
              final st = DateTime.fromMillisecondsSinceEpoch(
                  stt.seconds * 1000);
              final et = DateTime.fromMillisecondsSinceEpoch(
                  ett.seconds * 1000);
              final dt = DateTime.fromMillisecondsSinceEpoch(
                  dtt.seconds * 1000);
              List<Map<String, dynamic>> ex = [];
              for (var item in objMap['exercises'] as List<dynamic>) {
                ex.add(item);
              }
              final Workout temp = Workout(
                  startTime: st, endTime: et, date: dt, exercises: ex);
              workouts.add(temp);
              ex = [];
            }

            // final list of workouts
            debugPrint("Workout array size: ${workouts.length}");
            debugPrint("WORKOUTS IS: ${workouts.toString()}");


            return SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    iconTheme: const IconThemeData(color: Colors.white),
                    title: const Text("Previous Workouts",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    backgroundColor: Color.fromARGB(255, 123, 192, 224),
                  ),
                  body: Column(
                    children: [
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .85,
                        child: Scrollbar(
                          child: ListView.builder(
                              itemCount: workouts.length,
                              itemBuilder: (context, index) {
                                var item = Workout(
                                    startTime: workouts[index].startTime,
                                    endTime: workouts[index].endTime,
                                    date: workouts[index].date,
                                    exercises: workouts[index].exercises);
                                return _buildItem(item, context);
                              }

                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          }
        }
        else if (snapshot.hasError) {
          return const CircularProgressIndicator();
        }
        else if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        else {
          return const CircularProgressIndicator();
        }
      },);
    }

  }

  Widget _buildItem(Workout workout, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Date: ${workout.date.month}/${workout.date.day}/${workout.date.year}"),
            const SizedBox(height: 4),
            Text("Start: ${DateFormat("h:mma").format(workout.startTime)} "),
            const SizedBox(height: 4),
            Text("End: ${DateFormat("h:mma").format(workout.endTime)}"),
            const SizedBox(height: 4),

          ],
        ),
      ),
    );
  }

  Widget _buildEx(Exercise exercise) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Exercise: ${exercise.exercise}"),
            const SizedBox(height: 4),
            Text("Weight: ${exercise.weight.toString()}"),
            const SizedBox(height: 4),
            Text("Sets x Reps: ${exercise.sets} x ${exercise.reps}"),
          ],
        ),
      ),
    );
}
