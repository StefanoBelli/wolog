import 'mappable_entity.dart';

class Muscle implements MappableEntity {
  final String name;
  final bool frontal;
  final bool upperBody;
  final String iconName;
  final String description;

  const Muscle({
    required this.name,
    required this.frontal,
    required this.upperBody,
    required this.iconName,
    required this.description
  });
  
  @override
  Map<String, Object?> toMap() {
    return {
      'Name' : name,
      'Frontal' : frontal,
      'UpperBody' : upperBody,
      'IconName' : iconName,
      'Description' : description
    };
  }
  
  @override
  List<int> getPrimaryKeyIndexesInMap() {
    return [ 0 ];
  }
}