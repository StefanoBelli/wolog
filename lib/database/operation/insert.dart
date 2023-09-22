import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../table/equipment.dart';
import '../table/exercise_muscle_involvement.dart';
import '../table/exercise.dart';
import '../table/icon.dart';
import '../table/body_positioning.dart';
import '../table/mappable_entity.dart';
import '../table/muscle_part.dart';
import '../table/muscle.dart';
import '../table/performance.dart';
import '../table/session.dart';

Future<int> _insert(final Database database, final String tableName, final MappableEntity mappableEntity) => 
  database.insert(tableName, mappableEntity.toMap());

Future<int> insertEquipment(final Database d, final Equipment e) => _insert(d, 'Equipment', e);
Future<int> insertExerciseMuscleInvolvement(final Database d, final ExerciseMuscleInvolvement e) => _insert(d, 'ExerciseMuscleInvolvement', e);
Future<int> insertExercise(final Database d, final Exercise e) => _insert(d, 'Exercise', e);
Future<int> insertIcon(final Database d, final Icon e) => _insert(d, 'Icon', e);
Future<int> insertBodyPositioning(final Database d, final BodyPositioning e) => _insert(d, 'BodyPositioning', e);
Future<int> insertMusclePart(final Database d, final MusclePart e) => _insert(d, 'MusclePart', e);
Future<int> insertMuscle(final Database d, final Muscle e) => _insert(d, 'Muscle', e);
Future<int> insertSession(final Database d, final Session e) => _insert(d, 'Session', e);
Future<int> insertPerformance(final Database d, final Performance e) => _insert(d, 'Performance', e);