import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateNewExercisePage extends StatefulWidget {
  const CreateNewExercisePage({Key? key}) : super(key: key);

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
          title: Text("New Exercise"),
          centerTitle: true,
          backgroundColor: Colors.lightBlue,
        ),
        body: Column(
          children: [
            TextField(
              controller: _exerciseNameController,
            ),
            TextField(
              controller: _weightController,
            ),
            Row(
              children: [
                TextField(
                  controller: _setsController,
                ),
                Text(" x "),
                TextField(
                  controller: _repsController,
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {}, label: const Text("Create Exercise")),
      ),
    );
  }
}
