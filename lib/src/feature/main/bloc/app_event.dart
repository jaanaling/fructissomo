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

class UserAddData extends UserEvent {
  final TreeProfile newTree;
  const UserAddData(this.newTree);
  @override
  List<Object?> get props => [newTree];
}

class UserUpdateTree extends UserEvent {
  final TreeProfile tree;
  const UserUpdateTree(this.tree);
  @override
  List<Object?> get props => [tree];
}
