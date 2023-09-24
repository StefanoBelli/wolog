import 'database/operation/query_all.dart';
import 'database/table/exercise.dart';
import 'database/table/icon.dart';
import 'dbholder.dart';
import 'model/exercise.dart';
import 'model/icon.dart';

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

  Future<List<IconModel>> fetchAllIcons() async {
    final lst = <IconModel>[];
    getIconList(
      await queryAllIcon(DbHolder.getInstance()!.database!))
        .forEach((final e) => lst.add(
          IconModel(
            name: e.name, 
            filename: e.filename,
            description: e.description)));
    return lst;
  }
}