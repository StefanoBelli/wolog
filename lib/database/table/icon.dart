import 'package:wolog/database/table/mappable_entity.dart';

class Icon implements MappableEntity {
  final String name;
  final String filename;
  final String description;

  const Icon({
    required this.name,
    required this.filename,
    required this.description
  });
  
  @override
  Map<String, Object?> toMap() {
    return {
      'Name' : name,
      'Filename' : filename,
      'Description' : description
    };
  }
  
  @override
  List<int> getPrimaryKeyIndexesInMap() {
    return [ 0 ];
  }

}