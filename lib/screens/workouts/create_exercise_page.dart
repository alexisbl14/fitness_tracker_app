import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateNewExercisePage extends StatefulWidget {
  const CreateNewExercisePage({Key? key}) : super(key: key);

  @override
  State<CreateNewExercisePage> createState() => _CreateNewExercisePageState();
}

class _CreateNewExercisePageState extends State<CreateNewExercisePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("New Exercise"),
            centerTitle: true,
          ),
          body: Text("Create New Workout Page")),
    );
  }
}
