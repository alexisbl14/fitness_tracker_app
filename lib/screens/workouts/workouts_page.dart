import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_tracker_app/models/user.dart';
import 'package:fitness_tracker_app/models/workout.dart';
import 'package:fitness_tracker_app/services/FBAuthentication.dart';
import 'package:fitness_tracker_app/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fitness_tracker_app/models/exercise.dart';
import 'package:fitness_tracker_app/screens/workouts/create_exercise_page.dart';

class WorkoutsPage extends StatefulWidget {
  //final int data;
  const WorkoutsPage({Key? key}) : super(key: key);

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {

  int data = 0;
  String formattedDate = DateFormat.yMMMEd().format(DateTime.now());
  bool startWorkoutVisible = true;
  bool finishWorkoutVisible = false;
  User? _user;
  List<Map<String, dynamic>> _exercises = [];
  Workout workout = Workout(startTime: DateTime.now(), endTime: DateTime.now(), date: DateTime.now(), exercises: [{}]);

  _WorkoutsPageState();

  ValueNotifier<UserData> homeStats = ValueNotifier(UserData(workoutsCompleted: 0, workoutsIP: 0, timeSpent: 0));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text(
                "Workouts",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              Visibility(
                visible: startWorkoutVisible,
                child: Center(
                  child: CupertinoButton(
                    color: const Color.fromARGB(255, 123, 192, 224),
                    child: const Text("Start Workout"),
                    onPressed: () {
                      setState(() {
                        startWorkoutVisible = false;
                        finishWorkoutVisible = true;
                        workout.startTime = DateTime.now();
                      });
                    }
                  ),
                ),
              ),
              Visibility(
                visible: finishWorkoutVisible,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .6,
                      child: Scrollbar(
                        child: ListView.builder(
                            itemCount: _exercises.length,
                            itemBuilder: (context, index) {
                              var item = Exercise(exercise: _exercises[index]['exercise'], weight: _exercises[index]['weight'], sets: _exercises[index]['sets'], reps: _exercises[index]['reps']);
                              return _buildItem(item);
                            }

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * .03),
                            CupertinoButton(
                              color: const Color.fromARGB(255, 231, 141, 247),
                              child: const Text("Finish Workout"),

                              // button setup
                              onPressed: () async {

                                setState(() {
                                  finishWorkoutVisible = false;
                                  startWorkoutVisible = true;
                                });

                                _user = FBAuthentication().currentUser;
                                workout.endTime = DateTime.now();
                                workout.exercises = _exercises;
                                await DatabaseService(uid: _user!.uid).addWorkoutData(workout);

                                UserData stats = await DatabaseService(uid: _user!.uid).getUserStats() as UserData;

                                stats.workoutsCompleted = stats.workoutsCompleted + 1;
                                var timeSpent = (workout.endTime.millisecondsSinceEpoch - workout.startTime.millisecondsSinceEpoch) ~/ 1000;
                                timeSpent = timeSpent ~/ 60;
                                stats.timeSpent += timeSpent;
                                await DatabaseService(uid: _user!.uid).updateStats(stats.workoutsCompleted, stats.workoutsIP, stats.timeSpent);
                                homeStats.value = stats;

                                setState(() {
                                  _exercises = [];
                                });
                              }
                            ),
                            CupertinoButton(
                              child: const Icon(CupertinoIcons.add),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CreateNewExercisePage(
                                              onCreateExercise: (exercise) {
                                                setState(() {
                                                  _exercises.add(exercise.toMap());
                                                });
                                              }
                                            )
                                    )
                                );
                              },
                            )
                          ]),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(Exercise exercise) {
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


}
