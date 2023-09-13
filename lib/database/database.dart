import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
  'CREATE TABLE LeaningPosition('
  '  Name TEXT NOT NULL,'
  '  EquipmentName TEXT,'
  '  IconName TEXT,'
  '  Description TEXT,'
  '  FOREIGN KEY(EquipmentName) REFERENCES Equipment(Name)'
  '    ON DELETE RESTRICT'
  '    ON UPDATE RESTRICT,'
  '  FOREIGN KEY(IconName) REFERENCES Icon(Name)'
  '    ON DELETE SET NULL'
  '    ON UPDATE CASCADE,'
  '  PRIMARY KEY(Name, EquipmentName));'
  ''
  'CREATE TABLE Exercise('
  '  Name TEXT NOT NULL,'
  '  LeaningPositionName TEXT NOT NULL,'
  '  LeaningPositionEquipmentName TEXT,'
  '  IconName TEXT,'
  '  Description TEXT,'
  '  FOREIGN KEY(LeaningPositionName, LeaningPositionEquipmentName) REFERENCES LeaningPosition(Name, EquipmentName)'
  '    ON DELETE CASCADE'
  '    ON UPDATE CASCADE,'
  '  FOREIGN KEY(IconName) REFERENCES Icon(Name)'
  '    ON DELETE SET NULL'
  '    ON UPDATE CASCADE,'
  '  PRIMARY KEY(Name, LeaningPositionName, LeaningPositionEquipmentName));'
  ''
  'CREATE TABLE ExerciseMuscleInvolvement('
  '  MusclePartName TEXT,'
  '  MuscleName TEXT NOT NULL,'
  '  ExerciseName TEXT NOT NULL,'
  '  ExerciseLeaningPositionName TEXT NOT NULL,'
  '  ExerciseLeaningPositionEquipmentName TEXT,'
  '  Description TEXT,'
  '  FOREIGN KEY(MusclePartName, MuscleName) REFERENCES MusclePart(Name, MuscleName)'
  '    ON DELETE CASCADE'
  '    ON UPDATE CASCADE,'
  '  FOREIGN KEY(ExerciseName, ExerciseLeaningPositionName, ExerciseLeaningPositionEquipmentName)'
  '      REFERENCES Exercise(Name, LeaningPositionName, LeaningPositionEquipmentName)'
  '    ON DELETE CASCADE'
  '    ON UPDATE CASCADE,'
  '  PRIMARY KEY(MusclePartName, MuscleName, ExerciseName,'
  '      ExerciseLeaningPositionName, ExerciseLeaningPositionEquipmentName));'
  ''
  'CREATE TABLE Session('
  '  DateTimestamp INTEGER NOT NULL,'
  '  ExerciseName TEXT NOT NULL,'
  '  ExerciseLeaningPositionName TEXT NOT NULL,'
  '  ExerciseLeaningPositionEquipmentName TEXT,'
  '  Description TEXT,'
  '  FOREIGN KEY(ExerciseName, ExerciseLeaningPositionName, ExerciseLeaningPositionEquipmentName)'
  '      REFERENCES Exercise(Name, LeaningPositionName, LeaningPositionEquipmentName)'
  '    ON DELETE CASCADE'
  '    ON UPDATE CASCADE,'
  '  PRIMARY KEY(DateTimestamp, ExerciseName, ExerciseLeaningPositionName, ExerciseLeaningPositionEquipmentName));'
  ''
  'CREATE TABLE Performance('
  '  SessionDateTimestamp INTEGER NOT NULL,'
  '  SessionExerciseName TEXT NOT NULL,'
  '  SessionExerciseLeaningPositionName TEXT NOT NULL,'
  '  SessionExerciseLeaningPositionEquipmentName TEXT,'
  '  SetNo INTEGER NOT NULL,'
  '  Reps INTEGER NOT NULL,'
  '  WeightKg REAL,'
  '  Description TEXT,'
  '  FOREIGN KEY(SessionDateTimestamp, SessionExerciseName, SessionExerciseLeaningPositionName,'
  '      SessionExerciseLeaningPositionEquipmentName) REFERENCES Session(DateTimestamp, ExerciseName,'
  '      ExerciseLeaningPositionName, ExerciseLeaningPositionEquipmentName)'
  '    ON DELETE CASCADE'
  '    ON UPDATE CASCADE,'
  '  PRIMARY KEY(SessionDateTimestamp, SessionExerciseName, SessionExerciseLeaningPositionName,'
  '      SessionExerciseLeaningPositionEquipmentName, SetNo))'
  ''
  ;
 
Future<Database> getDatabase() async {
  return openDatabase(
    await getDatabaseFilePath(),
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

Future<void> closeDatabase(Database database) {
  return database.close();
}

Future<String> getDatabaseFilePath() async {
  return join(await getDatabasesPath(), 'wolog.db');
}