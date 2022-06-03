import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_tracker_app/screens/page/sign_in_screen.dart';
import 'package:fitness_tracker_app/services/FBAuthentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  User? _user;

  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInScreen();
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title:
                Text("Settings", style: TextStyle(fontWeight: FontWeight.w500)),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 123, 192, 224),
          ),
          body: Center(
              child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                child: Text(
                  "Your Profile",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 20, 5, 2),
                child: Image.network(
                    _user?.photoURL ??
                        "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.seekpng.com%2Fipng%2Fu2q8r5t4i1y3w7e6_existing-user-default-avatar%2F&psig=AOvVaw1qKVWKR3cYfS4YI6qAXlXw&ust=1654325030518000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCOCv1ZHXkPgCFQAAAAAdAAAAABAI",
                    scale: 0.5),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _user?.displayName ?? "",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              Text(_user?.email ?? ""),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 75, 5, 2),
                child: CupertinoButton(
                    onPressed: () async {
                      await FBAuthentication.signOut(context: context);
                    },
                    color: const Color.fromARGB(255, 231, 141, 247),
                    child: const Text(
                      "Sign Out",
                    )),
              )
            ],
          )),
        ),
      );
    }
  }
}
