import 'package:bloc/bloc.dart';
import 'package:fructissimo/src/feature/main/model/article.dart';

import 'package:equatable/equatable.dart';
import 'package:fructissimo/src/core/dependency_injection.dart';

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
    on<UserDeleteTree>(_onUserDeleteTree);
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
      final treeTypes = await userRepository.load();

      emit(
        UserLoaded(
          trees: trees,
          article: article,
          treeTypes: treeTypes,
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
      final treeTypes = await userRepository.load();

      emit(
        UserLoaded(
          trees: trees,
          article: article,
          treeTypes: treeTypes,
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
      final treeTypes = await userRepository.load();

      emit(
        UserLoaded(
          trees: trees,
          article: article,
          treeTypes: treeTypes,
        ),
      );
    } catch (e) {
      emit(UserError('Произошла ошибка при обновлении: $e'));
    }
  }

  Future<void> _onUserDeleteTree(
    UserDeleteTree event,
    Emitter<UserState> emit,
  ) async {
    try {
      await userRepository.delete(event.tree);
      final trees = await userRepository.loadProfile();
      final article = await userRepository.loadArticle();
      final treeTypes = await userRepository.load();

      emit(
        UserLoaded(
          trees: trees,
          article: article,
          treeTypes: treeTypes,
        ),
      );
    } catch (e) {
      emit(UserError('Произошла ошибка при удалении: $e'));
    }
  }
}
