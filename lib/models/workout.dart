import 'package:fitness_tracker_app/models/exercise.dart';

class Workout {
  DateTime startTime;
  DateTime endTime;
  String date;
  List<Exercise> exercises;

  Workout(
      {required this.startTime,
      required this.endTime,
      required this.date,
      required this.exercises});
}
