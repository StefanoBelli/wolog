import 'muscle_part.dart';

class MuscleModel {
  String name;
  bool upperBody;
  bool frontal;
  String? iconName;
  String? description;
  List<MusclePartModel>? muscleParts;

  MuscleModel({
    required this.name,
    required this.upperBody,
    required this.frontal,
    required this.iconName,
    required this.description,
    required this.muscleParts
  });
}