import 'package:wolog/database/table/mappable_entity.dart';

class MusclePart implements MappableEntity {
  final String name;
  final String muscleName;
  final String iconName;
  final String description;

  const MusclePart({
    required this.name,
    required this.muscleName,
    required this.iconName,
    required this.description
  });
  
  @override
  Map<String, Object?> toMap() {
    return {
      'Name' : name,
      'MuscleName' : muscleName,
      'IconName' : iconName,
      'Description' : description
    };
  }
  
  @override
  List<int> getPrimaryKeyIndexesInMap() {
    return [ 0, 1 ];
  }
}