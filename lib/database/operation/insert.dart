import 'package:wolog/database/table/equipment.dart';
import 'package:wolog/database/table/exercise_muscle_involvement.dart';
import 'package:wolog/database/table/exercise.dart';
import 'package:wolog/database/table/icon.dart';
import 'package:wolog/database/table/leaning_position.dart';
import 'package:wolog/database/table/mappable_entity.dart';
import 'package:wolog/database/table/muscle_part.dart';
import 'package:wolog/database/table/muscle.dart';
import 'package:wolog/database/table/performance.dart';
import 'package:wolog/database/table/session.dart';
import 'package:sqflite/sqflite.dart';

Future<int> _insert(Database database, String tableName, MappableEntity mappableEntity) {
  return database.insert(tableName, mappableEntity.toMap());
}

Future<int> insertEquipment(Database d, Equipment e) => _insert(d, 'Equipment', e);
Future<int> insertExerciseMuscleInvolvement(Database d, ExerciseMuscleInvolvement e) => _insert(d, 'ExerciseMuscleInvolvement', e);
Future<int> insertExercise(Database d, Exercise e) => _insert(d, 'Exercise', e);
Future<int> insertIcon(Database d, Icon e) => _insert(d, 'Icon', e);
Future<int> insertLeaningPosition(Database d, LeaningPosition e) => _insert(d, 'LeaningPosition', e);
Future<int> insertMusclePart(Database d, MusclePart e) => _insert(d, 'MusclePart', e);
Future<int> insertMuscle(Database d, Muscle e) => _insert(d, 'Muscle', e);
Future<int> insertSession(Database d, Session e) => _insert(d, 'Session', e);
Future<int> insertPerformance(Database d, Performance e) => _insert(d, 'Performance', e);