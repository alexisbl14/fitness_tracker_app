import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutLogoWidget extends StatelessWidget {
  const WorkoutLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(image: AssetImage("assets/workout_logo.png"), height: 200)
          ],
        ));
  }
}
