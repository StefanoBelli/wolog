import 'package:wolog/database/operation/common.dart';
import 'package:wolog/database/table/equipment.dart';
import 'package:wolog/database/table/exercise_muscle_involvement.dart';
import 'package:wolog/database/table/exercise.dart';
import 'package:wolog/database/table/icon.dart';
import 'package:wolog/database/table/leaning_position.dart';
import 'package:wolog/database/table/muscle_part.dart';
import 'package:wolog/database/table/muscle.dart';
import 'package:wolog/database/table/performance.dart';
import 'package:wolog/database/table/mappable_entity.dart';
import 'package:sqflite/sqflite.dart';

Future<int> _update(Database database, String tableName, MappableEntity mappableEntity) {
  return database.update(
    tableName, 
    mappableEntity.toMap(), 
    where: getWhereClause(mappableEntity),
    whereArgs: getWhereArgs(mappableEntity)
  );
}

Future<int> updateEquipment(Database d, Equipment e) => _update(d, 'Equipment', e);
Future<int> updateExerciseMuscleInvolvement(Database d, ExerciseMuscleInvolvement e) => _update(d, 'ExerciseMuscleInvolvement', e);
Future<int> updateExercise(Database d, Exercise e) => _update(d, 'Exercise', e);
Future<int> updateIcon(Database d, Icon e) => _update(d, 'Icon', e);
Future<int> updateLeaningPosition(Database d, LeaningPosition e) => _update(d, 'LeaningPosition', e);
Future<int> updateMusclePart(Database d, MusclePart e) => _update(d, 'MusclePart', e);
Future<int> updateMuscle(Database d, Muscle e) => _update(d, 'Muscle', e);
Future<int> updatePerformance(Database d, Performance e) => _update(d, 'Performance', e);