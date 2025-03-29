part of 'app_bloc.dart';

/// Базовый класс состояний
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

/// Состояние загрузки
class UserLoading extends UserState {
  const UserLoading();
}

/// Состояние, когда данные загружены
class UserLoaded extends UserState {
  final Dog dog;
  final List<Tips> tips;
  final List<Food> food;
  final List<Recipe> recipe;

  const UserLoaded({
    required this.dog,
    required this.tips,
    required this.recipe,
    required this.food,
  });

  // Метод copyWith для удобства
  UserLoaded copyWith({
    Dog? dog,
    List<Tips>? tips,
    List<Food>? food,
    List<Recipe>? recipe,
  }) {
    return UserLoaded(
      dog: dog ?? this.dog,
      tips: tips ?? this.tips,
      food: food ?? this.food,
      recipe: recipe ?? this.recipe,
    );
  }

  @override
  List<Object?> get props => [dog, tips, food, recipe];
}

/// Состояние ошибки
class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}
