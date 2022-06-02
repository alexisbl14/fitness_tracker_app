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
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text("Previous Workouts",
                style: TextStyle(fontWeight: FontWeight.w500)),
            backgroundColor: Color.fromARGB(255, 123, 192, 224),
          ),
          body: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [Center(child: const Text("previous workouts here"))],
          )),
    );
  }
}
