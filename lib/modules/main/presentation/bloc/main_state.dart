part of 'main_bloc.dart';

class MainState extends Equatable{
  final int currentIndex;
  final bool isCollapsed;
  final String? selectedPeriod;

  const MainState({
    required this.currentIndex,
    required this.isCollapsed,
    this.selectedPeriod,
  });

  MainState copyWith({
    int? index,
    bool? isCollapsed,
    String? selectedPeriod,
  }) {
    return MainState(
      currentIndex: index ?? currentIndex,
      isCollapsed: isCollapsed ?? this.isCollapsed,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
    );
  }

  @override
  List<Object?> get props => [
    currentIndex,
    isCollapsed,
    selectedPeriod,
  ];
}
