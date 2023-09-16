import 'package:flutter/material.dart';
import 'package:wolog/dbholder.dart';
import 'package:wolog/database/database.dart';
import 'dart:io';

void pushExercisePage(
    BuildContext context, {void Function()? onErrorHook}) {

  getDatabase().then((dbInst) {
      DbHolder.getInstance()?.database = dbInst;
      Navigator.of(context).popUntil((route) => route.isFirst);

      Navigator.pushReplacement(context,
          MaterialPageRoute(
              builder: (BuildContext ctx) => const ExercisePage()));
    },
    onError: (de, st) async {
      File(await getDatabaseFilePath()).deleteSync();
      //showExceptionDialog
      if(onErrorHook != null) {
        onErrorHook();
      }
    }
  );
}

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("EXERCISE")),);
  }
}