// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final data;
  const HomePage({Key? key, this.data}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState(data);
}

class _HomePageState extends State<HomePage> {
  int data;
  _HomePageState(this.data);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                "Welcome, Alexis!",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text("Let's see how you're doing:",
                  style: TextStyle(fontSize: 20)),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_completedWorkouts(), _workoutInfo()],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _completedWorkouts() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(15),
      height: 200,
      width: screenWidth * .35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 5.0,
            spreadRadius: 1.1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Finished",
              style: TextStyle(fontSize: 18),
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
          ),
          Text("1",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.w600)),
          Text("Completed Workouts",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey))
        ],
      ),
    );
  }

  Widget _inProgressInfo() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 90,
      width: screenWidth * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 5.0,
            spreadRadius: 1.1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "In Progress",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              Text(
                "1",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "Workouts",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _timeSpentInfo() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      height: 90,
      width: screenWidth * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 5.0,
            spreadRadius: 1.1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Time Spent",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                "22",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "Minutes",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _workoutInfo() {
    return Column(
      children: [
        _inProgressInfo(),
        const SizedBox(height: 20),
        _timeSpentInfo(),
      ],
    );
  }
}
