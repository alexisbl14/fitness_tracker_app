class Exercise {
  String exercise;
  int weight;
  int sets;
  int reps;

  Exercise(
      {
        required this.exercise,
        required this.weight,
        required this.sets,
        required this.reps
      }
    );

  Map<String, dynamic> toMap() => {
    'exercise': exercise,
    'weight': weight,
    'sets': sets,
    'reps': reps
  };


}
