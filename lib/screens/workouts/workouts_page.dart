import 'package:flutter/material.dart';

class WorkoutsPage extends StatefulWidget {
  final int data;
  const WorkoutsPage({Key? key, required this.data}) : super(key: key);

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState(data);
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  int data = 0;

  _WorkoutsPageState(this.data);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(data.toString()),
        ),
      ),
    );
  }
}
