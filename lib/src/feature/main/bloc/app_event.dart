part of 'app_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserLoadData extends UserEvent {
  const UserLoadData();
  @override
  List<Object?> get props => [];
}

class UserToggleFavoriteData extends UserEvent {
  final int id;

  const UserToggleFavoriteData({required this.id});
  @override
  List<Object?> get props => [id];
}

class UserSaveShoppingData extends UserEvent {
  final Ingredient ingredient;

  const UserSaveShoppingData({required this.ingredient});
  @override
  List<Object?> get props => [ingredient];
}

class UserClearShoppingData extends UserEvent {
  const UserClearShoppingData();
  @override
  List<Object?> get props => [];
}

class UserUpdateShoppingData extends UserEvent {
  final String id;
  final Ingredient shopping;

  const UserUpdateShoppingData({required this.shopping, required this.id});
  @override
  List<Object?> get props => [shopping, id];
}

class UserDeleteShoppingData extends UserEvent {
  final String id;

  const UserDeleteShoppingData({required this.id});
  @override
  List<Object?> get props => [id];
}

class UserSaveStorageData extends UserEvent {
  final Ingredient ingredient;

  const UserSaveStorageData({required this.ingredient});
  @override
  List<Object?> get props => [ingredient];
}

class UserUpdateStorageData extends UserEvent {
  final String id;
  final Ingredient storage;

  const UserUpdateStorageData({required this.storage, required this.id});
  @override
  List<Object?> get props => [storage, id];
}

class UserDeleteStorageData extends UserEvent {
  final String id;

  const UserDeleteStorageData({required this.id});
  @override
  List<Object?> get props => [id];
}

class UserUpdateData extends UserEvent {
  
  final String? name;
  final String? breed;
  final int? age; // Возраст в годах
  final String? gender;
  final double? weight; // Вес в кг
  final int? activity; // Условный уровень активности (1..5)
  final List<String>? alergens;
  final String? image;

  const UserUpdateData({
    this.name,
    this.breed,
    this.age,
    this.gender,
    this.weight,
    this.activity,
    this.alergens,
    this.image,
  });

  @override
  List<Object?> get props =>
      [name, breed, age, gender, weight, activity, alergens, image];
}
