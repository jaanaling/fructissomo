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

  const UserLoaded({
    required this.trees,
    required this.article,
  });

  // Метод copyWith для удобства
  UserLoaded copyWith({
    List<TreeProfile>? trees,
    List<DiaryEntry>? article,
  }) {
    return UserLoaded(
      trees: trees ?? this.trees,
      article: article ?? this.article,
    );
  }

  @override
  List<Object?> get props => [trees, article];
}

/// Состояние ошибки
class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}
