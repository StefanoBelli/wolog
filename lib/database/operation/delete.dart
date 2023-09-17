import 'common.dart';
import '../table/equipment.dart';
import '../table/exercise_muscle_involvement.dart';
import '../table/exercise.dart';
import '../table/icon.dart';
import '../table/body_positioning.dart';
import '../table/muscle_part.dart';
import '../table/muscle.dart';
import '../table/performance.dart';
import '../table/mappable_entity.dart';
import '../table/session.dart';
import 'package:sqflite/sqflite.dart';

Future<int> _delete(final Database database, final String tableName, final MappableEntity mappableEntity) => 
  database.delete(
    tableName, 
    where: getWhereClause(mappableEntity),
    whereArgs: getWhereArgs(mappableEntity)
  );

Future<int> deleteEquipment(final Database d, final Equipment e) => _delete(d, 'Equipment', e);
Future<int> deleteExerciseMuscleInvolvement(final Database d, final ExerciseMuscleInvolvement e) => _delete(d, 'ExerciseMuscleInvolvement', e);
Future<int> deleteExercise(final Database d, final Exercise e) => _delete(d, 'Exercise', e);
Future<int> deleteIcon(final Database d, final Icon e) => _delete(d, 'Icon', e);
Future<int> deleteBodyPositioning(final Database d, final BodyPositioning e) => _delete(d, 'BodyPositioning', e);
Future<int> deleteMusclePart(final Database d, final MusclePart e) => _delete(d, 'MusclePart', e);
Future<int> deleteMuscle(final Database d, final Muscle e) => _delete(d, 'Muscle', e);
Future<int> deleteSession(final Database d, final Session e) => _delete(d, 'Session', e);
Future<int> deletePerformance(final Database d, final Performance e) => _delete(d, 'Performance', e);
