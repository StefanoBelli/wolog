import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wolog/page/exercise.dart';
import 'dart:io';

Widget _buildBasicTwoOptsPage(
      BuildContext context,
      String title,
      String firstOptBrief,
      String secondOptBrief,
      void Function() firstOptFun,
      void Function() secondOptFun) =>
    Scaffold(
      appBar: AppBar(),
      body: Center(
        child:
          Column(
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
              )
            ])));

class NoDbFoundPage extends StatelessWidget {
  const NoDbFoundPage({super.key});

  @override
  Widget build(BuildContext context) =>
    _buildBasicTwoOptsPage(
      context, 
      "No database found", 
      "Create new database...", 
      "Import existing database...", 
      () => Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (c) => const _CreateNewDbPage())), 
      () => Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (c) => const _ImportExistingDbPage()))
    );
}

class _CreateNewDbPage extends StatelessWidget {
  const _CreateNewDbPage({super.key});

  @override
  Widget build(BuildContext context) =>
    _buildBasicTwoOptsPage(
      context, 
      "Create new database", 
      "Load a preset", 
      "Leave it empty", 
      () => Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (c) => const _LoadPresetPage())),
      () => pushExerciseOverview(context)
    );
}

enum _SetupPageLoadResourceChoice {
  defaultHttpUrl,
  customHttpUrl,
  deviceStorage
}

abstract class _LoadResourceStateBase extends State<StatefulWidget> {
  _SetupPageLoadResourceChoice? _loadResourceChoice;
  final TextEditingController _customUrlFieldController = TextEditingController();

  Radio<_SetupPageLoadResourceChoice> _getTileRadioLeader(
      _SetupPageLoadResourceChoice choice, {bool enabled = true}) =>
    Radio<_SetupPageLoadResourceChoice>(
      toggleable: true,
      value: choice,
      groupValue: _loadResourceChoice,
      onChanged: enabled ? (v) => setState( () => _loadResourceChoice = v ) : null
    );

  @protected
  @nonVirtual
  Widget buildLoadResourcePage(
      BuildContext context, String title,
      String? defaultUrl, void Function(File) loader) {

    bool hasDefaultUrl = defaultUrl != null;

    _loadResourceChoice ??= hasDefaultUrl ?
                            _SetupPageLoadResourceChoice.defaultHttpUrl :
                            _SetupPageLoadResourceChoice.customHttpUrl; 

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title, 
              style: const TextStyle(fontSize: 30)
            ),
            ListTile(
              enabled: hasDefaultUrl,
              title: const Text("Download using HTTP default URL"),
              leading: _getTileRadioLeader(
                                            _SetupPageLoadResourceChoice.defaultHttpUrl, 
                                            enabled: hasDefaultUrl),
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
}

class _ImportExistingDbPage extends StatefulWidget {
  const _ImportExistingDbPage();

  @override
  State<StatefulWidget> createState() => _ImportExistingDbState();
}

class _LoadPresetPage extends StatefulWidget {
  const _LoadPresetPage();

  @override
  State<StatefulWidget> createState() => _LoadPresetState();
}

class _ImportExistingDbState extends _LoadResourceStateBase {
  @override
  Widget build(BuildContext context) =>
    buildLoadResourcePage(
      context, "Import existing database", null, (p0) { });
}

class _LoadPresetState extends _LoadResourceStateBase {
  @override
  Widget build(BuildContext context) =>
    buildLoadResourcePage(
      context, "Load a preset", "", (p0) { });
}