import 'package:wolog/database/table/mappable_entity.dart';

class LeaningPosition implements MappableEntity {
  final String name;
  final String equipmentName;
  final String? iconName;
  final String? description;

  const LeaningPosition({
    required this.name,
    required this.equipmentName,
    required this.iconName,
    required this.description
  });

  LeaningPosition.fromMap(Map<String, Object?> map) :
    name = map['Name'] as String,
    equipmentName = map['EquipmentName'] as String,
    iconName = map['IconName'] as String,
    description = map['Description'] as String;

  @override
  Map<String, Object?> toMap() {
    return {
      'Name' : name,
      'EquipmentName' : equipmentName,
      'IconName' : iconName,
      'Description' : description
    };
  }
  
  @override
  List<String> getPrimaryKeyInMap() {
    return [ 'Name', 'EquipmentName' ];
  }
}

List<LeaningPosition> getLeaningPositionList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => LeaningPosition.fromMap(l[i]));
