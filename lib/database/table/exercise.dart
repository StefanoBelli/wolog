import 'package:wolog/database/table/mappable_entity.dart';

class Exercise implements MappableEntity {
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

  Exercise.fromMap(Map<String, Object?> map) :
    name = map['Name'] as String,
    leaningPositionName = map['LeaningPositionName'] as String,
    leaningPositionEquipmentName = map['LeaningPositionEquipmentName'] as String,
    iconName = map['IconName'] as String,
    description = map['Description'] as String;
  
  @override
  Map<String, Object?> toMap() {
    return {
      'Name' : name,
      'LeaningPositionName' : leaningPositionName,
      'LeaningPositionEquipmentName' : leaningPositionEquipmentName,
      'IconName' : iconName,
      'Description' : description
    };
  }
  
  @override
  List<String> getPrimaryKeyInMap() {
    return [ 'Name', 'LeaningPositionName', 'LeaningPositionEquipmentName' ];
  }
}

List<Exercise> getExerciseList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => Exercise.fromMap(l[i]));
