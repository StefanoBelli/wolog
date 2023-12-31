// ignore_for_file: missing_whitespace_between_adjacent_strings, noop_primitive_operations

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:collection/collection.dart';
import 'dart:io';

const String ddlStmts =
  ''
  'CREATE TABLE WologMagic('
  '  magic INTEGER PRIMARY KEY NOT NULL);'
  'INSERT INTO WologMagic(magic) VALUES(789456123);'
  ''
  'CREATE TABLE Icon('
  '  Name TEXT PRIMARY KEY NOT NULL,'
  '  Filename TEXT UNIQUE NOT NULL,'
  '  Description TEXT);'
  ''
  'CREATE TABLE Equipment('
  '  Name TEXT PRIMARY KEY NOT NULL,'
  '  IconName TEXT,'
  '  Description TEXT,'
  '  FOREIGN KEY(IconName) REFERENCES Icon(Name)'
  '    ON DELETE SET NULL'
  '    ON UPDATE CASCADE);'
  ''
  'CREATE TABLE BodyPositioning('
  '  Name TEXT PRIMARY KEY NOT NULL,'
  '  IconName TEXT,'
  '  Description TEXT,'
  '  FOREIGN KEY(IconName) REFERENCES Icon(Name)'
  '    ON DELETE SET NULL'
  '    ON UPDATE CASCADE);'
  ''
  'CREATE TABLE Muscle('
  '  Name TEXT PRIMARY KEY NOT NULL,'
  '  Frontal INTEGER NOT NULL,'
  '  UpperBody INTEGER NOT NULL,'
  '  IconName TEXT,'
  '  Description TEXT,'
  '  FOREIGN KEY(IconName) REFERENCES Icon(Name)'
  '    ON DELETE SET NULL'
  '    ON UPDATE CASCADE);'
  ''
  'CREATE TABLE MusclePart('
  '  Name TEXT,'
  '  MuscleName TEXT NOT NULL,'
  '  IconName TEXT,'
  '  Description TEXT,'
  '  FOREIGN KEY(MuscleName) REFERENCES Muscle(Name)'
  '    ON DELETE RESTRICT'
  '    ON UPDATE RESTRICT,'
  '  FOREIGN KEY(IconName) REFERENCES Icon(Name)'
  '    ON DELETE SET NULL'
  '    ON UPDATE CASCADE,'
  '  PRIMARY KEY(Name, MuscleName));'
  ''
  'CREATE TABLE Exercise('
  '  Name TEXT NOT NULL,'
  '  EquipmentName TEXT,'
  '  BodyPositioningName TEXT NOT NULL,'
  '  IconName TEXT,'
  '  Description TEXT,'
  '  FOREIGN KEY(EquipmentName) REFERENCES Equipment(Name)'
  '    ON DELETE CASCADE'
  '    ON UPDATE CASCADE,'
  '  FOREIGN KEY(BodyPositioningName) REFERENCES BodyPositioning(Name)'
  '    ON DELETE CASCADE'
  '    ON UPDATE CASCADE,'
  '  FOREIGN KEY(IconName) REFERENCES Icon(Name)'
  '    ON DELETE SET NULL'
  '    ON UPDATE CASCADE,'
  '  PRIMARY KEY(Name, EquipmentName, BodyPositioningName));'
  ''
  'CREATE TABLE ExerciseMuscleInvolvement('
  '  MusclePartName TEXT,'
  '  MuscleName TEXT NOT NULL,'
  '  ExerciseName TEXT NOT NULL,'
  '  ExerciseEquipmentName TEXT,'
  '  ExerciseBodyPositioningName TEXT NOT NULL,'
  '  Description TEXT,'
  '  FOREIGN KEY(MusclePartName, MuscleName) REFERENCES MusclePart(Name, MuscleName)'
  '    ON DELETE CASCADE'
  '    ON UPDATE CASCADE,'
  '  FOREIGN KEY(ExerciseName, ExerciseEquipmentName, ExerciseBodyPositioningName)'
  '      REFERENCES Exercise(Name, EquipmentName, BodyPositioningName)'
  '    ON DELETE CASCADE'
  '    ON UPDATE CASCADE,'
  '  PRIMARY KEY(MusclePartName, MuscleName, ExerciseName,'
  '      ExerciseEquipmentName, ExerciseBodyPositioningName));'
  ''
  'CREATE TABLE Session('
  '  DateTimestamp INTEGER NOT NULL,'
  '  ExerciseName TEXT NOT NULL,'
  '  ExerciseEquipmentName TEXT,'
  '  ExerciseBodyPositioningName TEXT NOT NULL,'
  '  Description TEXT,'
  '  FOREIGN KEY(ExerciseName, ExerciseEquipmentName, ExerciseBodyPositioningName)'
  '      REFERENCES Exercise(Name, LeaningPositionName, LeaningPositionEquipmentName)'
  '    ON DELETE CASCADE'
  '    ON UPDATE CASCADE,'
  '  PRIMARY KEY(DateTimestamp, ExerciseName, ExerciseEquipmentName, ExerciseBodyPositioningName));'
  ''
  'CREATE TABLE Performance('
  '  SessionDateTimestamp INTEGER NOT NULL,'
  '  SessionExerciseName TEXT NOT NULL,'
  '  SessionExerciseEquipmentName TEXT,'
  '  SessionExerciseBodyPositioningName TEXT NOT NULL,'
  '  SetNo INTEGER NOT NULL,'
  '  Reps INTEGER NOT NULL,'
  '  WeightKg REAL,'
  '  Description TEXT,'
  '  FOREIGN KEY(SessionDateTimestamp, SessionExerciseName, SessionExerciseEquipmentName,'
  '      SessionExerciseBodyPositioningName) REFERENCES Session(DateTimestamp, ExerciseName,'
  '      ExerciseEquipmentName, ExerciseBodyPositioningName)'
  '    ON DELETE CASCADE'
  '    ON UPDATE CASCADE,'
  '  PRIMARY KEY(SessionDateTimestamp, SessionExerciseName, SessionExerciseEquipmentName,'
  '      SessionExerciseBodyPositioningName, SetNo))'
  ''
  ;

Future<Database> getDatabase() async {
  final dbPath = await getDatabaseFilePath();
  final dbOnFs = _getDbOnFsInfo(dbPath);

  Future<void> Function (Database, int) onCreateFn;
  if(dbOnFs == _DbOnFs.valid) {
    onCreateFn = (final _,final __) async {};
  } else if(dbOnFs == _DbOnFs.doesNotExist) {
    onCreateFn = (final db, final ver) async {
        final batch = db.batch();
        ddlStmts.split(';')
            .forEach(batch.execute);
        await batch.commit();
      };
  } else {
    throw Exception('this is not a SQLite database file');
  }

  return openDatabase(
    dbPath,
    version: 1,
    onCreate: onCreateFn
  );
}

enum _DbOnFs {
  valid,
  doesNotExist,
  invalid
}

_DbOnFs _getDbOnFsInfo(final String dbPath) {
  final dbf = File(dbPath);
  if(dbf.existsSync()) {
    if(dbf.statSync().size >= 16) {
      const magic =
        <int>[
          0x53, 0x51, 0x4C, 0x69,
          0x74, 0x65, 0x20, 0x66,
          0x6F, 0x72, 0x6D, 0x61,
          0x74, 0x20, 0x33, 0x00
        ];
      final dbRaf = dbf.openSync();
      final dbBuffer = dbRaf.readSync(16).toList();
      dbRaf.closeSync();

      return const ListEquality().equals(dbBuffer, magic) ?
        _DbOnFs.valid : _DbOnFs.invalid;
    }

    return _DbOnFs.invalid;
  }

  return _DbOnFs.doesNotExist;
}

Future<void> closeDatabase(final Database database) => 
  database.close();

Future<String> getDatabaseFilePath() async => 
  join(await getDatabasesPath(), 'wolog.db');