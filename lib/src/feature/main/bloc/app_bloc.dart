import 'package:bloc/bloc.dart';
import 'package:fructissimo/src/feature/main/model/article.dart';

import 'package:equatable/equatable.dart';
import 'package:fructissimo/src/core/dependency_injection.dart';
import 'package:fructissimo/src/feature/main/model/fertilizer.dart';
import 'package:fructissimo/src/feature/main/model/pest.dart';

import 'package:fructissimo/src/feature/main/model/tree.dart';
import 'package:fructissimo/src/feature/main/repository/user_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Repository userRepository = locator<Repository>();

  UserBloc() : super(const UserLoading()) {
    on<UserLoadData>(_onUserLoadData);
    on<UserUpdateData>(_onUserUpdateData);


  }

  Future<void> _onUserLoadData(
    UserLoadData event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    try {
      // Репозиторий возвращает список пользователей; берём первого или init
      final trees = await userRepository.loadProfile();
      final article = await userRepository.loadArticle();
 
    
      emit(
        UserLoaded(
          trees: trees,
          article: article,
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
      final updatedTree = (state as UserLoaded).trees.first.copyWith(
            id: event.id,
            type: event.type,
            subtype: event.subtype,
            height: event.height,
            diameter: event.diameter,
            moisture: event.moisture,
            acidity: event.acidity,
            protection: event.protection,
            fertilizer: event.fertilizer,
            soil: event.soil,
            sunlight: event.sunlight,
            foliage: event.foliage,
            health: event.health,
            productivity: event.productivity,
            growthStage: event.growthStage,
            isCheckWater: event.isCheckWater,
            isCheckProductivity: event.isCheckProductivity,
            isCheckProtect: event.isCheckProtect,
            isCheckFertilize: event.isCheckFertilize,
            isCheckTemperature: event.isCheckTemperature,
            isPest: event.isPest,
            pests: event.pests,
          );
      await userRepository.update(updatedTree);
      final trees = await userRepository.loadProfile();
      final article = await userRepository.loadArticle();
      emit(
        UserLoaded(
          trees: trees,
          article: article,
        ),
      );
    } catch (e) {
      emit(UserError('Произошла ошибка при обновлении: $e'));
    }
  }
}

    

   
