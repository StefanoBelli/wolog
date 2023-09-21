import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:wolog/database/database.dart';
import 'package:wolog/database/operation/delete.dart';
import 'package:wolog/database/operation/insert.dart';
import 'package:wolog/database/operation/query_all.dart';
import 'package:wolog/database/operation/update.dart';
import 'package:wolog/database/table/icon.dart';
import 'package:wolog/database/table/body_positioning.dart';
import 'package:wolog/database/table/equipment.dart';
import 'package:wolog/database/table/muscle_part.dart';
import 'package:wolog/database/table/muscle.dart';
import 'package:wolog/database/table/session.dart';
import 'package:wolog/database/table/exercise.dart';
import 'package:wolog/database/table/exercise_muscle_involvement.dart';
import 'package:wolog/database/table/performance.dart';

void main() {
  setUp(() async {
    databaseFactory = databaseFactoryFfi;
    final db = await getDatabase();
    await File(db.path).delete();
    await db.close();
  });

  test('Check database version 1 tables', () async {
    final db = await getDatabase();

    expect(db.isOpen, true);
    expect(await db.getVersion(), 1);
    expect(db.path.split('/').last, 'wolog.db');

    final magicRs = await db.rawQuery('SELECT magic FROM WologMagic;');
    expect(magicRs.length, 1);
    expect(magicRs[0]['magic'], 789456123);

    final masterRs = await db.rawQuery('SELECT tbl_name FROM sqlite_master;');

    final expTblName = { 
      'Equipment': false, 
      'ExerciseMuscleInvolvement': false,
      'Exercise': false,
      'Icon': false,
      'BodyPositioning': false,
      'MusclePart': false,
      'Muscle': false,
      'Session': false,
      'Performance': false
    };

    for(final record in masterRs) {
      expTblName[record['tbl_name']! as String] = true;
    }
    
    expTblName.forEach((final _, final v) => expect(v, true));

    await db.close();
  });

  test('Check queryAll* operations', () async {
    final db = await getDatabase();

    final expQueries = [ 
      queryAllEquipment, 
      queryAllExerciseMuscleInvolvement,
      queryAllExercise,
      queryAllIcon,
      queryAllBodyPositioning,
      queryAllMusclePart,
      queryAllMuscle,
      queryAllSession,
      queryAllPerformance
    ];

    for(final query in expQueries) {
      final rs = await query(db);
      expect(rs.length, 0);
    }

    await db.close();
  });

  test('Check insert*,update*,queryAll* operations', () async{
    final db = await getDatabase();

    {
      final i0 = await insertIcon(db, const Icon(name: 'a', filename: 'b.jpg', description: null));
      expect(i0, 1);

      final i1 = await insertBodyPositioning(db, const BodyPositioning(name: 'a', iconName: null, description: null));
      expect(i1, 1);

      final i2 = await insertEquipment(db, const Equipment(name: 'a', iconName: null, description: null));
      expect(i2, 1);

      final i3 = await insertMuscle(db, const Muscle(name: 'a', frontal: 0, upperBody: 0, iconName: null, description: null));
      expect(i3, 1);

      final i4 = await insertMusclePart(db, const MusclePart(name: null, muscleName: 'a', iconName: null, description: null));
      expect(i4, 1);
    
      final i5 = await insertExercise(db, const Exercise(name: 'a', equipmentName: null, bodyPositioningName: 'a', iconName: null, description: null));
      expect(i5, 1);

      final i6 = await insertExerciseMuscleInvolvement(db, const ExerciseMuscleInvolvement(musclePartName: null, muscleName: 'a', exerciseName: 'a', exerciseEquipmentName: null, exerciseBodyPositioningName: 'a', description: null));
      expect(i6, 1);

      final i7 = await insertSession(db, const Session(dateTimestamp: 0, exerciseName: 'a', exerciseEquipmentName: null, exerciseBodyPositioningName: 'a', description: null));
      expect(i7, 1);

      final i8 = await insertPerformance(db, const Performance(sessionDateTimestamp: 0, sessionExerciseName: 'a', sessionExerciseEquipmentName: null, sessionExerciseBodyPositioningName: 'a', setNo: 0, reps: 0, weightKg: 0, description: null));
      expect(i8, 1);
    }
    
    {
      final i0 = await updateIcon(db, const Icon(name: 'a', filename: 'b.jpg', description: null));
      expect(i0, 1);

      final i1 = await updateBodyPositioning(db, const BodyPositioning(name: 'a', iconName: null, description: null));
      expect(i1, 1);

      final i2 = await updateEquipment(db, const Equipment(name: 'a', iconName: null, description: null));
      expect(i2, 1);

      final i3 = await updateMuscle(db, const Muscle(name: 'a', frontal: 0, upperBody: 0, iconName: null, description: null));
      expect(i3, 1);

      final i4 = await updateMusclePart(db, const MusclePart(name: null, muscleName: 'a', iconName: 'a', description: null));
      expect(i4, 1);

      final i5 = await updateExercise(db, const Exercise(name: 'a', equipmentName: null, bodyPositioningName: 'a', iconName: null, description: 'a cojone'));
      expect(i5, 1);

      final i6 = await updateExerciseMuscleInvolvement(db, const ExerciseMuscleInvolvement(musclePartName: null, muscleName: 'a', exerciseName: 'a', exerciseEquipmentName: null, exerciseBodyPositioningName: 'a', description: null));
      expect(i6, 1);

      final i7 = await updateSession(db, const Session(dateTimestamp: 0, exerciseName: 'a', exerciseEquipmentName: null, exerciseBodyPositioningName: 'a', description: null));
      expect(i7, 1);

      final i8 = await updatePerformance(db, const Performance(sessionDateTimestamp: 0, sessionExerciseName: 'a', sessionExerciseEquipmentName: null, sessionExerciseBodyPositioningName: 'a', setNo: 0, reps: 0, weightKg: 0, description: null));
      expect(i8, 1);
    }

    {
      final i0 = await deleteIcon(db, const Icon(name: 'a', filename: 'b.jpg', description: null));
      expect(i0, 1);

      final i1 = await deleteBodyPositioning(db, const BodyPositioning(name: 'a', iconName: null, description: null));
      expect(i1, 1);

      final i2 = await deleteEquipment(db, const Equipment(name: 'a', iconName: null, description: null));
      expect(i2, 1);

      final i3 = await deleteMuscle(db, const Muscle(name: 'a', frontal: 0, upperBody: 0, iconName: null, description: null));
      expect(i3, 1);

      final i4 = await deleteMusclePart(db, const MusclePart(name: null, muscleName: 'a', iconName: 'a', description: null));
      expect(i4, 1);

      final i5 = await deleteExercise(db, const Exercise(name: 'a', equipmentName: null, bodyPositioningName: 'a', iconName: null, description: 'a cojone'));
      expect(i5, 1);

      final i6 = await deleteExerciseMuscleInvolvement(db, const ExerciseMuscleInvolvement(musclePartName: null, muscleName: 'a', exerciseName: 'a', exerciseEquipmentName: null, exerciseBodyPositioningName: 'a', description: null));
      expect(i6, 1);

      final i7 = await deleteSession(db, const Session(dateTimestamp: 0, exerciseName: 'a', exerciseEquipmentName: null, exerciseBodyPositioningName: 'a', description: null));
      expect(i7, 1);

      final i8 = await deletePerformance(db, const Performance(sessionDateTimestamp: 0, sessionExerciseName: 'a', sessionExerciseEquipmentName: null, sessionExerciseBodyPositioningName: 'a', setNo: 0, reps: 0, weightKg: 0, description: null));
      expect(i8, 1);
    }

    await db.close();
  });

  test('Check insert*,queryAll*,get*List,delete* operations', () async {
    final db = await getDatabase();

    {
      final i0 = await insertIcon(db, const Icon(name: 'a', filename: 'b.jpg', description: null));
      expect(i0, 1);

      final i1 = await insertBodyPositioning(db, const BodyPositioning(name: 'a', iconName: null, description: null));
      expect(i1, 1);

      final i2 = await insertEquipment(db, const Equipment(name: 'a', iconName: null, description: null));
      expect(i2, 1);

      final i3 = await insertMuscle(db, const Muscle(name: 'a', frontal: 0, upperBody: 0, iconName: null, description: null));
      expect(i3, 1);

      final i4 = await insertMusclePart(db, const MusclePart(name: null, muscleName: 'a', iconName: null, description: null));
      expect(i4, 1);
    
      final i5 = await insertExercise(db, const Exercise(name: 'a', equipmentName: null, bodyPositioningName: 'a', iconName: null, description: null));
      expect(i5, 1);

      final i6 = await insertExerciseMuscleInvolvement(db, const ExerciseMuscleInvolvement(musclePartName: null, muscleName: 'a', exerciseName: 'a', exerciseEquipmentName: null, exerciseBodyPositioningName: 'a', description: null));
      expect(i6, 1);

      final i7 = await insertSession(db, const Session(dateTimestamp: 0, exerciseName: 'a', exerciseEquipmentName: null, exerciseBodyPositioningName: 'a', description: null));
      expect(i7, 1);

      final i8 = await insertPerformance(db, const Performance(sessionDateTimestamp: 0, sessionExerciseName: 'a', sessionExerciseEquipmentName: null, sessionExerciseBodyPositioningName: 'a', setNo: 0, reps: 0, weightKg: 0, description: null));
      expect(i8, 1);
    }

    {
      final r0 = await queryAllIcon(db);
      final l0 = getIconList(r0);
      expect(l0.length, 1);
      expect(l0[0].name, 'a');
      expect(l0[0].filename, 'b.jpg');
      expect(l0[0].description, null);

      final r1 = await queryAllBodyPositioning(db);
      final l1 = getBodyPositioningList(r1);
      expect(l1.length, 1);
      expect(l1[0].name, 'a');
      expect(l1[0].iconName, null);
      expect(l1[0].description, null);

      final r2 = await queryAllEquipment(db);
      final l2 = getEquipmentList(r2);
      expect(l2.length, 1);
      expect(l2[0].name, 'a');
      expect(l2[0].iconName, null);
      expect(l2[0].description, null);

      final r3 = await queryAllMuscle(db);
      final l3 = getMuscleList(r3);
      expect(l3.length, 1);
      expect(l3[0].name, 'a');
      expect(l3[0].frontal, 0);
      expect(l3[0].upperBody, 0);
      expect(l3[0].iconName, null);
      expect(l3[0].description, null);

      final r4 = await queryAllMusclePart(db);
      final l4 = getMusclePartList(r4);
      expect(l4.length, 1);
      expect(l4[0].name, null);
      expect(l4[0].muscleName, 'a');
      expect(l4[0].iconName, null);
      expect(l4[0].description, null);

      final r5 = await queryAllExercise(db);
      final l5 = getExerciseList(r5);
      expect(l5.length, 1);
      expect(l5[0].name, 'a');
      expect(l5[0].equipmentName, null);
      expect(l5[0].bodyPositioningName, 'a');
      expect(l5[0].iconName, null);
      expect(l5[0].description, null);

      final r6 = await queryAllExerciseMuscleInvolvement(db);
      final l6 = getExerciseMuscleInvolvementList(r6);
      expect(l6.length, 1);
      expect(l6[0].muscleName, 'a');
      expect(l6[0].musclePartName, null);
      expect(l6[0].exerciseName, 'a');
      expect(l6[0].exerciseEquipmentName, null);
      expect(l6[0].exerciseBodyPositioningName, 'a');
      expect(l6[0].description, null);

      final r7 = await queryAllSession(db);
      final l7 = getSessionList(r7);
      expect(l7.length, 1);
      expect(l7[0].dateTimestamp, 0);
      expect(l7[0].exerciseName, 'a');
      expect(l7[0].exerciseEquipmentName, null);
      expect(l7[0].exerciseBodyPositioningName, 'a');
      expect(l7[0].description, null);

      final r8 = await queryAllPerformance(db); 
      final l8 = getPerformanceList(r8);
      expect(l8.length, 1);
      expect(l8[0].sessionDateTimestamp, 0);
      expect(l8[0].sessionExerciseName, 'a');
      expect(l8[0].sessionExerciseEquipmentName, null);
      expect(l8[0].sessionExerciseBodyPositioningName, 'a');
      expect(l8[0].setNo, 0);
      expect(l8[0].reps, 0);
      expect(l8[0].weightKg, 0);
      expect(l8[0].description, null);
    }

    {
      final i0 = await deleteIcon(db, const Icon(name: 'a', filename: 'b.jpg', description: null));
      expect(i0, 1);

      final i1 = await deleteBodyPositioning(db, const BodyPositioning(name: 'a', iconName: null, description: null));
      expect(i1, 1);

      final i2 = await deleteEquipment(db, const Equipment(name: 'a', iconName: null, description: null));
      expect(i2, 1);

      final i3 = await deleteMuscle(db, const Muscle(name: 'a', frontal: 0, upperBody: 0, iconName: null, description: null));
      expect(i3, 1);

      final i4 = await deleteMusclePart(db, const MusclePart(name: null, muscleName: 'a', iconName: 'a', description: null));
      expect(i4, 1);

      final i5 = await deleteExercise(db, const Exercise(name: 'a', equipmentName: null, bodyPositioningName: 'a', iconName: null, description: 'a cojone'));
      expect(i5, 1);

      final i6 = await deleteExerciseMuscleInvolvement(db, const ExerciseMuscleInvolvement(musclePartName: null, muscleName: 'a', exerciseName: 'a', exerciseEquipmentName: null, exerciseBodyPositioningName: 'a', description: null));
      expect(i6, 1);

      final i7 = await deleteSession(db, const Session(dateTimestamp: 0, exerciseName: 'a', exerciseEquipmentName: null, exerciseBodyPositioningName: 'a', description: null));
      expect(i7, 1);

      final i8 = await deletePerformance(db, const Performance(sessionDateTimestamp: 0, sessionExerciseName: 'a', sessionExerciseEquipmentName: null, sessionExerciseBodyPositioningName: 'a', setNo: 0, reps: 0, weightKg: 0, description: null));
      expect(i8, 1);
    }

    await db.close();
  });
}