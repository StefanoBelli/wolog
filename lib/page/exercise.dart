import 'package:flutter/material.dart';
import 'package:wolog/dbholder.dart';
import 'package:wolog/database/database.dart';

void pushExerciseOverview(BuildContext context) {
  getDatabase().then((dbInst) {
    DbHolder.getInstance()?.database = dbInst;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext ctx) => const ExercisePage()));
  });
}

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("EXERCISE")),);
  }
}