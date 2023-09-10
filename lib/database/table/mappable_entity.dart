abstract class MappableEntity {
  Map<String, Object?> toMap();
  List<String> getPrimaryKeyInMap();
}