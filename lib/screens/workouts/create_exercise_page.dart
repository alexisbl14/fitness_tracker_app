import 'dart:math';

import 'package:fitness_tracker_app/models/exercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void OnCreateExerciseCallback(Exercise exercise);

class CreateNewExercisePage extends StatefulWidget {
  final OnCreateExerciseCallback onCreateExercise;
  const CreateNewExercisePage({Key? key, required this.onCreateExercise})
      : super(key: key);

  @override
  State<CreateNewExercisePage> createState() => _CreateNewExercisePageState();
}

class _CreateNewExercisePageState extends State<CreateNewExercisePage> {
  final _exerciseNameController = TextEditingController();
  final _weightController = TextEditingController();
  final _setsController = TextEditingController();
  final _repsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("New Exercise",
              style: TextStyle(fontWeight: FontWeight.w500)),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 123, 192, 224),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: _exerciseNameController,
                  style: const TextStyle(fontSize: 16.0),
                  decoration: const InputDecoration(hintText: "Exercise Name")),
              TextField(
                controller: _weightController,
                style: const TextStyle(fontSize: 16.0),
                decoration: const InputDecoration(hintText: "Weight"),
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .25,
                    child: TextField(
                      controller: _setsController,
                      style: const TextStyle(fontSize: 16.0),
                      decoration: const InputDecoration(hintText: "Sets"),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
                    child: Text(" x ", style: TextStyle(fontSize: 16.0)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .25,
                    child: TextField(
                      controller: _repsController,
                      style: const TextStyle(fontSize: 16.0),
                      decoration: const InputDecoration(hintText: "Reps"),
                      keyboardType: TextInputType.number,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16),
          child: FloatingActionButton.extended(
            onPressed: () {
              widget.onCreateExercise(Exercise(
                  exercise: _exerciseNameController.text,
                  weight: int.parse(_weightController.text),
                  sets: int.parse(_setsController.text),
                  reps: int.parse(_repsController.text)));
              Navigator.pop(context);
            },
            label: const Text("Create Exercise"),
            backgroundColor: Color.fromARGB(255, 123, 192, 224),
          ),
        ),
      ),
    );
  }
}

/**  */
