// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fructissimo/src/feature/main/model/ingredient.dart';

class Storage {
  final String id;
  final DateTime date;
  final Ingredient ingredient;
  Storage({
    required this.id,
    required this.date,
    required this.ingredient,
  });

  Storage copyWith({
    String? id,
    DateTime? date,
    Ingredient? ingredient,
  }) {
    return Storage(
      id: id ?? this.id,
      date: date ?? this.date,
      ingredient: ingredient ?? this.ingredient,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'ingredient': ingredient.toMap(),
    };
  }

  factory Storage.fromMap(Map<String, dynamic> map) {
    return Storage(
      id: map['id'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      ingredient: Ingredient.fromMap(map['ingredient'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Storage.fromJson(String source) =>
      Storage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Storage(id: $id, date: $date, ingredient: $ingredient)';

  @override
  bool operator ==(covariant Storage other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.date == date &&
        other.ingredient == ingredient;
  }

  @override
  int get hashCode => id.hashCode ^ date.hashCode ^ ingredient.hashCode;
}
