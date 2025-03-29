// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Food {
  final int id;
  final String name;
  final String description;
  final double fat;
  final double protein;
  final double carbohydrates;
  final double calories;
  final bool isGood;
  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.fat,
    required this.protein,
    required this.carbohydrates,
    required this.calories,
    required this.isGood,
  });

  Food copyWith({
    int? id,
    String? name,
    String? description,
    double? fat,
    double? protein,
    double? carbohydrates,
    double? calories,
    bool? isGood,
  }) {
    return Food(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      fat: fat ?? this.fat,
      protein: protein ?? this.protein,
      carbohydrates: carbohydrates ?? this.carbohydrates,
      calories: calories ?? this.calories,
      isGood: isGood ?? this.isGood,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'fat': fat,
      'protein': protein,
      'carbohydrates': carbohydrates,
      'calories': calories,
      'isGood': isGood,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      fat: map['fat'] as double,
      protein: map['protein'] as double,
      carbohydrates: map['carbohydrates'] as double,
      calories: map['calories'] as double,
      isGood: map['isGood'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Food.fromJson(String source) => Food.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Food(id: $id, name: $name, description: $description, fat: $fat, protein: $protein, carbohydrates: $carbohydrates, calories: $calories, isGood: $isGood)';
  }

  @override
  bool operator ==(covariant Food other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.fat == fat &&
      other.protein == protein &&
      other.carbohydrates == carbohydrates &&
      other.calories == calories &&
      other.isGood == isGood;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      fat.hashCode ^
      protein.hashCode ^
      carbohydrates.hashCode ^
      calories.hashCode ^
      isGood.hashCode;
  }
}
