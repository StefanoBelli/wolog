import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wolog/database/database.dart';

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
      home: const InitialWidget(),
    );
  }
}

class InitialWidget extends StatefulWidget {
  const InitialWidget({super.key});

  @override
  State<StatefulWidget> createState() => _InitialWidgetState();
}

class _InitialWidgetState extends State<StatefulWidget> {
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
        //Navigator.push
      } else {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => showNonBarrierDismissibleDialog(context, buildFreshInstallDialog)
        );
      }
    }

    return const Scaffold();
  }
}

typedef AlertDialogBuilderFunction = AlertDialog Function(BuildContext);

void showNonBarrierDismissibleDialog(BuildContext context, AlertDialogBuilderFunction dialogBuilder) {
  showDialog(
    barrierDismissible: false, 
    context: context, builder: 
    (_) => dialogBuilder(context)
  );
}

AlertDialog buildFreshInstallDialog(BuildContext context) 
  => AlertDialog(
      title: const Text("No database found"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("It looks like this is a fresh install"),
          TextButton(
            child: const Text("Create new database..."),
            onPressed: () {},
          ),
          TextButton(
            child: const Text("Import existing database..."),
            onPressed: () {},
          ),
        ],
      )
    );
