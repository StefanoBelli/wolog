import 'package:sqflite/sqflite.dart';

Future<List<Map<String, Object?>>> queryMusclePartFromMain(
    final String mainMuscleName, final Database database) =>
  database.query(
    'MusclePart',
    columns: [ 'Name', 'IconName', 'Description' ],
    where: 'MuscleName = ?',
    whereArgs: [ mainMuscleName ]
  );


Future<List<Map<String, Object?>>> queryInvolvedMusclesNameInExercise(
    final String exerciseName,
    final String? exerciseEquipmentName,
    final String exerciseBodyPositioningName,
    final Database database) {

  final args = [ exerciseName, exerciseBodyPositioningName];
  var remainingEen = 'IS NULL';
  if (exerciseEquipmentName != null) {
    remainingEen = '= ?';
    args.add(exerciseEquipmentName);
  }

  return database.rawQuery('SELECT MuscleName, MusclePartName '
          'FROM ExerciseMuscleInvolvement '
          'WHERE exerciseName = ? AND exerciseBodyPositioningName = ? AND'
          ' exerciseEquipmentName $remainingEen', args);
}