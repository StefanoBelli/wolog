abstract class MappableEntity {
  Map<String, Object?> toMap();
  List<int> getPrimaryKeyIndexesInMap();
}