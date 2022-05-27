part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class ChangePageEvent extends MainEvent {
  final int? index;

  const ChangePageEvent({this.index});

  @override
  List<Object?> get props => [
    index,
  ];
}

class ClickMenuEvent extends MainEvent {
  final bool? isCollapsed;

  const ClickMenuEvent({this.isCollapsed});

  @override
  List<Object?> get props => [
    isCollapsed,
  ];
}
