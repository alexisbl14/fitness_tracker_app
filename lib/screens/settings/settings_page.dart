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
                  CupertinoButton(
                    child: Text("LOG OUT"),
                    onPressed: () async {
                      await FBAuthentication.signOut(context: context);
                    },
                    color: const Color.fromARGB(255, 231, 141, 247),
                  )
                ],
              )),
        ),
      );
    }
  }
}
