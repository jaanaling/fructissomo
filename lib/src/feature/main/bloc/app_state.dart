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
  final List<TreeProfile> trees;
  final List<DiaryEntry> article;
  final List<TreeType> treeTypes;

  const UserLoaded({
    required this.trees,
    required this.article,
   required this.treeTypes,
  });

  // Метод copyWith для удобства
  UserLoaded copyWith({
    List<TreeProfile>? trees,
    List<DiaryEntry>? article,
    List<TreeType>? treeTypes,
  }) {
    return UserLoaded(
      trees: trees ?? this.trees,
      article: article ?? this.article,
      treeTypes: treeTypes ?? this.treeTypes,
    );
  }

  @override
  List<Object?> get props => [trees, article, treeTypes];
}

/// Состояние ошибки
class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}
