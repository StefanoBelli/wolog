import 'package:flutter/material.dart';
import 'package:wolog/page/exercise.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:wolog/util.dart';

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

enum _ObtainDatabaseChoice {
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
  _ObtainDatabaseChoice? _loadResourceChoice = _ObtainDatabaseChoice.defaultHttpUrl;
  final TextEditingController _customUrlFieldController = TextEditingController();
  bool _isObtainingDatabase = false;  
  bool _isObtainingDbViaHttp = false;
  double? _downloadStatusValue;
  int? _downloadStatusValuePercentage;

  static const String _defaultUrl = "";

  // util

  void _stopUiHttpDlStatusValue() {
    setState(() {
      _isObtainingDatabase = false;
      _isObtainingDbViaHttp = false;
      _downloadStatusValue = null;
      _downloadStatusValuePercentage = null;
    });
  }

  void _goodShowSnackBar(String message) {
    if(mounted) {
      showSnackBar(context, message);
    }
  }

  Uri? _getUri() {
    final String url =
        _loadResourceChoice == _ObtainDatabaseChoice.defaultHttpUrl ?
        _defaultUrl :
        _customUrlFieldController.text;

    Uri ?uri;

    try {
      uri = Uri.parse(url);
    } catch(fe) {
      uri = null;
    }

    return uri;
  }

  // util
  
  void _copyAsAppDbAndGo(File dbFile) {
    // todo
    //pushExerciseOverview(context);
  }

  File _saveInDownloads(List<int> httpBodyBytes) {
    // todo
    return File("");
  }

  void _setByteStreamListener(http.ByteStream bodyByteStream, int? contentLength){
    setState(() => _isObtainingDbViaHttp = true);

    List<int> bodyBytes = [];

    void Function(List<int>) onDataFn;
    if(contentLength == null) {
      onDataFn = (data) { bodyBytes += data; };
    } else {
      onDataFn = (data) {
        bodyBytes += data;
        setState(() { 
          _downloadStatusValue = bodyBytes.length / contentLength; 
          _downloadStatusValuePercentage = (_downloadStatusValue! * 100).toInt();
        });
      };
    }

    bodyByteStream.listen(
      onDataFn, 
      onError: (e) {
        _stopUiHttpDlStatusValue();
        _goodShowSnackBar("Errored while downloading");
      }, 
      onDone: () {
        _stopUiHttpDlStatusValue();
        _copyAsAppDbAndGo(_saveInDownloads(bodyBytes));
      }, 
      cancelOnError: true
    );
  }

  void _handleObtainingDatabase() async {
    setState(() => _isObtainingDatabase = true);

    if(_loadResourceChoice == _ObtainDatabaseChoice.deviceStorage) {
      FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );
      
      if(filePickerResult != null) {
        String? pickedPath = filePickerResult.files.single.path;

        if(pickedPath != null) {
          _copyAsAppDbAndGo(File(pickedPath));
        } else {
          _goodShowSnackBar("pickedPath == null, please report this bug");
        }
      } 
      
      setState(() => _isObtainingDatabase = false);
    } else {
      Uri? parsedUri = _getUri();

      if(parsedUri != null) {
        final req = http.Request("GET", parsedUri);
        http.StreamedResponse res;

        try {
          res = await req.send();
        } catch(ae) {
          _goodShowSnackBar("HTTP client error (try to prepend http[s]://,"
                            " check internet connectivity, check hostname)");
          setState(() => _isObtainingDatabase = false);
          return;
        }

        if (res.statusCode == 200) {
          _setByteStreamListener(res.stream, res.contentLength);
        } else {
          _goodShowSnackBar("Server HTTP response status code is ${res.statusCode}");
          setState(() => _isObtainingDatabase = false);
        }
      } else {
        _goodShowSnackBar("URI parsing API reported error");
        setState(() => _isObtainingDatabase = false);
      }
    }
  }

  Radio<_ObtainDatabaseChoice> _getTileRadioLeader(
      _ObtainDatabaseChoice choice) =>
    Radio<_ObtainDatabaseChoice>(
      value: choice,
      groupValue: _loadResourceChoice,
      onChanged: (v) => setState( () => _loadResourceChoice = v )
    );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
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
                leading: _getTileRadioLeader(_ObtainDatabaseChoice.defaultHttpUrl), 
              ),
              ListTile(
                title: const Text("Download using HTTP custom URL"),
                leading: _getTileRadioLeader(_ObtainDatabaseChoice.customHttpUrl),
              ),
              TextField(
                enabled: _loadResourceChoice == _ObtainDatabaseChoice.customHttpUrl,
                keyboardType: TextInputType.url,
                controller: _customUrlFieldController,
                decoration: const InputDecoration(hintText: "Type in custom URL")
              ),
              ListTile(
                title: const Text("Copy from my own device storage"),
                leading: _getTileRadioLeader(_ObtainDatabaseChoice.deviceStorage),
              ),
              TextButton(
                onPressed: _isObtainingDatabase ? null : () => _handleObtainingDatabase(),
                child: const Text("Ok")
              ),
              if(_isObtainingDbViaHttp) 
                Row(
                  children: [
                    const Text("Downloading via HTTP...", textAlign: TextAlign.left,),
                    if(_downloadStatusValuePercentage != null) 
                      Text("$_downloadStatusValuePercentage%", textAlign: TextAlign.right,)],),
              if(_isObtainingDbViaHttp) LinearProgressIndicator(value: _downloadStatusValue,)
            ]),)),
      onWillPop: () async {
        if(_isObtainingDatabase) {
          _goodShowSnackBar("Cannot go back as we are currently importing db...");
        }

        return !_isObtainingDatabase;
      });
  }
}