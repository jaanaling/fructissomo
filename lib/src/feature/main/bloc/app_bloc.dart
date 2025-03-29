import 'package:bloc/bloc.dart';
import 'package:fructissimo/src/feature/main/model/dog.dart';
import 'package:fructissimo/src/feature/main/model/food.dart';
import 'package:fructissimo/src/feature/main/model/ingredient.dart';
import 'package:fructissimo/src/feature/main/model/recipe.dart';
import 'package:fructissimo/src/feature/main/model/storage.dart';
import 'package:fructissimo/src/feature/main/model/tips.dart';

import 'package:equatable/equatable.dart';
import 'package:fructissimo/src/core/dependency_injection.dart';
import 'package:fructissimo/src/feature/main/model/shopping.dart';
import 'package:fructissimo/src/feature/main/repository/user_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Repository userRepository = locator<Repository>();

  UserBloc() : super(const UserLoading()) {
    on<UserLoadData>(_onUserLoadData);
    on<UserUpdateData>(_onUserUpdateData);
    on<UserToggleFavoriteData>(_onUserToggleFavoriteData);
    on<UserSaveShoppingData>(_onUserSaveShoppingData);
    on<UserUpdateShoppingData>(_onUserUpdateShoppingData);
    on<UserDeleteShoppingData>(_onUserDeleteShoppingData);
    on<UserSaveStorageData>(_onUserSaveStorageData);
    on<UserUpdateStorageData>(_onUserUpdateStorageData);
    on<UserDeleteStorageData>(_onUserDeleteStorageData);
  }

  Future<void> _onUserLoadData(
    UserLoadData event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    try {
      // Репозиторий возвращает список пользователей; берём первого или init
      List<Dog> dog = await userRepository.loadDog();
      final food = await userRepository.loadFood();
      final recipe = await userRepository.loadRecipe();
      final tips = await userRepository.loadTips();

      if (dog.isEmpty) {
        await userRepository.save(Dog.init());
      }

      dog = await userRepository.loadDog();

      emit(
        UserLoaded(
          dog: dog.first,
          tips: tips,
          recipe: recipe,
          food: food,
        ),
      );
    } catch (e) {
      emit(UserError('Произошла ошибка при загрузке: $e'));
    }
  }

  Future<void> _onUserUpdateData(
    UserUpdateData event,
    Emitter<UserState> emit,
  ) async {
    try {
      final updatedDog = (state as UserLoaded).dog.copyWith(
            name: event.name,
            breed: event.breed,
            age: event.age,
            gender: event.gender,
            weight: event.weight,
            activity: event.activity,
            alergens: event.alergens,
            image: event.image,
          );
      await userRepository.update(updatedDog);

      final dog = await userRepository.loadDog();
      final food = await userRepository.loadFood();
      final recipe = await userRepository.loadRecipe();
      final tips = await userRepository.loadTips();
      emit(
        UserLoaded(
          dog: dog.first,
          tips: tips,
          recipe: recipe,
          food: food,
        ),
      );
    } catch (e) {
      emit(UserError('Произошла ошибка при обновлении данных: $e'));
    }
  }

  Future<void> _onUserToggleFavoriteData(
    UserToggleFavoriteData event,
    Emitter<UserState> emit,
  ) async {
    try {
      final currentState = state as UserLoaded;
      final currentDog = currentState.dog;
      final isFavorite = currentDog.favoriteRecipes.contains(event.id);

      final updatedFavorites = isFavorite
          ? currentDog.favoriteRecipes.where((id) => id != event.id).toList()
          : [...currentDog.favoriteRecipes, event.id];

      final updatedDog = currentDog.copyWith(favoriteRecipes: updatedFavorites);
      await userRepository.update(updatedDog);

      final dog = await userRepository.loadDog();
      final food = await userRepository.loadFood();
      final recipe = await userRepository.loadRecipe();
      final tips = await userRepository.loadTips();
      emit(
        UserLoaded(
          dog: dog.first,
          tips: tips,
          recipe: recipe,
          food: food,
        ),
      );
    } catch (e) {
      emit(UserError('Произошла ошибка при обновлении избранного: $e'));
    }
  }

  Future<void> _onUserSaveShoppingData(
    UserSaveShoppingData event,
    Emitter<UserState> emit,
  ) async {
    try {
      final currentState = state as UserLoaded;
      final currentDog = currentState.dog;
      final newShopping = Shopping(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        ingredient: event.ingredient,
      );
      final List<Shopping> updatedShoppingList = [];
      if (currentState.dog.shoppingList.indexWhere(
            (element) => element.ingredient.name == event.ingredient.name,
          ) ==
          -1) {
        updatedShoppingList.addAll([...currentDog.shoppingList, newShopping]);
      } else {
        updatedShoppingList.addAll(
          currentDog.shoppingList.map((shopping) {
            if (shopping.ingredient.name == newShopping.ingredient.name) {
              return shopping.copyWith(
                ingredient: shopping.ingredient.copyWith(
                  quantity:
                      shopping.ingredient.quantity + event.ingredient.quantity,
                ),
              );
            }
            return shopping;
          }).toList(),
        );
      }

      final updatedDog = currentDog.copyWith(shoppingList: updatedShoppingList);
      await userRepository.update(updatedDog);

      final dog = await userRepository.loadDog();
      final food = await userRepository.loadFood();
      final recipe = await userRepository.loadRecipe();
      final tips = await userRepository.loadTips();
      emit(
        UserLoaded(
          dog: dog.first,
          tips: tips,
          recipe: recipe,
          food: food,
        ),
      );
    } catch (e) {
      emit(UserError('Произошла ошибка при сохранении данных: $e'));
    }
  }

  Future<void> _onUserUpdateShoppingData(
    UserUpdateShoppingData event,
    Emitter<UserState> emit,
  ) async {
    try {
      final currentState = state as UserLoaded;
      final currentDog = currentState.dog;
      final updatedShoppingList = currentDog.shoppingList.map((shopping) {
        if (shopping.id == event.id) {
          return shopping.copyWith(ingredient: event.shopping);
        }
        return shopping;
      }).toList();
      final updatedDog = currentDog.copyWith(shoppingList: updatedShoppingList);
      await userRepository.update(updatedDog);

      final dog = await userRepository.loadDog();
      final food = await userRepository.loadFood();
      final recipe = await userRepository.loadRecipe();
      final tips = await userRepository.loadTips();
      emit(
        UserLoaded(
          dog: dog.first,
          tips: tips,
          recipe: recipe,
          food: food,
        ),
      );
    } catch (e) {
      emit(UserError('Произошла ошибка при обновлении данных: $e'));
    }
  }

  Future<void> _onUserDeleteShoppingData(
    UserDeleteShoppingData event,
    Emitter<UserState> emit,
  ) async {
    try {
      final currentState = state as UserLoaded;
      final currentDog = currentState.dog;
      final updatedShoppingList = currentDog.shoppingList
          .where((shopping) => shopping.id != event.id)
          .toList();
      final updatedDog = currentDog.copyWith(shoppingList: updatedShoppingList);
      await userRepository.update(updatedDog);

      final dog = await userRepository.loadDog();
      final food = await userRepository.loadFood();
      final recipe = await userRepository.loadRecipe();
      final tips = await userRepository.loadTips();
      emit(
        UserLoaded(
          dog: dog.first,
          tips: tips,
          recipe: recipe,
          food: food,
        ),
      );
    } catch (e) {
      emit(UserError('Произошла ошибка при удалении данных: $e'));
    }
  }

  Future<void> _onUserSaveStorageData(
    UserSaveStorageData event,
    Emitter<UserState> emit,
  ) async {
    try {
      final currentState = state as UserLoaded;
      final currentDog = currentState.dog;
      final newStorage = Storage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: DateTime.now(),
        ingredient: event.ingredient,
      );

      final updatedShoppingList = currentDog.shoppingList
          .where((element) => element.ingredient.id != event.ingredient.id)
          .toList();

      final List<Storage> updatedStorageList = [];
      if (currentState.dog.storage.indexWhere(
            (element) => element.ingredient.name == event.ingredient.name,
          ) ==
          -1) {
        updatedStorageList.addAll([...currentDog.storage, newStorage]);
      } else {
        updatedStorageList.addAll(
          currentDog.storage.map((storage) {
            if (storage.ingredient.name == newStorage.ingredient.name) {
              return storage.copyWith(
                ingredient: storage.ingredient.copyWith(
                  quantity:
                      storage.ingredient.quantity + event.ingredient.quantity,
                ),
              );
            }
            return storage;
          }).toList(),
        );
      }

      final updatedDog = currentDog.copyWith(
        storage: updatedStorageList,
        shoppingList: updatedShoppingList,
      );
      await userRepository.update(updatedDog);

      final dog = await userRepository.loadDog();
      final food = await userRepository.loadFood();
      final recipe = await userRepository.loadRecipe();
      final tips = await userRepository.loadTips();
      emit(
        UserLoaded(
          dog: dog.first,
          tips: tips,
          recipe: recipe,
          food: food,
        ),
      );
    } catch (e) {
      emit(UserError('Произошла ошибка при сохранении данных: $e'));
    }
  }

  Future<void> _onUserUpdateStorageData(
    UserUpdateStorageData event,
    Emitter<UserState> emit,
  ) async {
    try {
      final currentState = state as UserLoaded;
      final currentDog = currentState.dog;
      final updatedStorageList = currentDog.storage.map((storage) {
        if (storage.id == event.id) {
          return storage.copyWith(ingredient: event.storage);
        }
        return storage;
      }).toList();
      final updatedDog = currentDog.copyWith(storage: updatedStorageList);
      await userRepository.update(updatedDog);

      final dog = await userRepository.loadDog();
      final food = await userRepository.loadFood();
      final recipe = await userRepository.loadRecipe();
      final tips = await userRepository.loadTips();
      emit(
        UserLoaded(
          dog: dog.first,
          tips: tips,
          recipe: recipe,
          food: food,
        ),
      );
    } catch (e) {
      emit(UserError('Произошла ошибка при обновлении данных: $e'));
    }
  }

  Future<void> _onUserDeleteStorageData(
    UserDeleteStorageData event,
    Emitter<UserState> emit,
  ) async {
    try {
      final currentState = state as UserLoaded;
      final currentDog = currentState.dog;
      final updatedStorageList = currentDog.storage
          .where((storage) => storage.id != event.id)
          .toList();
      final updatedDog = currentDog.copyWith(storage: updatedStorageList);
      await userRepository.update(updatedDog);

      final dog = await userRepository.loadDog();
      final food = await userRepository.loadFood();
      final recipe = await userRepository.loadRecipe();
      final tips = await userRepository.loadTips();
      emit(
        UserLoaded(
          dog: dog.first,
          tips: tips,
          recipe: recipe,
          food: food,
        ),
      );
    } catch (e) {
      emit(UserError('Произошла ошибка при удалении данных: $e'));
    }
  }
}
