// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fructissimo/src/feature/main/model/recipe.dart';
import 'package:fructissimo/src/feature/main/model/recommendations.dart';
import 'package:fructissimo/src/feature/main/model/shopping.dart';
import 'package:fructissimo/src/feature/main/model/storage.dart';
import 'package:flutter/foundation.dart';

class Dog {
  final String name;
  final String breed;
  final int age; // Возраст в годах
  final String gender;
  final double weight; // Вес в кг
  final int activity; // Условный уровень активности (1..5)
  final List<String> alergens;
  final String? image;
  final List<Shopping> shoppingList;
  final List<Storage> storage;
  final List<int> favoriteRecipes;

  /// Список id рецептов, рекомендованных собаке
  final List<int> recomendationRecipes;

  /// Инициализация нового объекта
  factory Dog.init() {
    return Dog(
      name: '',
      breed: 'breed',
      age: 0,
      gender: 'Male',
      weight: 0,
      activity: 1,
      alergens: [],
      image: null,
      shoppingList: [],
      storage: [],
      favoriteRecipes: [],
      recomendationRecipes: [],
    );
  }

  Dog({
    required this.name,
    required this.breed,
    required this.age,
    required this.gender,
    required this.weight,
    required this.activity,
    required this.alergens,
    required this.image,
    required this.shoppingList,
    required this.storage,
    required this.favoriteRecipes,
    required this.recomendationRecipes,
  });

  /// Добавляет ID рецепта в список рекомендаций (если ещё не добавлен)
  void addRecipeRecommendation(int recipeId) {
    if (!recomendationRecipes.contains(recipeId)) {
      recomendationRecipes.add(recipeId);
    }
  }

  /// Удаляет ID рецепта из списка рекомендаций (если он там есть)
  void removeRecipeRecommendation(int recipeId) {
    recomendationRecipes.remove(recipeId);
  }

  /// Позволяет полностью обновить (пересчитать) список рецептов,
  /// основываясь на реальных параметрах собаки и характеристиках блюд.
  void updateRecommendations(List<Recipe> allRecipes) {
    // Вызываем метод из Recommendations, который подберёт нужные рецепты
    final recommended =
        Recommendations.findRecommendedRecipes(this, allRecipes);
    // Очищаем старые рекомендации, добавляем новые
    recomendationRecipes.clear();
    recomendationRecipes.addAll(recommended.map((r) => r.id));
  }

  /// Получить рекомендации (объект с нормами калорий, БЖУ и т.д.)
  Recommendations getDailyRecommendations() {
    return Recommendations.generateForDog(this);
  }

  Dog copyWith({
    String? name,
    String? breed,
    int? age,
    String? gender,
    double? weight,
    int? activity,
    List<String>? alergens,
    String? image,
    List<Shopping>? shoppingList,
    List<Storage>? storage,
    List<int>? favoriteRecipes,
    List<int>? recomendationRecipes,
  }) {
    return Dog(
      name: name ?? this.name,
      breed: breed ?? this.breed,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      activity: activity ?? this.activity,
      alergens: alergens ?? this.alergens,
      image: image ?? this.image,
      shoppingList: shoppingList ?? this.shoppingList,
      storage: storage ?? this.storage,
      favoriteRecipes: favoriteRecipes ?? this.favoriteRecipes,
      recomendationRecipes: recomendationRecipes ?? this.recomendationRecipes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'breed': breed,
      'age': age,
      'gender': gender,
      'weight': weight,
      'activity': activity,
      'alergens': alergens,
      'image': image,
      'shoppingList': shoppingList.map((x) => x.toMap()).toList(),
      'storage': storage.map((x) => x.toMap()).toList(),
      'favoriteRecipes': favoriteRecipes,
      'recomendationRecipes': recomendationRecipes,
    };
  }

  factory Dog.fromMap(Map<String, dynamic> map) {
    return Dog(
      name: map['name'] as String,
      breed: map['breed'] as String,
      age: map['age'] as int,
      gender: map['gender'] as String,
      weight: map['weight'] as double,
      activity: map['activity'] as int,
      alergens: List<String>.from(map['alergens'] as List<dynamic>),
      image: map['image'] != null ? map['image'] as String : null,
      shoppingList: List<Shopping>.from(
        (map['shoppingList'] as List<dynamic>).map<Shopping>(
          (x) => Shopping.fromMap(x as Map<String, dynamic>),
        ),
      ),
      storage: List<Storage>.from(
        (map['storage'] as List<dynamic>).map<Storage>(
          (x) => Storage.fromMap(x as Map<String, dynamic>),
        ),
      ),
      favoriteRecipes: List<int>.from(map['favoriteRecipes'] as List<dynamic>),
      recomendationRecipes:
          List<int>.from(map['recomendationRecipes'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Dog.fromJson(String source) =>
      Dog.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Dog(name: $name, breed: $breed, age: $age, gender: $gender, weight: $weight, activity: $activity, alergens: $alergens, image: $image, shoppingList: $shoppingList, storage: $storage, favoriteRecipes: $favoriteRecipes, recomendationRecipes: $recomendationRecipes)';
  }

  @override
  bool operator ==(covariant Dog other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.breed == breed &&
        other.age == age &&
        other.gender == gender &&
        other.weight == weight &&
        other.activity == activity &&
        listEquals(other.alergens, alergens) &&
        other.image == image &&
        listEquals(other.shoppingList, shoppingList) &&
        listEquals(other.storage, storage) &&
        listEquals(other.favoriteRecipes, favoriteRecipes) &&
        listEquals(other.recomendationRecipes, recomendationRecipes);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        breed.hashCode ^
        age.hashCode ^
        gender.hashCode ^
        weight.hashCode ^
        activity.hashCode ^
        alergens.hashCode ^
        image.hashCode ^
        shoppingList.hashCode ^
        storage.hashCode ^
        favoriteRecipes.hashCode ^
        recomendationRecipes.hashCode;
  }
}

List<String> commonDogAllergens = [
  "Chicken",
  "Beef",
  "Dairy",
  "Eggs",
  "Fish",
  "Wheat",
  "Corn",
  "Soy",
  "Yeast",
  "Lamb",
  "Rabbit",
  "Peanuts",
  "Peanut Butter",
  "Pork",
  "Barley",
  "Rice",
  "Potatoes",
  "Peas"
];

List<String> dogBreeds = [
  "Affenpinscher",
  "Afghan Hound",
  "Airedale Terrier",
  "Akita",
  "Alaskan Malamute",
  "American Bulldog",
  "American Cocker Spaniel",
  "American Eskimo Dog",
  "American Foxhound",
  "American Pit Bull Terrier",
  "American Staffordshire Terrier",
  "Anatolian Shepherd Dog",
  "Australian Cattle Dog",
  "Australian Kelpie",
  "Australian Shepherd",
  "Australian Silky Terrier",
  "Australian Terrier",
  "Azawakh",
  "Basenji",
  "Basset Hound",
  "Beagle",
  "Bearded Collie",
  "Bedlington Terrier",
  "Belgian Malinois",
  "Belgian Sheepdog",
  "Belgian Tervuren",
  "Bergamasco Shepherd",
  "Bernese Mountain Dog",
  "Bichon Frise",
  "Black and Tan Coonhound",
  "Bloodhound",
  "Bluetick Coonhound",
  "Border Collie",
  "Border Terrier",
  "Borzoi",
  "Boston Terrier",
  "Bouvier des Flandres",
  "Boxer",
  "Boykin Spaniel",
  "Briard",
  "Brittany",
  "Brussels Griffon",
  "Bull Terrier",
  "Bulldog",
  "Bullmastiff",
  "Cairn Terrier",
  "Canaan Dog",
  "Cane Corso",
  "Cardigan Welsh Corgi",
  "Cavalier King Charles Spaniel",
  "Cesky Terrier",
  "Chesapeake Bay Retriever",
  "Chihuahua",
  "Chinese Crested",
  "Chinese Shar-Pei",
  "Chinook",
  "Chow Chow",
  "Clumber Spaniel",
  "Collie",
  "Coton de Tulear",
  "Curly-Coated Retriever",
  "Dachshund",
  "Dalmatian",
  "Dandie Dinmont Terrier",
  "Doberman Pinscher",
  "Dogo Argentino",
  "Dogue de Bordeaux",
  "English Cocker Spaniel",
  "English Foxhound",
  "English Setter",
  "English Springer Spaniel",
  "English Toy Spaniel",
  "Entlebucher Mountain Dog",
  "Field Spaniel",
  "Finnish Spitz",
  "Flat-Coated Retriever",
  "French Bulldog",
  "German Pinscher",
  "German Shepherd",
  "German Shorthaired Pointer",
  "German Wirehaired Pointer",
  "Giant Schnauzer",
  "Glen of Imaal Terrier",
  "Golden Retriever",
  "Gordon Setter",
  "Great Dane",
  "Great Pyrenees",
  "Greater Swiss Mountain Dog",
  "Greyhound",
  "Harrier",
  "Havanese",
  "Ibizan Hound",
  "Icelandic Sheepdog",
  "Irish Red and White Setter",
  "Irish Setter",
  "Irish Terrier",
  "Irish Water Spaniel",
  "Irish Wolfhound",
  "Italian Greyhound",
  "Japanese Chin",
  "Keeshond",
  "Kerry Blue Terrier",
  "Komondor",
  "Kuvasz",
  "Labrador Retriever",
  "Lakeland Terrier",
  "Leonberger",
  "Lhasa Apso",
  "Lowchen",
  "Maltese",
  "Manchester Terrier",
  "Mastiff",
  "Miniature American Shepherd",
  "Miniature Bull Terrier",
  "Miniature Pinscher",
  "Miniature Schnauzer",
  "Neapolitan Mastiff",
  "Newfoundland",
  "Norfolk Terrier",
  "Norwegian Buhund",
  "Norwegian Elkhound",
  "Norwegian Lundehund",
  "Norwich Terrier",
  "Nova Scotia Duck Tolling Retriever",
  "Old English Sheepdog",
  "Otterhound",
  "Papillon",
  "Parson Russell Terrier",
  "Pekingese",
  "Pembroke Welsh Corgi",
  "Petit Basset Griffon Vendéen",
  "Pharaoh Hound",
  "Plott",
  "Pointer",
  "Polish Lowland Sheepdog",
  "Pomeranian",
  "Poodle",
  "Portuguese Podengo",
  "Portuguese Water Dog",
  "Pug",
  "Puli",
  "Pumi",
  "Rat Terrier",
  "Redbone Coonhound",
  "Rhodesian Ridgeback",
  "Rottweiler",
  "Russell Terrier",
  "Saint Bernard",
  "Saluki",
  "Samoyed",
  "Schipperke",
  "Scottish Deerhound",
  "Scottish Terrier",
  "Sealyham Terrier",
  "Shetland Sheepdog",
  "Shiba Inu",
  "Shih Tzu",
  "Siberian Husky",
  "Silky Terrier",
  "Skye Terrier",
  "Sloughi",
  "Smooth Fox Terrier",
  "Soft Coated Wheaten Terrier",
  "Spanish Water Dog",
  "Spinone Italiano",
  "Staffordshire Bull Terrier",
  "Standard Schnauzer",
  "Sussex Spaniel",
  "Swedish Vallhund",
  "Tibetan Mastiff",
  "Tibetan Spaniel",
  "Tibetan Terrier",
  "Toy Fox Terrier",
  "Treeing Walker Coonhound",
  "Vizsla",
  "Weimaraner",
  "Welsh Springer Spaniel",
  "Welsh Terrier",
  "West Highland White Terrier",
  "Whippet",
  "Wire Fox Terrier",
  "Wirehaired Pointing Griffon",
  "Xoloitzcuintli",
  "Yorkshire Terrier",
  "Alaskan Klee Kai",
  "Caucasian Shepherd Dog",
  "Shiloh Shepherd",
  "American Hairless Terrier",
  "Thai Ridgeback"
];
