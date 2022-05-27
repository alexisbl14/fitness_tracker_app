import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PreviousWorkoutsPage extends StatefulWidget {
  const PreviousWorkoutsPage({Key? key}) : super(key: key);

  @override
  State<PreviousWorkoutsPage> createState() => _PreviousWorkoutsPageState();
}

class _PreviousWorkoutsPageState extends State<PreviousWorkoutsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text("Previous Workouts",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            backgroundColor: Colors.white,
          ),
          body: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [Center(child: const Text("previous workouts here"))],
          )),
    );
  }
}
