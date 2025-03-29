// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fructissimo/src/feature/main/model/ingredient.dart';

class Shopping {
  String id;
  Ingredient ingredient;
  Shopping({
    required this.id,
    required this.ingredient,
  });

  Shopping copyWith({
    String? id,
    Ingredient? ingredient,
  }) {
    return Shopping(
      id: id ?? this.id,
      ingredient: ingredient ?? this.ingredient,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ingredient': ingredient.toMap(),
    };
  }

  factory Shopping.fromMap(Map<String, dynamic> map) {
    return Shopping(
      id: map['id'] as String,
      ingredient: Ingredient.fromMap(map['ingredient'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Shopping.fromJson(String source) => Shopping.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Shopping(id: $id, ingredient: $ingredient)';

  @override
  bool operator ==(covariant Shopping other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.ingredient == ingredient;
  }

  @override
  int get hashCode => id.hashCode ^ ingredient.hashCode;
}
