import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wolog/database/database.dart';
import 'package:wolog/dbholder.dart';
import 'package:wolog/page/exercise.dart';

void pushExerciseOverview(BuildContext context) {
  getDatabase().then((dbInst) {
    DbHolder.getInstance()?.database = dbInst;
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (BuildContext ctx) => const ExercisePage()));
  });
}

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
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _showNonBarrierDismissibleDialog(context, _buildFreshInstallDialog)
        );
      }
    }

    return const Scaffold();
  }
}

typedef _AlertDialogBuilderFunction = AlertDialog Function(BuildContext);
typedef _AlertDialogOptFunction = void Function(BuildContext);

AlertDialog _buildInitialSetupDialog(
  BuildContext context, String title, String brief, String firstOptBrief, String secondOptBrief, 
  _AlertDialogOptFunction firstOptFun, _AlertDialogOptFunction secondOptFun)
  => AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(brief),
          TextButton(
            child: Text(firstOptBrief),
            onPressed: () { firstOptFun(context); },
          ),
          TextButton(
            child: Text(secondOptBrief),
            onPressed: () { secondOptFun(context); },
          ),
        ],
      )
    );

void _showNonBarrierDismissibleDialog(BuildContext context, _AlertDialogBuilderFunction dialogBuilder) {
  showDialog(
    barrierDismissible: false, 
    context: context, builder: 
    (_) => dialogBuilder(context)
  );
}

AlertDialog _buildFreshInstallDialog(BuildContext context) 
  => _buildInitialSetupDialog(
      context, 
      "No database found", 
      "It looks like this is a fresh install", 
      "Create new database...", 
      "Import existing database...", 
      (context) { 
        Navigator.pop(context);
        _showNonBarrierDismissibleDialog(context, _buildCreateNewDatabaseDialog); 
      }, 
      (context) { }
    );

AlertDialog _buildCreateNewDatabaseDialog(BuildContext context)
  => _buildInitialSetupDialog(
      context, 
      "Create new database", 
      "Once the app creates it...", 
      "Populate with preset data", 
      "Leave it empty", 
      (context) { }, 
      (context) { 
        Navigator.pop(context);
        _showNonBarrierDismissibleDialog(context, _buildNewEmptyDatabaseDialog);
      }
    );

AlertDialog _buildNewEmptyDatabaseDialog(BuildContext context)
  => _buildInitialSetupDialog(
      context, 
      "New empty database", 
      "In addition, the app must...", 
      "Get the default icon pack", 
      "Not do anything else", 
      (context) { }, 
      (context) { 
        Navigator.pop(context);
        pushExerciseOverview(context);
      }
    );