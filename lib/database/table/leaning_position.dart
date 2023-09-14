import 'package:wolog/database/table/mappable_entity.dart';

class LeaningPosition implements MappableEntity {
  static const String nameKey = "Name";
  static const String equipmentNameKey = "EquipmentName";
  static const String iconNameKey = "IconName";
  static const String descriptionKey = "Description";

  final String name;
  final String? equipmentName;
  final String? iconName;
  final String? description;

  const LeaningPosition({
    required this.name,
    required this.equipmentName,
    required this.iconName,
    required this.description
  });

  LeaningPosition.fromMap(Map<String, Object?> m) :
    name = m[nameKey] as String,
    equipmentName = m[equipmentNameKey] as String,
    iconName = m[iconNameKey] as String,
    description = m[descriptionKey] as String;
    
  @override
  List<String> getPrimaryKeyInMap() {
    return [ nameKey, equipmentNameKey ];
  }

  @override
  Map<String, Object?> toMap() {
    return {
      nameKey : name,
      equipmentNameKey : equipmentName,
      iconNameKey : iconName,
      descriptionKey : description
    };
  }
}

List<LeaningPosition> getLeaningPositionList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => LeaningPosition.fromMap(l[i]));
