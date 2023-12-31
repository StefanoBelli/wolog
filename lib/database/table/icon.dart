import 'mappable_table.dart';

class Icon implements MappableTable {
  static const String nameKey = 'Name';
  static const String filenameKey = 'Filename';
  static const String descriptionKey = 'Description';

  final String name;
  final String filename;
  final String? description;

  const Icon({
    required this.name,
    required this.filename,
    required this.description
  });

  Icon.fromMap(final Map<String, Object?> m) :
    name = m[nameKey]! as String,
    filename = m[filenameKey]! as String,
    description = m[descriptionKey] as String?;
    
  @override
  List<String> getPrimaryKeyInMap() => 
    [ 
      nameKey 
    ];

  @override
  Map<String, Object?> toMap() => 
    {
      nameKey : name,
      filenameKey : filename,
      descriptionKey : description
    };
}

List<Icon> getIconList(final List<Map<String, Object?>> l) 
  => List.generate(l.length, (final i) => Icon.fromMap(l[i]));
