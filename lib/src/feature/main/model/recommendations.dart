// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fructissimo/src/feature/main/model/dog.dart';
import 'package:fructissimo/src/feature/main/model/recipe.dart';

class Recommendations {
  final double dailyCalories; // Рекомендуемая суточная калорийность (ккал)
  final double dailyFat; // Рекомендуемое суточное количество жиров (г)
  final double dailyProtein; // Рекомендуемое суточное количество белков (г)
  final double dailyCarbohydrates;
  final int mealsPerDay; // Сколько раз кормить собаку в сутки

  Recommendations({
    required this.dailyCalories,
    required this.dailyFat,
    required this.dailyProtein,
    required this.dailyCarbohydrates,
    required this.mealsPerDay,
  });

  /// 1. Формула для Resting Energy Requirement (RER):
  ///    RER = 70 * (вес собаки в кг ^ 0.75)
  ///
  /// 2. Maintenance Energy Requirement (MER) — умножаем RER на коэффициент,
  ///    зависящий от возраста и активности:
  ///       - Щенки (age < 1): ~2.5
  ///       - Взрослые (1 <= age < 8): ~1.6
  ///       - Пожилые (age >= 8): ~1.4
  ///    + корректировка на активность (1..5)
  ///    Ниже пример «плавающего» коэффициента для упрощения.
  static double calculateDailyCalories(Dog dog) {
    final double rer = 70 * (dog.weight * 0.75);
    // Или более точно: 70 * math.pow(dog.weight, 0.75)
    // Но для наглядности "dog.weight^(0.75)" можно расписать иначе.

    // Базовый коэффициент в зависимости от возраста
    double baseFactor;
    if (dog.age < 1) {
      baseFactor = 2.5; // для щенков
    } else if (dog.age < 8) {
      baseFactor = 1.6; // взрослые
    } else {
      baseFactor = 1.4; // пожилые
    }

    // Корректировка на активность (условно):
    // Пример: если activity = 3 => без изменений;
    // если больше 3 => увеличиваем, если меньше 3 => уменьшаем
    // Будем добавлять или отнимать 0.1 за каждые +1/-1 от тройки
    final double activityAdjustment = 0.1 * (dog.activity - 3);
    double merFactor = baseFactor + activityAdjustment;

    // Ограничим в разумных пределах (например, от 1.2 до 2.5)
    if (merFactor < 1.2) merFactor = 1.2;
    if (merFactor > 2.5) merFactor = 2.5;

    final dailyCalories = rer * merFactor;
    return dailyCalories;
  }

  /// Сколько раз в день кормить собаку
  static int calculateMealsPerDay(Dog dog) {
    if (dog.age < 1) {
      // Щенка обычно кормят 3 раза
      return 3;
    } else {
      // Взрослых и пожилых — 2 раза
      return 2;
    }
  }

  /// Распределяем БЖУ на весь день по принятым нормам:
  /// Допустим, ~25% калорий из белков, ~15% из жиров, ~60% из углеводов.
  /// Перевести калории в граммы (1 г белка = ~4 ккал, 1 г жира = ~9 ккал, 1 г углеводов = ~4 ккал)
  static Map<String, double> calculateDailyMacros(double dailyCalories) {
    // Например, protein = 25%, fat = 15%, carbs = 60%
    final proteinCals = dailyCalories * 0.25; // 25%
    final fatCals = dailyCalories * 0.15; // 15%
    final carbsCals = dailyCalories * 0.60; // 60%

    // Пересчитываем калории в граммы:
    final proteinGrams = proteinCals / 4.0;
    final fatGrams = fatCals / 9.0;
    final carbsGrams = carbsCals / 4.0;

    return {
      'protein': proteinGrams,
      'fat': fatGrams,
      'carbs': carbsGrams,
    };
  }

  /// Генерация рекомендаций для собаки:
  static Recommendations generateForDog(Dog dog) {
    final dailyCals = calculateDailyCalories(dog);
    final macros = calculateDailyMacros(dailyCals);
    final meals = calculateMealsPerDay(dog);

    return Recommendations(
      dailyCalories: dailyCals,
      dailyFat: macros['fat'] ?? 0.0,
      dailyProtein: macros['protein'] ?? 0.0,
      dailyCarbohydrates: macros['carbs'] ?? 0.0,
      mealsPerDay: meals,
    );
  }

  /// Выбираем рецепты, которые:
  /// - НЕ содержат аллергенов
  /// - Подходят по калорийности под одну порцию (dailyCalories / mealsPerDay),
  ///   учитывая некоторый допуск, например ±20%.
  ///
  /// Возвращает список подходящих рецептов (объектов).
  static List<Recipe> findRecommendedRecipes(Dog dog, List<Recipe> allRecipes) {
    final rec = Recommendations.generateForDog(dog);
    final double portionCalories = rec.dailyCalories / rec.mealsPerDay;

    // Допустим, допустимое отклонение = 20%
    final double lowerBound = portionCalories * 0.6;
    final double upperBound = portionCalories * 1.4;

    // 1. Фильтруем рецепты по аллергенам
    List<Recipe> filtered = allRecipes.where((recipe) {
      // Получим набор ингредиентов рецепта по имени
      final recipeIngredientNames =
          recipe.ingredients.map((i) => i.name.toLowerCase()).toSet();

      // Если хотя бы одно название аллергена собаки есть в рецепте — исключаем
      bool hasAllergen = dog.alergens.any((allergen) {
        return recipeIngredientNames.contains(allergen.toLowerCase());
      });

      return !hasAllergen; // нужно оставить только те рецепты, где нет аллергенов
    }).toList();

    // 2. Фильтруем по калорийности (для одной "порции" собаки на 1 приём)
    filtered = filtered.where((recipe) {
      // Предположим, что вся калорийность рецепта (recipe.calories) — на одну готовую "большую" порцию.
      // Но в реальной жизни рецепт может иметь несколько "порций". Здесь упрощённо:
      // Смотрим, попадает ли рецепт в +/-20% от плановой порции по калориям
      return recipe.calories >= lowerBound && recipe.calories <= upperBound;
    }).toList();

    // Можно доп. фильтрацию сделать по белкам/жирам/углеводам — при желании.

    return filtered;
  }

  Recommendations copyWith({
    double? dailyCalories,
    double? dailyFat,
    double? dailyProtein,
    double? dailyCarbohydrates,
    int? mealsPerDay,
  }) {
    return Recommendations(
      dailyCalories: dailyCalories ?? this.dailyCalories,
      dailyFat: dailyFat ?? this.dailyFat,
      dailyProtein: dailyProtein ?? this.dailyProtein,
      dailyCarbohydrates: dailyCarbohydrates ?? this.dailyCarbohydrates,
      mealsPerDay: mealsPerDay ?? this.mealsPerDay,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dailyCalories': dailyCalories,
      'dailyFat': dailyFat,
      'dailyProtein': dailyProtein,
      'dailyCarbohydrates': dailyCarbohydrates,
      'mealsPerDay': mealsPerDay,
    };
  }

  factory Recommendations.fromMap(Map<String, dynamic> map) {
    return Recommendations(
      dailyCalories: map['dailyCalories'] as double,
      dailyFat: map['dailyFat'] as double,
      dailyProtein: map['dailyProtein'] as double,
      dailyCarbohydrates: map['dailyCarbohydrates'] as double,
      mealsPerDay: map['mealsPerDay'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Recommendations.fromJson(String source) =>
      Recommendations.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Recommendations(dailyCalories: $dailyCalories, dailyFat: $dailyFat, dailyProtein: $dailyProtein, dailyCarbohydrates: $dailyCarbohydrates, mealsPerDay: $mealsPerDay)';
  }

  @override
  bool operator ==(covariant Recommendations other) {
    if (identical(this, other)) return true;

    return other.dailyCalories == dailyCalories &&
        other.dailyFat == dailyFat &&
        other.dailyProtein == dailyProtein &&
        other.dailyCarbohydrates == dailyCarbohydrates &&
        other.mealsPerDay == mealsPerDay;
  }

  @override
  int get hashCode {
    return dailyCalories.hashCode ^
        dailyFat.hashCode ^
        dailyProtein.hashCode ^
        dailyCarbohydrates.hashCode ^
        mealsPerDay.hashCode;
  }
}
