import 'package:sqflite/sqflite.dart';

const String ddlStmts =
  ''
  'CREATE TABLE Icon('
  '  Name TEXT PRIMARY KEY NOT NULL,'
  '  Filename TEXT UNIQUE NOT NULL,'
  '  Description TEXT);'
  ''
  'CREATE TABLE Equipment('
  '  Name TEXT PRIMARY KEY NOT NULL,'
  '  FOREIGN KEY(IconName) REFERENCES Icon(Name)'
  '    ON DELETE SET NULL'
  '    ON UPDATE CASCADE,'
  '  Description TEXT);'
  ''
  'CREATE TABLE Muscle('
  '  Name TEXT PRIMARY KEY NOT NULL,'
  '  Frontal INTEGER NOT NULL,'
  '  UpperBody INTEGER NOT NULL,'
  '  FOREIGN KEY(IconName) REFERENCES Icon(Name)'
  '    ON DELETE SET NULL'
  '    ON UPDATE CASCADE'
  '  Description TEXT);'
  ''
  'CREATE TABLE MusclePart('
  '  Name TEXT,'
  '  FOREIGN KEY(MuscleName) REFERENCES Muscle(Name)'
  '    ON DELETE RESTRICT'
  '    ON UPDATE RESTRICT,'
  '  FOREIGN KEY(IconName) REFERENCES Icon(Name)'
  '    ON DELETE SET NULL'
  '    ON UPDATE CASCADE,'
  '  Description TEXT,'
  '  PRIMARY KEY(Name, MuscleName)'
  ');'
  ''
  'CREATE TABLE LeaningPosition('
  '  Name TEXT,'
  '  FOREIGN KEY(EquipmentName) REFERENCES Equipment(Name)'
  '    ON DELETE RESTRICT'
  '    ON UPDATE RESTRICT,'
  '  FOREIGN KEY(IconName) REFERENCES Icon(Name)'
  '    ON DELETE SET NULL'
  '    ON UPDATE CASCADE,'
  '  Description TEXT,'
  '  PRIMARY KEY(Name, EquipmentName)'
  ');'
  ''
  'CREATE TABLE Excercise('
  '  Name TEXT PRIMARY KEY NOT NULL,'
  '  FOREIGN KEY(LeaningPositionName, EquipmentName) REFERENCES LeaningPosition(Name, EquipmentName)'
  '    ON DELETE CASCADE'
  '    ON UPDATE CASCADE,'
  '  FOREIGN KEY(IconName) REFERENCES Icon(Name)'
  '    ON DELETE SET NULL'
  '    ON UPDATE CASCADE,'
  '  Description TEXT'
  ');'
  ''
  'CREATE TABLE ExerciseMuscleInvolvement('
  '  FOREIGN KEY(MusclePartName, MuscleName) REFERENCES MusclePart(Name, MuscleName)'
  '    ON DELETE CASCADE'
  '    ON UPDATE CASCADE,'
  '  FOREIGN KEY(ExerciseName) REFERENCES Exercise(Name)'
  '    ON DELETE CASCADE'
  '    ON UPDATE CASCADE,'
  '  Description TEXT,'
  '  PRIMARY KEY(MusclePartName, MuscleName, ExerciseName)'
  ');'
  ''
  'CREATE TABLE Performance('
  '  FOREIGN KEY(ExerciseName) REFERENCES Exercise(Name)'
  '    ON DELETE CASCADE'
  '    ON UPDATE CASCADE,'
  '  Timestamp INTEGER NOT NULL,'
  '  Sets INTEGER NOT NULL,'
  '  Reps INTEGER NOT NULL,'
  '  Description TEXT,'
  '  PRIMARY KEY(ExerciseName, Timestamp)'
  ');'
  ;
 
Future<Database> getDatabase(String dbPath) {
  return openDatabase(
    dbPath,
    onCreate: (db, ver) {
      return db.execute(ddlStmts);
    },
    version: 1
  );
}

Future<void> closeDatabase(Database database) {
  return database.close();
}