// Mocks generated by Mockito 5.4.2 from annotations
// in wolog/test/import_existing_db_page_widget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:convert' as _i2;
import 'dart:typed_data' as _i4;

import 'package:file_picker/src/file_picker.dart' as _i8;
import 'package:file_picker/src/file_picker_result.dart' as _i9;
import 'package:http/http.dart' as _i3;
import 'package:http/src/byte_stream.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEncoding_0 extends _i1.SmartFake implements _i2.Encoding {
  _FakeEncoding_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUri_1 extends _i1.SmartFake implements Uri {
  _FakeUri_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_2 extends _i1.SmartFake
    implements _i3.StreamedResponse {
  _FakeStreamedResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [Request].
///
/// See the documentation for Mockito's code generation for more information.
class MockRequest extends _i1.Mock implements _i3.Request {
  MockRequest() {
    _i1.throwOnMissingStub(this);
  }

  @override
  int get contentLength => (super.noSuchMethod(
        Invocation.getter(#contentLength),
        returnValue: 0,
      ) as int);
  @override
  set contentLength(int? value) => super.noSuchMethod(
        Invocation.setter(
          #contentLength,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i2.Encoding get encoding => (super.noSuchMethod(
        Invocation.getter(#encoding),
        returnValue: _FakeEncoding_0(
          this,
          Invocation.getter(#encoding),
        ),
      ) as _i2.Encoding);
  @override
  set encoding(_i2.Encoding? value) => super.noSuchMethod(
        Invocation.setter(
          #encoding,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Uint8List get bodyBytes => (super.noSuchMethod(
        Invocation.getter(#bodyBytes),
        returnValue: _i4.Uint8List(0),
      ) as _i4.Uint8List);
  @override
  set bodyBytes(List<int>? value) => super.noSuchMethod(
        Invocation.setter(
          #bodyBytes,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  String get body => (super.noSuchMethod(
        Invocation.getter(#body),
        returnValue: '',
      ) as String);
  @override
  set body(String? value) => super.noSuchMethod(
        Invocation.setter(
          #body,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  Map<String, String> get bodyFields => (super.noSuchMethod(
        Invocation.getter(#bodyFields),
        returnValue: <String, String>{},
      ) as Map<String, String>);
  @override
  set bodyFields(Map<String, String>? fields) => super.noSuchMethod(
        Invocation.setter(
          #bodyFields,
          fields,
        ),
        returnValueForMissingStub: null,
      );
  @override
  String get method => (super.noSuchMethod(
        Invocation.getter(#method),
        returnValue: '',
      ) as String);
  @override
  Uri get url => (super.noSuchMethod(
        Invocation.getter(#url),
        returnValue: _FakeUri_1(
          this,
          Invocation.getter(#url),
        ),
      ) as Uri);
  @override
  Map<String, String> get headers => (super.noSuchMethod(
        Invocation.getter(#headers),
        returnValue: <String, String>{},
      ) as Map<String, String>);
  @override
  bool get persistentConnection => (super.noSuchMethod(
        Invocation.getter(#persistentConnection),
        returnValue: false,
      ) as bool);
  @override
  set persistentConnection(bool? value) => super.noSuchMethod(
        Invocation.setter(
          #persistentConnection,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get followRedirects => (super.noSuchMethod(
        Invocation.getter(#followRedirects),
        returnValue: false,
      ) as bool);
  @override
  set followRedirects(bool? value) => super.noSuchMethod(
        Invocation.setter(
          #followRedirects,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  int get maxRedirects => (super.noSuchMethod(
        Invocation.getter(#maxRedirects),
        returnValue: 0,
      ) as int);
  @override
  set maxRedirects(int? value) => super.noSuchMethod(
        Invocation.setter(
          #maxRedirects,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get finalized => (super.noSuchMethod(
        Invocation.getter(#finalized),
        returnValue: false,
      ) as bool);
  @override
  _i5.ByteStream finalize() => (super.noSuchMethod(
        Invocation.method(
          #finalize,
          [],
        ),
        returnValue: _i6.dummyValue<_i5.ByteStream>(
          this,
          Invocation.method(
            #finalize,
            [],
          ),
        ),
      ) as _i5.ByteStream);
  @override
  _i7.Future<_i3.StreamedResponse> send() => (super.noSuchMethod(
        Invocation.method(
          #send,
          [],
        ),
        returnValue:
            _i7.Future<_i3.StreamedResponse>.value(_FakeStreamedResponse_2(
          this,
          Invocation.method(
            #send,
            [],
          ),
        )),
      ) as _i7.Future<_i3.StreamedResponse>);
}

/// A class which mocks [StreamedResponse].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamedResponse extends _i1.Mock implements _i3.StreamedResponse {
  MockStreamedResponse() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.ByteStream get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i6.dummyValue<_i5.ByteStream>(
          this,
          Invocation.getter(#stream),
        ),
      ) as _i5.ByteStream);
  @override
  int get statusCode => (super.noSuchMethod(
        Invocation.getter(#statusCode),
        returnValue: 0,
      ) as int);
  @override
  Map<String, String> get headers => (super.noSuchMethod(
        Invocation.getter(#headers),
        returnValue: <String, String>{},
      ) as Map<String, String>);
  @override
  bool get isRedirect => (super.noSuchMethod(
        Invocation.getter(#isRedirect),
        returnValue: false,
      ) as bool);
  @override
  bool get persistentConnection => (super.noSuchMethod(
        Invocation.getter(#persistentConnection),
        returnValue: false,
      ) as bool);
}

/// A class which mocks [FilePicker].
///
/// See the documentation for Mockito's code generation for more information.
class MockFilePicker extends _i1.Mock implements _i8.FilePicker {
  MockFilePicker() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i9.FilePickerResult?> pickFiles({
    String? dialogTitle,
    String? initialDirectory,
    _i8.FileType? type = _i8.FileType.any,
    List<String>? allowedExtensions,
    dynamic Function(_i8.FilePickerStatus)? onFileLoading,
    bool? allowCompression = true,
    bool? allowMultiple = false,
    bool? withData = false,
    bool? withReadStream = false,
    bool? lockParentWindow = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #pickFiles,
          [],
          {
            #dialogTitle: dialogTitle,
            #initialDirectory: initialDirectory,
            #type: type,
            #allowedExtensions: allowedExtensions,
            #onFileLoading: onFileLoading,
            #allowCompression: allowCompression,
            #allowMultiple: allowMultiple,
            #withData: withData,
            #withReadStream: withReadStream,
            #lockParentWindow: lockParentWindow,
          },
        ),
        returnValue: _i7.Future<_i9.FilePickerResult?>.value(),
      ) as _i7.Future<_i9.FilePickerResult?>);
  @override
  _i7.Future<bool?> clearTemporaryFiles() => (super.noSuchMethod(
        Invocation.method(
          #clearTemporaryFiles,
          [],
        ),
        returnValue: _i7.Future<bool?>.value(),
      ) as _i7.Future<bool?>);
  @override
  _i7.Future<String?> getDirectoryPath({
    String? dialogTitle,
    bool? lockParentWindow = false,
    String? initialDirectory,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDirectoryPath,
          [],
          {
            #dialogTitle: dialogTitle,
            #lockParentWindow: lockParentWindow,
            #initialDirectory: initialDirectory,
          },
        ),
        returnValue: _i7.Future<String?>.value(),
      ) as _i7.Future<String?>);
  @override
  _i7.Future<String?> saveFile({
    String? dialogTitle,
    String? fileName,
    String? initialDirectory,
    _i8.FileType? type = _i8.FileType.any,
    List<String>? allowedExtensions,
    bool? lockParentWindow = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveFile,
          [],
          {
            #dialogTitle: dialogTitle,
            #fileName: fileName,
            #initialDirectory: initialDirectory,
            #type: type,
            #allowedExtensions: allowedExtensions,
            #lockParentWindow: lockParentWindow,
          },
        ),
        returnValue: _i7.Future<String?>.value(),
      ) as _i7.Future<String?>);
}
