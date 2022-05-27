import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:fitness_tracker_app/models/exercise.dart';
import 'package:fitness_tracker_app/screens/workouts/create_exercise_page.dart';

class WorkoutsPage extends StatefulWidget {
  final int data;
  const WorkoutsPage({Key? key, required this.data}) : super(key: key);

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState(data);
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  int data = 0;
  String formattedDate = DateFormat.yMMMEd().format(DateTime.now());

  bool startWorkoutVisible = true;
  bool finishWorkoutVisible = false;

  final List<Exercise> _exercises = [
    Exercise(exercise: "bench", weight: 80, sets: 5, reps: 5),
    Exercise(exercise: "squat", weight: 115, sets: 5, reps: 5),
    Exercise(exercise: "lunges", weight: 45, sets: 3, reps: 10),
    Exercise(exercise: "bench", weight: 80, sets: 5, reps: 5),
    Exercise(exercise: "squat", weight: 115, sets: 5, reps: 5),
    Exercise(exercise: "lunges", weight: 45, sets: 3, reps: 10),
    Exercise(exercise: "bench", weight: 80, sets: 5, reps: 5),
    Exercise(exercise: "squat", weight: 115, sets: 5, reps: 5),
    Exercise(exercise: "lunges", weight: 45, sets: 3, reps: 10),
    Exercise(exercise: "bench", weight: 80, sets: 5, reps: 5),
    Exercise(exercise: "squat", weight: 115, sets: 5, reps: 5),
    Exercise(exercise: "lunges", weight: 45, sets: 3, reps: 10),
    Exercise(exercise: "bench", weight: 80, sets: 5, reps: 5),
    Exercise(exercise: "squat", weight: 115, sets: 5, reps: 5),
    Exercise(exercise: "lunges", weight: 45, sets: 3, reps: 10),
    Exercise(exercise: "bench", weight: 80, sets: 5, reps: 5),
    Exercise(exercise: "squat", weight: 115, sets: 5, reps: 5),
    Exercise(exercise: "lunges", weight: 45, sets: 3, reps: 10),
  ];

  _WorkoutsPageState(this.data);

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
                    color: Colors.lightBlue,
                    child: const Text("Start Workout"),
                    onPressed: () => setState(() {
                      startWorkoutVisible = false;
                      finishWorkoutVisible = true;
                    }),
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
                            itemBuilder: ((context, index) =>
                                _buildItem(_exercises[index]))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CupertinoButton(
                              color: const Color.fromARGB(255, 231, 141, 247),
                              child: const Text("Finish Workout"),
                              onPressed: () => setState(() {
                                finishWorkoutVisible = false;
                                startWorkoutVisible = true;
                              }),
                            ),
                            CupertinoButton(
                              child: Icon(CupertinoIcons.add),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            CreateNewExercisePage()));
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

  /*String getDate() {
    final now = DateTime.now();
    int weekday = now.weekday;
    int day = now.day;
    int month = now.month;
    int year = now.year;
    String weekdayString;
    String monthString;
    switch (weekday) {
      case 1:
        weekdayString = "Monday";
        break;
      case 2:
        weekdayString = "Tuesday";
        break;
      case 3:
        weekdayString = "Wednesday";
        break;
      case 4:
        weekdayString = "Thursday";
        break;
      case 5:
        weekdayString = "Friday";
        break;
      case 6:
        weekdayString = "Saturday";
        break;
      case 7:
        weekdayString = "Sunday";
        break;
      default:
    }
    switch (month) {
      case 1:
        monthString = "January";
        break;
      case 2:
        monthString = "February";
        break;
      case 3:
        monthString = "March";
        break;
      case 4:
        monthString = "April";
        break;
      case 5:
        monthString = "May";
        break;
      case 6:
        monthString = "June";
        break;
      case 7:
        monthString = "July";
        break;
      case 8:
        monthString = "August";
        break;
      case 9:
        monthString = "September";
        break;
      case 10:
        monthString = "October";
        break;
      default:
    }
  }*/
}
