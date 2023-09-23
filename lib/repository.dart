import 'database/operation/query_all.dart';
import 'database/table/exercise.dart';
import 'dbholder.dart';
import 'model/exercise.dart';

class Repository {
  Future<List<ExerciseModel>> fetchAllExercises() async {
    final lst = <ExerciseModel>[];
    getExerciseList(
      await queryAllExercise(DbHolder.getInstance()!.database!))
        .forEach((final e) => lst.add(
          ExerciseModel(
            name: e.name, 
            equipmentName: 
            e.equipmentName, 
            bodyPositioningName: e.bodyPositioningName, 
            iconName: e.iconName, 
            description: e.description)));
    return lst;
  }
}