// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fructissimo/src/feature/main/model/ingredient.dart';
import 'package:flutter/foundation.dart';

class Recipe {
  final int id;
  final String name;
  final String description;
  final List<Step> steps;
  final List<Ingredient> ingredients;
  final String image;
  final String category;

  // Храним общую калорийность всего блюда (kcal на всю порцию)
  final double calories;

  // Храним содержание макронутриентов (на всю порцию)
  final double fat; // грамм жиров
  final double protein; // грамм белков
  final double carbohydrates; // грамм углеводов
  

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.steps,
    required this.ingredients,
    required this.image,
    required this.category,
    required this.calories,
    required this.fat,
    required this.protein,
    required this.carbohydrates,
  });

  Recipe copyWith({
    int? id,
    String? name,
    String? description,
    List<Step>? steps,
    List<Ingredient>? ingredients,
    String? image,
    String? category,
    double? calories,
    double? fat,
    double? protein,
    double? carbohydrates,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      steps: steps ?? this.steps,
      ingredients: ingredients ?? this.ingredients,
      image: image ?? this.image,
      category: category ?? this.category,
      calories: calories ?? this.calories,
      fat: fat ?? this.fat,
      protein: protein ?? this.protein,
      carbohydrates: carbohydrates ?? this.carbohydrates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'steps': steps.map((x) => x.toMap()).toList(),
      'ingredients': ingredients.map((x) => x.toMap()).toList(),
      'image': image,
      'category': category,
      'calories': calories,
      'fat': fat,
      'protein': protein,
      'carbohydrates': carbohydrates,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      steps: List<Step>.from((map['steps'] as List<dynamic>).map<Step>((x) => Step.fromMap(x as Map<String,dynamic>),),),
      ingredients: List<Ingredient>.from((map['ingredients'] as List<dynamic>).map<Ingredient>((x) => Ingredient.fromMap(x as Map<String,dynamic>),),),
      image: map['image'] as String,
      category: map['category'] as String,
      calories: map['calories'] as double,
      fat: map['fat'] as double,
      protein: map['protein'] as double,
      carbohydrates: map['carbohydrates'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) =>
      Recipe.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Recipe(id: $id, name: $name, description: $description, steps: $steps, ingredients: $ingredients, image: $image, category: $category, calories: $calories, fat: $fat, protein: $protein, carbohydrates: $carbohydrates)';
  }

  @override
  bool operator ==(covariant Recipe other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      listEquals(other.steps, steps) &&
      listEquals(other.ingredients, ingredients) &&
      other.image == image &&
      other.category == category &&
      other.calories == calories &&
      other.fat == fat &&
      other.protein == protein &&
      other.carbohydrates == carbohydrates;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      steps.hashCode ^
      ingredients.hashCode ^
      image.hashCode ^
      category.hashCode ^
      calories.hashCode ^
      fat.hashCode ^
      protein.hashCode ^
      carbohydrates.hashCode;
  }
}
