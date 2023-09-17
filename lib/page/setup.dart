import 'package:flutter/material.dart';
import '../database/database.dart';
import 'exercise.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../util.dart';

class NoDbFoundPage extends StatelessWidget {
  const NoDbFoundPage({super.key});

  @override
  Widget build(final BuildContext context) =>
    Scaffold(
      appBar: AppBar(),
      body: Center(
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              const Text(
                'No database found', 
                style: TextStyle(fontSize: 30)
              ),
              TextButton(
                onPressed: () => pushExercisePage(context),
                child: const Text('Create new database')
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (final _) => const _ImportExistingDbPage())),
                child: const Text('Import existing database...')
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

  static const String _defaultUrl = '';

  // start util fns

  void _stopUiHttpDlStatusValue() {
    setState(() {
      _isObtainingDatabase = false;
      _isObtainingDbViaHttp = false;
      _downloadStatusValue = null;
      _downloadStatusValuePercentage = null;
    });
  }

  void _stopUiNoHttpDlRetrieval() {
    setState(() => _isObtainingDatabase = false);
  }
  
  void _stopUiNoHttpDlRetrievalErrored(final String errorMessage) {
    _goodShowSnackBar(errorMessage);
    _stopUiNoHttpDlRetrieval();
  }

  void _stopUiHttpDlStatusValueErrored(final String errorMessage) {
    _goodShowSnackBar(errorMessage);
    _stopUiHttpDlStatusValue();
  }

  void _goodShowSnackBar(final String message) {
    if(mounted) {
      showSnackBar(context, message);
    }
  }

  Uri? _getUri() {
    final url =
        _loadResourceChoice == _ObtainDatabaseChoice.defaultHttpUrl ?
        _defaultUrl :
        _customUrlFieldController.text;

    Uri ?uri;

    try {
      uri = Uri.parse(url);
    } on Exception catch(_) {
      uri = null;
    }

    return uri;
  }

  // end util fns
  
  Future<void> _copyAsAppDb(final File dbFile) async {
    final appDbFile = File(await getDatabaseFilePath());
    await appDbFile.writeAsBytes(await dbFile.readAsBytes(), flush: true);
  }

  Future<File> _saveInDownloads(final List<int> httpBodyBytes) async {
    final tmpDir = await getTemporaryDirectory();
    final wologDbFile = File('${tmpDir.path}/wolog.db');
    await wologDbFile.writeAsBytes(httpBodyBytes, flush: true);

    return wologDbFile;
  }

  void _setByteStreamListener(final http.ByteStream bodyByteStream, final int? contentLength) {
    setState(() => _isObtainingDbViaHttp = true);

    final bodyBytes = <int>[];

    void Function(List<int>) onDataFn;
    if(contentLength == null) {
      onDataFn = bodyBytes.addAll;
    } else {
      var onDataCallCount = 0;

      onDataFn = (final data) {
        bodyBytes.addAll(data);

        if (onDataCallCount++ % 500 == 0) {
          setState(() {
            _downloadStatusValue = bodyBytes.length / contentLength;
            _downloadStatusValuePercentage =
                (_downloadStatusValue! * 100).toInt();
          });
        }
      };
    }

    bodyByteStream.listen(
      onDataFn, 
      onError: (final e) {
        _stopUiHttpDlStatusValueErrored(
          'Errored while downloading (maybe internet is gone?)');
      }, 
      onDone: () {
        _saveInDownloads(bodyBytes).then(
          (final dbFile) {
            _copyAsAppDb(dbFile).then((final _) {
              pushExercisePage(
                  context,
                  onErrorHook: _stopUiHttpDlStatusValue);
            });
          },
          onError: (final ae) {
            _stopUiHttpDlStatusValueErrored((ae as ArgumentError).message);
          });
      }, 
      cancelOnError: true
    );
  }

  Future<void> _handleObtainingDatabase() async {
    setState(() => _isObtainingDatabase = true);

    if(_loadResourceChoice == _ObtainDatabaseChoice.deviceStorage) {
      final filePickerResult = await FilePicker.platform.pickFiles();
      
      if(filePickerResult != null) {
        final pickedPath = filePickerResult.files.single.path;

        if(pickedPath != null) {
          await _copyAsAppDb(File(pickedPath));
          if(mounted) {
            pushExercisePage(
              context,
              onErrorHook: _stopUiNoHttpDlRetrieval);
          } else {
            _stopUiNoHttpDlRetrievalErrored(
              'context is not mounted, please report this bug');
          }
        } else {
          _stopUiNoHttpDlRetrieval();
        }
      } else {
        _stopUiNoHttpDlRetrievalErrored(
          'pickedPath == null, please report this bug');
      }
    } else {
      final parsedUri = _getUri();

      if(parsedUri != null) {
        final req = http.Request('GET', parsedUri);
        http.StreamedResponse res;

        try {
          res = await req.send();
        } on Object catch(_) {
          _stopUiNoHttpDlRetrievalErrored(
            'HTTP client error (try to prepend http[s]://,'
            ' check internet connectivity, check hostname)');
          return;
        }

        if (res.statusCode == 200) {
          _setByteStreamListener(res.stream, res.contentLength);
        } else {
          _stopUiNoHttpDlRetrievalErrored(
            'Server HTTP response status code is ${res.statusCode}');
        }
      } else {
        _stopUiNoHttpDlRetrievalErrored('Check URL format');
      }
    }
  }

  Radio<_ObtainDatabaseChoice> _getTileRadioLeader(
      final _ObtainDatabaseChoice choice) =>
    Radio<_ObtainDatabaseChoice>(
      value: choice,
      groupValue: _loadResourceChoice,
      onChanged: (final v) => setState( () => _loadResourceChoice = v )
    );

  @override
  Widget build(final BuildContext context) => 
    WillPopScope(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Import existing database', 
                style: TextStyle(fontSize: 30)
              ),
              ListTile(
                title: const Text('Download using HTTP default URL'),
                leading: _getTileRadioLeader(_ObtainDatabaseChoice.defaultHttpUrl), 
              ),
              ListTile(
                title: const Text('Download using HTTP custom URL'),
                leading: _getTileRadioLeader(_ObtainDatabaseChoice.customHttpUrl),
              ),
              TextField(
                enabled: _loadResourceChoice == _ObtainDatabaseChoice.customHttpUrl,
                keyboardType: TextInputType.url,
                controller: _customUrlFieldController,
                decoration: const InputDecoration(hintText: 'Type in custom URL')
              ),
              ListTile(
                title: const Text('Copy from my own device storage'),
                leading: _getTileRadioLeader(_ObtainDatabaseChoice.deviceStorage),
              ),
              const Text(
                'WARNING: App performs some weak checks on chosen database file.'
                " By passing them, that doesn't automatically mean that db schema"
                ' is necessarily coherent with the one this app expects.'
                ' If this is the situation, you will encounter strange errors and'
                ' unexpected behaviours - just clear app data and import a valid db.',
                style: TextStyle(fontSize: 13, color: Colors.redAccent)),
              TextButton(
                onPressed: _isObtainingDatabase ? null : _handleObtainingDatabase,
                child: const Text('Ok')
              ),
              if(_isObtainingDbViaHttp) 
                Row(
                  children: [
                    const Text('Downloading via HTTP...', textAlign: TextAlign.left,),
                    if(_downloadStatusValuePercentage != null) 
                      Text('$_downloadStatusValuePercentage%', textAlign: TextAlign.right,)],),
              if(_isObtainingDbViaHttp) 
                LinearProgressIndicator(value: _downloadStatusValue,)
            ]),)),
      onWillPop: () async {
        if(_isObtainingDatabase) {
          _goodShowSnackBar('Cannot go back as we are currently importing db...');
        }

        return !_isObtainingDatabase;
      });
}