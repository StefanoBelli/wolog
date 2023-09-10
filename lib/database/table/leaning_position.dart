import 'package:wolog/database/table/mappable_entity.dart';

class LeaningPosition implements MappableEntity {
  final String name;
  final String equipmentName;
  final String iconName;
  final String description;

  const LeaningPosition({
    required this.name,
    required this.equipmentName,
    required this.iconName,
    required this.description
  });
  
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
  List<int> getPrimaryKeyIndexesInMap() {
    return [ 0, 1 ];
  }
}