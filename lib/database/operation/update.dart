import 'common.dart';
import '../table/equipment.dart';
import '../table/exercise_muscle_involvement.dart';
import '../table/exercise.dart';
import '../table/icon.dart';
import '../table/body_positioning.dart';
import '../table/muscle_part.dart';
import '../table/muscle.dart';
import '../table/performance.dart';
import '../table/mappable_table.dart';
import '../table/session.dart';
import 'package:sqflite/sqflite.dart';

Future<int> _update(final Database database, final String tableName, final MappableTable mappableEntity) => 
  database.update(
    tableName, 
    mappableEntity.toMap(), 
    where: getWhereClause(mappableEntity),
    whereArgs: getWhereArgs(mappableEntity)
  );

Future<int> updateEquipment(final Database d, final Equipment e) => _update(d, 'Equipment', e);
Future<int> updateExerciseMuscleInvolvement(final Database d, final ExerciseMuscleInvolvement e) => _update(d, 'ExerciseMuscleInvolvement', e);
Future<int> updateExercise(final Database d, final Exercise e) => _update(d, 'Exercise', e);
Future<int> updateIcon(final Database d, final Icon e) => _update(d, 'Icon', e);
Future<int> updateBodyPositioning(final Database d, final BodyPositioning e) => _update(d, 'BodyPositioning', e);
Future<int> updateMusclePart(final Database d, final MusclePart e) => _update(d, 'MusclePart', e);
Future<int> updateMuscle(final Database d, final Muscle e) => _update(d, 'Muscle', e);
Future<int> updateSession(final Database d, final Session e) => _update(d, 'Session', e);
Future<int> updatePerformance(final Database d, final Performance e) => _update(d, 'Performance', e);