import 'package:wolog/database/table/mappable_entity.dart';

class Exercise implements MappableEntity {
  static const String nameKey = "Name";
  static const String leaningPositionNameKey = "LeaningPositionName";
  static const String leaningPositionEquipmentNameKey = "LeaningPositionEquipmentName";
  static const String iconNameKey = "IconName";
  static const String descriptionKey = "Description";
  
  final String name;
  final String leaningPositionName;
  final String? leaningPositionEquipmentName;
  final String? iconName;
  final String? description;

  const Exercise({
    required this.name,
    required this.leaningPositionName,
    required this.leaningPositionEquipmentName,
    required this.iconName,
    required this.description
  });

  Exercise.fromMap(Map<String, Object?> m) :
    name = m[nameKey] as String,
    leaningPositionName = m[leaningPositionNameKey] as String,
    leaningPositionEquipmentName = m[leaningPositionEquipmentNameKey] as String,
    iconName = m[iconNameKey] as String,
    description = m[descriptionKey] as String;
   
  @override
  List<String> getPrimaryKeyInMap() {
    return [ nameKey, leaningPositionNameKey, leaningPositionEquipmentNameKey ];
  }
  
  @override
  Map<String, Object?> toMap() {
    return {
      nameKey : name,
      leaningPositionNameKey : leaningPositionName,
      leaningPositionEquipmentNameKey : leaningPositionEquipmentName,
      iconNameKey : iconName,
      descriptionKey : description
    };
  }
}

List<Exercise> getExerciseList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => Exercise.fromMap(l[i]));
