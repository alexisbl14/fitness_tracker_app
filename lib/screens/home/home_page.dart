import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_tracker_app/services/FBAuthentication.dart';
import 'package:fitness_tracker_app/screens/page/sign_in_screen.dart';
import 'package:fitness_tracker_app/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitness_tracker_app/screens/home/previous_workouts_page.dart';
import '../../models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  _HomePageState();
  @override
  Widget build(BuildContext context) {

    // if user not signed in, send to launch screen
    if (_user == null) {
      return const SignInScreen();
    }
    // otherwise, show homepage
    else {
      // header
      return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Welcome, ${_user?.displayName}!",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Let's see how you're doing:",
                      style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(height: 85),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [_completedWorkouts(), _workoutInfo()],
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: CupertinoButton(
                      color: const Color.fromARGB(255, 231, 141, 247),
                      onPressed: (() {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => PreviousWorkoutsPage()));
                      }),
                      child: const Text("Previous Workouts",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  // widget pulling stats from firestore to display workout stats
  Widget _completedWorkouts()  {
    final screenWidth = MediaQuery.of(context).size.width;

    // futurebuilder to use async within sync widget
    return FutureBuilder(
      future:  DatabaseService(uid: FBAuthentication().currentUser!.uid).getUserStats(),
      builder: (BuildContext context, snapshot) {

        // if snapshot has returned
        if (snapshot.hasData) {

          // if waiting, show circular wait symbol
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // otherwise, populate data
          else {

            // convert snapshot to UserData object
            UserData data = snapshot.data as UserData;

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
                children: [
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      "Finished",
                      style: TextStyle(fontSize: 18),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ),
                  Text(data.workoutsCompleted.toString(),
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w600)),
                  const Text("Completed Workouts",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey))
                ],
              ),
            );
          }
        }
        // If snapshot doing anything it shouldn't, show loader
        else if (snapshot.hasError) {
          return const CircularProgressIndicator();
        }
        else if (!snapshot.hasData){
          return const CircularProgressIndicator();
        }
        else {
          return const CircularProgressIndicator();
        }
      },
    );

  }

  Widget _inProgressInfo()  {
    final screenWidth = MediaQuery.of(context).size.width;

    // futurebuilder to use async within sync widget
    return FutureBuilder(
      future:  DatabaseService(uid: FBAuthentication().currentUser!.uid).getUserStats(),
      builder: (BuildContext context, snapshot) {

        // if snapshot has returned
        if (snapshot.hasData) {
          // if waiting, show circular wait symbol
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("waiting..."),
            );
          }
          // otherwise, populate data
          else {

            UserData data = snapshot.data as UserData;

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
                  const Text(
                    "In Progress",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        data.workoutsIP.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
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
        }
        else if (snapshot.hasError) {
          return const CircularProgressIndicator();
        }
        else if (!snapshot.hasData){
          return const CircularProgressIndicator();
        }
        else {
          return const CircularProgressIndicator();
        }
      },
    );


  }

  Widget _timeSpentInfo()  {
    final screenWidth = MediaQuery.of(context).size.width;

    // futurebuilder to use async within sync widget
    return FutureBuilder(
      future:  DatabaseService(uid: FBAuthentication().currentUser!.uid).getUserStats(),
      builder: (BuildContext context, snapshot) {

        // if snapshot has returned
        if (snapshot.hasData) {
          // if waiting, show circular wait symbol
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("waiting..."),
            );
          }
          // else populate data
          else {

            UserData data = snapshot.data as UserData;

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
                  const Text(
                    "Time Spent",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        data.timeSpent.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
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
        }
        else if (snapshot.hasError) {
          return const CircularProgressIndicator();
        }
        else if (!snapshot.hasData){
          return const CircularProgressIndicator();
        }
        else {
          return const CircularProgressIndicator();
        }
      },
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
