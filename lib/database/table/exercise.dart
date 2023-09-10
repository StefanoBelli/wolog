import 'package:wolog/database/table/mappable_entity.dart';

class Exercise implements MappableEntity {
  final String name;
  final String leaningPositionName;
  final String iconName;
  final String description;

  const Exercise({
    required this.name,
    required this.leaningPositionName,
    required this.iconName,
    required this.description
  });
  
  @override
  Map<String, Object?> toMap() {
    return {
      'Name' : name,
      'LeaningPositionName' : leaningPositionName,
      'IconName' : iconName,
      'Description' : description
    };
  }
  
  @override
  List<int> getPrimaryKeyIndexesInMap() {
    return [ 0 ];
  }
}