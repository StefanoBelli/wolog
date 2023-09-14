import 'package:sqflite/sqflite.dart';

Future<List<Map<String, Object?>>> _queryAllObject(Database database, String tableName) {
  return database.query(tableName);
}

Future<List<Map<String, Object?>>> queryAllEquipment(Database database) => _queryAllObject(database, 'Equipment');
Future<List<Map<String, Object?>>> queryAllExerciseMuscleInvolvement(Database database) => _queryAllObject(database, 'ExerciseMuscleInvolvement');
Future<List<Map<String, Object?>>> queryAllExercise(Database database) => _queryAllObject(database, 'Exercise');
Future<List<Map<String, Object?>>> queryAllIcon(Database database) => _queryAllObject(database, 'Icon');
Future<List<Map<String, Object?>>> queryAllBodyPositioning(Database database) => _queryAllObject(database, 'BodyPositioning');
Future<List<Map<String, Object?>>> queryAllMusclePart(Database database) => _queryAllObject(database, 'MusclePart');
Future<List<Map<String, Object?>>> queryAllMuscle(Database database) => _queryAllObject(database, 'Muscle');
Future<List<Map<String, Object?>>> queryAllSession(Database database) => _queryAllObject(database, 'Session');
Future<List<Map<String, Object?>>> queryAllPerformance(Database database) => _queryAllObject(database, 'Performance');