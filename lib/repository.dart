import 'dart:async';

import 'package:tuple/tuple.dart';

import 'database/operation/query.dart';
import 'database/operation/query_all.dart';
import 'database/table/body_positioning.dart';
import 'database/table/equipment.dart';
import 'database/table/exercise.dart';
import 'database/table/icon.dart';
import 'database/table/muscle.dart';
import 'database/table/muscle_part.dart';
import 'dbholder.dart';
import 'model/body_positioning.dart';
import 'model/equipment.dart';
import 'model/exercise.dart';
import 'model/icon.dart';
import 'model/muscle.dart';
import 'model/muscle_part.dart';

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

  Future<List<EquipmentModel>> fetchAllEquipments() async {
    final lst = <EquipmentModel>[];
    getEquipmentList(
      await queryAllEquipment(DbHolder.getInstance()!.database!))
        .forEach((final e) => lst.add(
          EquipmentModel(
            name: e.name,
            iconName: e.iconName,
            description: e.description)));
    return lst;
  }

  Future<List<BodyPositioningModel>> fetchAllBodyPositionings() async {
    final lst = <BodyPositioningModel>[];
    getBodyPositioningList(
      await queryAllBodyPositioning(DbHolder.getInstance()!.database!))
        .forEach((final e) => lst.add(
          BodyPositioningModel(
            name: e.name,
            iconName: e.iconName,
            description: e.description)));
    return lst;
  }

  Future<List<MuscleModel>> fetchAllMuscles() async {
    final lst = <MuscleModel>[];
    getMuscleList(await queryAllMuscle(DbHolder.getInstance()!.database!))
          .forEach((final e) async {
            List<MusclePartModel>? partLst;
            final partTableLst = getMusclePartList(
              await queryMusclePartFromMain(
                e.name, DbHolder.getInstance()!.database!));

            if(partTableLst.length > 1) {
              partLst = <MusclePartModel>[];
              for (final e in partTableLst) {
                partLst.add(MusclePartModel(
                    name: e.name!,
                    iconName: e.iconName,
                    description: e.description));
              }
            }

            lst.add(MuscleModel(
              name: e.name,
              upperBody: e.upperBody as bool,
              frontal: e.frontal as bool,
              iconName: e.iconName,
              description: e.description,
              muscleParts: partLst));
          });

    return lst;
  }

  Future<List<Tuple2<String,String?>>> fetchMusclesInvolvedInExercise(
      final ExerciseModel exerciseModel) async {
    final lst = <Tuple2<String, String?>>[];
    final lstMapped = await queryInvolvedMusclesNameInExercise(
        exerciseModel.name,
        exerciseModel.equipmentName,
        exerciseModel.bodyPositioningName,
        DbHolder.getInstance()!.database!);

    for(final map in lstMapped) {
      lst.add(Tuple2<String,String?>(
          map['MuscleName']! as String, map['MusclePartName'] as String?));
    }

    return lst;
  }

  Future<List<Tuple2<String,String?>>> fetchMusclesInvolvedInExerciseByName(
      final String exerciseName,
      final String? exerciseEquipmentName,
      final String exerciseBodyPositioningName) async =>
        fetchMusclesInvolvedInExercise(ExerciseModel(
          name: exerciseName,
          equipmentName: exerciseEquipmentName,
          bodyPositioningName: exerciseBodyPositioningName,
          iconName: null,
          description: null));
}