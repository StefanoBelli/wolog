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

Future<int> _delete(Database database, String tableName, MappableEntity mappableEntity) {
  return database.delete(
    tableName, 
    where: getWhereClause(mappableEntity),
    whereArgs: getWhereArgs(mappableEntity)
  );
}

Future<int> deleteEquipment(Database d, Equipment e) => _delete(d, 'Equipment', e);
Future<int> deleteExerciseMuscleInvolvement(Database d, ExerciseMuscleInvolvement e) => _delete(d, 'ExerciseMuscleInvolvement', e);
Future<int> deleteExercise(Database d, Exercise e) => _delete(d, 'Exercise', e);
Future<int> deleteIcon(Database d, Icon e) => _delete(d, 'Icon', e);
Future<int> deleteLeaningPosition(Database d, LeaningPosition e) => _delete(d, 'LeaningPosition', e);
Future<int> deleteMusclePart(Database d, MusclePart e) => _delete(d, 'MusclePart', e);
Future<int> deleteMuscle(Database d, Muscle e) => _delete(d, 'Muscle', e);
Future<int> deletePerformance(Database d, Performance e) => _delete(d, 'Performance', e);