import 'package:flutter/material.dart';
import 'package:wolog/page/exercise.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
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
      () => pushExerciseOverview(context),
      () => Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (c) => const _ImportExistingDbPage()))
    );
}

enum _SetupPageLoadResourceChoice {
  defaultHttpUrl,
  customHttpUrl,
  deviceStorage
}

class _ImportExistingDbPage extends StatefulWidget {
  const _ImportExistingDbPage();

  @override
  State<StatefulWidget> createState() => _ImportExistingDbState();
}

class _ImportExistingDbState extends State<StatefulWidget> {
  _SetupPageLoadResourceChoice? _loadResourceChoice = _SetupPageLoadResourceChoice.defaultHttpUrl;
  final TextEditingController _customUrlFieldController = TextEditingController();
  static const String _defaultUrl = "";

  void _loader(File dbFile) {
    // todo
  }

  File _saveInDownloads(String httpBody) {
    //todo
    return File("");
  }

  void _handleResourceLoading() async {

    //todo disable OK BUTTON, reenable in case of error
    //todo instantiate status widget

    if(_loadResourceChoice == _SetupPageLoadResourceChoice.deviceStorage) {
      //todo allowedExtensions set to ['db'] with custom file ext enabled
      FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles();
      if(filePickerResult != null) {
        String? pickedPath;
        try {
          pickedPath = filePickerResult.files.single.path;
        } catch(se) {
          //todo indicate status, more than one file chosen
          return;
        }

        if(pickedPath != null) {
          _loader(File(pickedPath));
        } else {
          //todo indicate status
        }
      } 
      // else {
      //   do nothing, user canceled picker
      // }
    } else {

      final String url =
        _loadResourceChoice == _SetupPageLoadResourceChoice.defaultHttpUrl ?
        _defaultUrl :
        _customUrlFieldController.text;

      Uri parsedUri;

      try {
        parsedUri = Uri.parse(url);
      } catch(fe) {
        //todo indicate status
        return;
      }

      http.get(parsedUri).then(
        (response) {
          if(response.statusCode != 200) {
            //todo indicate status
            return;
          }

          _loader(_saveInDownloads(response.body));
        }, 
        onError: (object, stackTrace) {
          //todo indicate status
        });
    }
  }

  Radio<_SetupPageLoadResourceChoice> _getTileRadioLeader(
      _SetupPageLoadResourceChoice choice) =>
    Radio<_SetupPageLoadResourceChoice>(
      toggleable: true,
      value: choice,
      groupValue: _loadResourceChoice,
      onChanged: (v) => setState( () => _loadResourceChoice = v )
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Import existing database", 
              style: TextStyle(fontSize: 30)
            ),
            ListTile(
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
              onPressed: () => _handleResourceLoading(),
            )
          ]),));
  }

}