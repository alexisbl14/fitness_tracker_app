import 'package:fitness_tracker_app/screens/page/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitness_tracker_app/screens/page/tab_bar_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FitnessTracker',
        theme: ThemeData(
          textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.black)),
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const SignInScreen(),
    );
  }
}
