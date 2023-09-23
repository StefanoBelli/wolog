abstract class MappableTable {
  Map<String, Object?> toMap();
  List<String> getPrimaryKeyInMap();
}