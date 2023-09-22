import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'database/database.dart';
import 'page/exercise.dart';
import 'page/no_db_found_page.dart';
import 'util.dart';

void main() {
  runApp(const WologApp());
}

class WologApp extends StatelessWidget {
  const WologApp({super.key});

  @override
  Widget build(final BuildContext context) => 
    MaterialApp(
      title: 'wolog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const InitialPage(),
    );
}

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<StatefulWidget> createState() => _InitialPageState();
}

class _InitialPageState extends State<StatefulWidget> {
  @override
  void initState() {
    super.initState();
    getDatabaseFilePath().then((final dbFilePath) {
      databaseExists(dbFilePath).then((final dbExists) {
        WidgetsBinding.instance.addPostFrameCallback(
          dbExists ? 
            (final _) =>
              pushExercisePage(
                context,
                onErrorHook: () => showAppBlockingDialog(
                  context,
                  'Corrupted database',
                  'Data is cleared, restart app to setup')) :
            (final _) => 
              Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (final context) => const NoDbFoundPage())));
      });
    });
  }

  @override
  Widget build(final BuildContext context) =>
    const Scaffold();
}