import 'package:flutter/material.dart';
import 'package:wolog/dbholder.dart';
import 'package:wolog/database/database.dart';
import 'dart:io';

import 'package:wolog/util.dart';

void _corruptedDatabaseHandler(
    void Function()? postHook, BuildContext c, Exception e, StackTrace s) async {
  File(await getDatabaseFilePath()).deleteSync();

  if(c.mounted) {
    showExceptionDialog(c, e, s);
  }

  if(postHook != null) {
    postHook();
  }
}

void pushExercisePage(BuildContext context, {void Function()? onErrorHook}) {
  getDatabase().then((dbInst) {
      dbInst.rawQuery(
          "SELECT magic FROM WologMagic WHERE magic = 789456123;").then((m) {
        if(m.length == 1) {
          DbHolder.getInstance()?.database = dbInst;
          Navigator.of(context).popUntil((route) => route.isFirst);

          Navigator.pushReplacement(context,
            MaterialPageRoute(
                builder: (BuildContext ctx) => const ExercisePage()));
        } else {
          try {
            throw Exception("database does not contain a valid wolog magic number");
          } catch(e, st) {
            closeDatabase(dbInst);
            _corruptedDatabaseHandler(onErrorHook, context, e as Exception, st);
          }
        }
      }, onError: (de, st) {
        closeDatabase(dbInst);
        _corruptedDatabaseHandler(onErrorHook, context, de, st);
      });
    },
    onError: (de, st) {
      _corruptedDatabaseHandler(onErrorHook, context, de, st);
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