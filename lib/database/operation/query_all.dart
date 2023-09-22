import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<List<Map<String, Object?>>> _queryAllObject(final Database database, final String tableName) => 
  database.query(tableName);

Future<List<Map<String, Object?>>> queryAllEquipment(final Database database) => _queryAllObject(database, 'Equipment');
Future<List<Map<String, Object?>>> queryAllExerciseMuscleInvolvement(final Database database) => _queryAllObject(database, 'ExerciseMuscleInvolvement');
Future<List<Map<String, Object?>>> queryAllExercise(final Database database) => _queryAllObject(database, 'Exercise');
Future<List<Map<String, Object?>>> queryAllIcon(final Database database) => _queryAllObject(database, 'Icon');
Future<List<Map<String, Object?>>> queryAllBodyPositioning(final Database database) => _queryAllObject(database, 'BodyPositioning');
Future<List<Map<String, Object?>>> queryAllMusclePart(final Database database) => _queryAllObject(database, 'MusclePart');
Future<List<Map<String, Object?>>> queryAllMuscle(final Database database) => _queryAllObject(database, 'Muscle');
Future<List<Map<String, Object?>>> queryAllSession(final Database database) => _queryAllObject(database, 'Session');
Future<List<Map<String, Object?>>> queryAllPerformance(final Database database) => _queryAllObject(database, 'Performance');