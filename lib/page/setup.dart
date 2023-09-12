import 'package:flutter/material.dart';
import 'package:wolog/page/exercise.dart';
import 'dart:io';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<StatefulWidget> createState() => _SetupPageState();
}

enum _SetupPagePhase {
  noDbFound,
  createNewDb,
  importExistingDb,
  loadPreset
}

enum _SetupPageLoadResourceChoice {
  defaultHttpUrl,
  customHttpUrl,
  deviceStorage
}

class _SetupPageState extends State<StatefulWidget> {
  _SetupPagePhase _currentPhase = _SetupPagePhase.noDbFound;
  _SetupPageLoadResourceChoice? _loadResourceChoice;
  TextEditingController _customUrlFieldController = TextEditingController();

  Radio<_SetupPageLoadResourceChoice> _getTileRadioLeader(
      _SetupPageLoadResourceChoice choice) =>
    Radio<_SetupPageLoadResourceChoice>(
      toggleable: true,
      value: choice,
      groupValue: _loadResourceChoice,
      onChanged: (_SetupPageLoadResourceChoice? v) { 
        setState( () => _loadResourceChoice = v ); 
      }
    );

  static Widget _buildBasicTwoOptsPage(BuildContext context, String title,
      String firstOptBrief, String secondOptBrief,
      void Function() firstOptFun, void Function() secondOptFun) =>
    Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title, 
              style: const TextStyle(fontSize: 30)
            ),
            TextButton(
              onPressed: firstOptFun,
              child: Text(firstOptBrief)
            ),
            TextButton(
              onPressed: secondOptFun,
              child: Text(secondOptBrief)
            )])));

  Widget _buildLoadResourcePage(
      BuildContext context, String title,
      String? defaultUrl, void Function(File) loader) {

    _loadResourceChoice ??= (defaultUrl == null) ?
                            _SetupPageLoadResourceChoice.customHttpUrl :
                            _SetupPageLoadResourceChoice.defaultHttpUrl; 

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title, 
              style: const TextStyle(fontSize: 30)
            ),
            ListTile(
              enabled: defaultUrl != null,
              title: const Text("Download using HTTP default URL"),
              leading: _getTileRadioLeader(_SetupPageLoadResourceChoice.defaultHttpUrl),
            ),
            ListTile(
              title: const Text("Download using HTTP custom URL"),
              leading: _getTileRadioLeader(_SetupPageLoadResourceChoice.customHttpUrl),
            ),
            TextField(
              enabled: _loadResourceChoice == _SetupPageLoadResourceChoice.customHttpUrl,
              keyboardType: TextInputType.url,
              controller: _customUrlFieldController,
              decoration: const InputDecoration(hintText: "Type in custom URL")
            ),
            ListTile(
              title: const Text("Copy from my own device storage"),
              leading: _getTileRadioLeader(_SetupPageLoadResourceChoice.deviceStorage),
            ),
            TextButton(
              child: const Text("OK"),
              onPressed: () {},
            )
          ]),));
  }

  Widget _buildNoDbFound(BuildContext context) =>
    _buildBasicTwoOptsPage(
      context,
      "No database found",
      "Create new database...",
      "Import existing database...",
      () => setState(() => _currentPhase = _SetupPagePhase.createNewDb),
      () => setState(() => _currentPhase = _SetupPagePhase.importExistingDb));

  Widget _buildCreateNewDb(BuildContext context) =>
    _buildBasicTwoOptsPage(
      context,
      "Create new database",
      "Load a preset...",
      "Leave it empty", 
      () => setState(() => _currentPhase = _SetupPagePhase.loadPreset) , 
      () => pushExerciseOverview(context));

  @override
  Widget build(BuildContext context) {
    if(_currentPhase == _SetupPagePhase.noDbFound) {
      return _buildNoDbFound(context);
    } else if(_currentPhase == _SetupPagePhase.createNewDb) {
      return _buildCreateNewDb(context);
    } else if(_currentPhase == _SetupPagePhase.importExistingDb) {
      return _buildLoadResourcePage(
        context, 
        "Import existing database", 
        null, 
        (p0) { }
      );
    }

    return _buildLoadResourcePage(
      context, 
      "Load a preset", 
      "myurl", 
      (p0) { }
    );
  }
}