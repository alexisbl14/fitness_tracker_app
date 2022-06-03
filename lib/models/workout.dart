import 'package:fitness_tracker_app/models/exercise.dart';

class Workout {
  DateTime startTime;
  DateTime endTime;
  DateTime date;
  List<Map<String, dynamic>> exercises;

  Workout(
      {
        required this.startTime,
        required this.endTime,
        required this.date,
        required this.exercises
      });

  Workout.fromSnapshot(snapshot)
      : startTime = snapshot.data()['startTime'],
        endTime = snapshot.data()['endTime'],
        date = snapshot.data()['date'],
        exercises = snapshot.data()['exercises'];
}
