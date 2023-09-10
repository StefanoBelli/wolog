import 'package:wolog/database/table/mappable_entity.dart';

class Icon implements MappableEntity {
  final String name;
  final String filename;
  final String? description;

  const Icon({
    required this.name,
    required this.filename,
    required this.description
  });

  Icon.fromMap(Map<String, Object?> map) :
    name = map['Name'] as String,
    filename = map['Filename'] as String,
    description = map['Description'] as String;

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

List<Icon> getIconList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => Icon.fromMap(l[i]));
