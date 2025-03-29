// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Ingredient {
  final int id;
  final String name;
  final double quantity;

  Ingredient({
    required this.id,
    required this.name,
    required this.quantity,
  });

  Ingredient copyWith({
    int? id,
    String? name,
    double? quantity,
  }) {
    return Ingredient(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'quantity': quantity,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'] as int,
      name: map['name'] as String,
      quantity: map['quantity'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ingredient.fromJson(String source) =>
      Ingredient.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Ingredient(id: $id, name: $name, quantity: $quantity)';

  @override
  bool operator ==(covariant Ingredient other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.quantity == quantity;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ quantity.hashCode;
}

class Step {
  int minutes;
  String description;
  Step({
    required this.minutes,
    required this.description,
  });

  Step copyWith({
    int? minutes,
    String? description,
  }) {
    return Step(
      minutes: minutes ?? this.minutes,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'minutes': minutes,
      'description': description,
    };
  }

  factory Step.fromMap(Map<String, dynamic> map) {
    return Step(
      minutes: map['minutes'] as int,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Step.fromJson(String source) =>
      Step.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Step(minutes: $minutes, description: $description)';

  @override
  bool operator ==(covariant Step other) {
    if (identical(this, other)) return true;

    return other.minutes == minutes && other.description == description;
  }

  @override
  int get hashCode => minutes.hashCode ^ description.hashCode;
}
