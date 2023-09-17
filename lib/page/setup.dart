import 'package:flutter/material.dart';
import 'package:wolog/database/database.dart';
import 'package:wolog/page/exercise.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:wolog/util.dart';

class NoDbFoundPage extends StatelessWidget {
  const NoDbFoundPage({super.key});

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(),
      body: Center(
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              const Text(
                "No database found", 
                style: TextStyle(fontSize: 30)
              ),
              TextButton(
                onPressed: () => pushExercisePage(context),
                child: const Text("Create new database")
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (_) => const _ImportExistingDbPage())),
                child: const Text("Import existing database...")
              )
            ])));
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

  // start util fns

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

  // end util fns
  
  Future<void> _copyAsAppDb(File dbFile) async {
    File appDbFile = File(await getDatabaseFilePath());
    await appDbFile.writeAsBytes(await dbFile.readAsBytes(), flush: true);
  }

  Future<File> _saveInDownloads(List<int> httpBodyBytes) async {
    Directory? tmpDir = await getTemporaryDirectory();
    File wologDbFile = File("${tmpDir.path}/wolog.db");
    await wologDbFile.writeAsBytes(httpBodyBytes, flush: true);

    return wologDbFile;
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
        _goodShowSnackBar("Errored while downloading");
        _stopUiHttpDlStatusValue();
      }, 
      onDone: () {
        _saveInDownloads(bodyBytes).then(
          (dbFile) {
            _copyAsAppDb(dbFile).then((_) {
              pushExercisePage(
                  context,
                  onErrorHook: () => _stopUiHttpDlStatusValue());
            });
          },
          onError: (ae) {
            _goodShowSnackBar((ae as ArgumentError).message);
            _stopUiHttpDlStatusValue();
          });
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
          _copyAsAppDb(File(pickedPath)).then((_) {
            if(mounted) {
              pushExercisePage(
                  context,
                  onErrorHook: () => setState(() => _isObtainingDatabase = false));
            }
          });
        }
        } else {
          _goodShowSnackBar("pickedPath == null, please report this bug");
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
              const Text(
                "WARNING: App performs some weak checks on chosen database file."
                " By passing them, that doesn't automatically mean that db schema"
                " is necessarily coherent with the one this app expects."
                " If this is the situation, you will encounter strange errors and"
                " unexpected behaviours - just clear app data and import a valid db.",
                style: TextStyle(fontSize: 13, color: Colors.redAccent)),
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
              if(_isObtainingDbViaHttp) 
                LinearProgressIndicator(value: _downloadStatusValue,)
            ]),)),
      onWillPop: () async {
        if(_isObtainingDatabase) {
          _goodShowSnackBar("Cannot go back as we are currently importing db...");
        }

        return !_isObtainingDatabase;
      });
  }
}