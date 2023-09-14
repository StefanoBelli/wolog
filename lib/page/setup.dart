import 'package:flutter/material.dart';
import 'package:wolog/page/exercise.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
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

enum _ObtainResourceChoice {
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
  _ObtainResourceChoice? _loadResourceChoice = _ObtainResourceChoice.defaultHttpUrl;
  final TextEditingController _customUrlFieldController = TextEditingController();
  static const String _defaultUrl = "";

  void _copyAsAppDb(File dbFile) {
    // todo
  }

  File _saveInDownloads(List<int> httpBodyBytes) {
    //todo
    return File("");
  }

  void _handleResourceLoading() async {

    //todo disable OK BUTTON, reenable in case of error
    //todo instantiate status widget

    if(_loadResourceChoice == _ObtainResourceChoice.deviceStorage) {
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
          _copyAsAppDb(File(pickedPath));
        } else {
          //todo indicate status
        }
      } 
      // else {
      //   do nothing, user canceled picker
      // }
    } else {

      final String url =
        _loadResourceChoice == _ObtainResourceChoice.defaultHttpUrl ?
        _defaultUrl :
        _customUrlFieldController.text;

      Uri parsedUri;

      try {
        parsedUri = Uri.parse(url);
      } catch(fe) {
        //todo indicate status
        return;
      }

      List<int> bodyBytes = [];
      final req = http.Request("GET", parsedUri);
      http.StreamedResponse res;

      try {
        res = await req.send();
      } catch(ae) {
        //todo indicate status
        return;
      }

      if (res.statusCode == 200) {
        res.stream.listen(
          (data) {
            bodyBytes += data;
            //signal progress
          }, 
          onError: (e) {
            //indicate status
          }, 
          onDone: () {
            //save file
            //copy as appdb
            //close dialog
            //push exercises overview
          }, 
          cancelOnError: true);
      } else {
        //indicate status
      }
    }
  }

  Radio<_ObtainResourceChoice> _getTileRadioLeader(
      _ObtainResourceChoice choice) =>
    Radio<_ObtainResourceChoice>(
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
              leading: _getTileRadioLeader(_ObtainResourceChoice.defaultHttpUrl), 
            ),
            ListTile(
              title: const Text("Download using HTTP custom URL"),
              leading: _getTileRadioLeader(_ObtainResourceChoice.customHttpUrl),
            ),
            TextField(
              enabled: _loadResourceChoice == _ObtainResourceChoice.customHttpUrl,
              keyboardType: TextInputType.url,
              controller: _customUrlFieldController,
              decoration: const InputDecoration(hintText: "Type in custom URL")
            ),
            ListTile(
              title: const Text("Copy from my own device storage"),
              leading: _getTileRadioLeader(_ObtainResourceChoice.deviceStorage),
            ),
            TextButton(
              child: const Text("OK"),
              onPressed: () => _handleResourceLoading(),
            )
          ]),));
  }

}