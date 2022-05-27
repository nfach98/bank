part of 'main_bloc.dart';

class MainState extends Equatable{
  final int currentIndex;
  final bool isCollapsed;

  const MainState({
    required this.currentIndex,
    required this.isCollapsed,
  });

  MainState copyWith({
    int? index,
    bool? isCollapsed,
  }) {
    return MainState(
      currentIndex: index ?? currentIndex,
      isCollapsed: isCollapsed ?? this.isCollapsed
    );
  }

  @override
  List<Object?> get props => [
    currentIndex,
    isCollapsed,
  ];
}
