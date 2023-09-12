import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wolog/database/database.dart';
import 'package:wolog/page/exercise.dart';
import 'package:wolog/page/setup.dart';

void main() {
  runApp(const WologApp());
}

class WologApp extends StatelessWidget {
  const WologApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wolog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const InitialPage(),
    );
  }
}

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<StatefulWidget> createState() => _InitialPageState();
}

class _InitialPageState extends State<StatefulWidget> {
  bool _checkedDatabaseExistence = false;
  bool _databaseExists = false;

  @override
  void initState() {
    super.initState();
    getDatabaseFilePath().then((dbFilePath) {
      databaseExists(dbFilePath).then((dbExists) {
        setState(() {
          _checkedDatabaseExistence = true;
          _databaseExists = dbExists;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_checkedDatabaseExistence) {
      if(_databaseExists) {
        pushExerciseOverview(context);
      } else {
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SetupPage()));
      }
    }

    return const Scaffold();
  }
}