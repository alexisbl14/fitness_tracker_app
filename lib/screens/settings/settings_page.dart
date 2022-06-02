import 'package:fitness_tracker_app/screens/home/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
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
                await SignInPage.signOut(context: context);
              },
              color: const Color.fromARGB(255, 231, 141, 247),
            )
          ],
        )),
      ),
    );
  }
}
