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
    on<UserAddData>(_onUserAddData);
    on<UserUpdateTree>(_onUserUpdateTree);
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


  Future<void> _onUserAddData(
    UserAddData event,
    Emitter<UserState> emit,
  ) async {
    try {

      await userRepository.save(event.newTree);
      final trees = await userRepository.loadProfile();
      final article = await userRepository.loadArticle();
      emit(
        UserLoaded(
          trees: trees,
          article: article,
        ),
      );
    } catch (e) {
      emit(UserError('Произошла ошибка при добавлении: $e'));
    }
  }

  Future<void> _onUserUpdateTree(
    UserUpdateTree event,
    Emitter<UserState> emit,
  ) async {
    try {
      await userRepository.update(event.tree);
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
