import 'package:fructissimo/src/feature/main/model/dog.dart';
import 'package:fructissimo/src/feature/main/model/food.dart';
import 'package:fructissimo/src/feature/main/model/recipe.dart';
import 'package:fructissimo/src/feature/main/model/tips.dart';

import '../../../core/utils/json_loader.dart';

class Repository {
  final String food = 'food';
  final String dog = 'dog';
  final String recipe = "recipe";
  final String tips = "tips";

  Future<List<Dog>> loadDog() {
    return JsonLoader.loadData<Dog>(
      dog,
      'assets/json/$dog.json',
      (json) => Dog.fromMap(json),
    );
  }

  Future<List<Food>> loadFood() {
    return JsonLoader.loadData<Food>(
      food,
      'assets/json/$food.json',
      (json) => Food.fromMap(json),
    );
  }

  Future<List<Recipe>> loadRecipe() {
    return JsonLoader.loadData<Recipe>(
      recipe,
      'assets/json/$recipe.json',
      (json) => Recipe.fromMap(json),
    );
  }

  Future<List<Tips>> loadTips() {
    return JsonLoader.loadData<Tips>(
      tips,
      'assets/json/$tips.json',
      (json) => Tips.fromMap(json),
    );
  }

  Future<void> save(Dog item) {
    return JsonLoader.saveData<Dog>(
      dog,
      item,
      () async => await loadDog(),
      (item) => item.toMap(),
    );
  }

  Future<void> update(Dog updated) async {
    return await JsonLoader.modifyDataList<Dog>(
      dog,
      updated,
      () async => await loadDog(),
      (item) => item.toMap(),
      (itemList) async {
        final index = 0;
        if (index != -1) {
          itemList[index] = updated;
        }
      },
    );
  }
}
