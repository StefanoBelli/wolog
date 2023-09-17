import 'package:flutter/material.dart';
import '../dbholder.dart';
import '../database/database.dart';
import 'dart:io';

import '../util.dart';

Future<void> _corruptedDatabaseHandler(
  final void Function()? postHook, final BuildContext c, final Object e, final StackTrace s) async {

  File(await getDatabaseFilePath()).deleteSync();

  if(c.mounted) {
    showExceptionDialog(c, e, s);
  }

  if(postHook != null) {
    postHook();
  }
}

void pushExercisePage(final BuildContext context, {final void Function()? onErrorHook}) {
  getDatabase().then((final dbInst) {
      dbInst.rawQuery('SELECT magic FROM WologMagic WHERE magic = 789456123;').then((final m) {
        if(m.length == 1) {
          DbHolder.getInstance()?.database = dbInst;
          Navigator.of(context).popUntil((final route) => route.isFirst);

          Navigator.pushReplacement(context,
            MaterialPageRoute(
                builder: (final ctx) => const ExercisePage()));
        } else {
          try {
            throw Exception('database does not contain a valid wolog magic number');
          } on Exception catch(e, st) {
            closeDatabase(dbInst);  // valid and opened db
            _corruptedDatabaseHandler(onErrorHook, context, e, st);
          }
        }
      }, onError: (final de, final st) {
        closeDatabase(dbInst);  // valid and opened db
        _corruptedDatabaseHandler(onErrorHook, context, de, st);
      });
    },
    onError: (final de, final st) {
      _corruptedDatabaseHandler(onErrorHook, context, de, st);
    }
  );
}

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(final BuildContext context) => 
    const Scaffold(body: Center(child: Text('EXERCISE')),);
}