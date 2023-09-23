import '../database/operation/query_all.dart';
import '../database/table/exercise.dart';
import '../dbholder.dart';

class ExerciseRepository {
  Future<List<Exercise>> fetchAll() async => 
    getExerciseList(
      await queryAllExercise(DbHolder.getInstance()!.database!));
}