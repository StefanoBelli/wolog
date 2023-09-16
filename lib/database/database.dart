import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:collection/collection.dart';
import 'dart:io';

const String ddlStmts =
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
  final String dbPath = await getDatabaseFilePath();

  if(_isDatabase(dbPath)) {
    return openDatabase(
        dbPath,
        onCreate: (db, ver) async {
          Batch batch = db.batch();
          ddlStmts.split(';')
              .forEach((stmt) =>
              batch.execute(stmt));
          await batch.commit();
        },
        version: 1
    );
  }

  throw ArgumentError();
}

bool _isDatabase(String dbPath) {
  File dbf = File(dbPath);
  if(dbf.existsSync()) {
    if(dbf.statSync().size >= 16) {
      const List<int> magic =
        [
          0x53, 0x51, 0x4C, 0x69,
          0x74, 0x65, 0x20, 0x66,
          0x6F, 0x72, 0x6D, 0x61,
          0x74, 0x20, 0x33, 0x00
        ];
      RandomAccessFile dbRaf = dbf.openSync();
      List<int> dbBuffer = dbRaf.readSync(16).toList();
      dbRaf.closeSync();

      return const ListEquality().equals(dbBuffer, magic);
    }

    return false;
  }

  return true;
}

Future<void> closeDatabase(Database database) {
  return database.close();
}

Future<String> getDatabaseFilePath() async {
  return join(await getDatabasesPath(), 'wolog.db');
}