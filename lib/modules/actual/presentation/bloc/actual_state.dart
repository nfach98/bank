part of 'actual_bloc.dart';

class ActualState extends Equatable {
  final String? message;
  final String? selectedPeriod;
  final String? selectedCategory;
  final String? selectedTypeCategory;
  final List<PeriodEntity>? listPeriod;
  final List<CategoryEntity>? listCategory;
  final List<String>? listTypeCategory;
  final List<ActualEntity>? listActual;
  final DateTime? date;

  const ActualState({
    this.message,
    this.selectedPeriod,
    this.selectedCategory,
    this.selectedTypeCategory,
    this.listPeriod,
    this.listCategory,
    this.listTypeCategory,
    this.listActual,
    this.date,
  });

  ActualState copyWith({
    String? message,
    String? selectedPeriod,
    String? selectedCategory,
    String? selectedTypeCategory,
    List<PeriodEntity>? listPeriod,
    List<CategoryEntity>? listCategory,
    List<String>? listTypeCategory,
    List<ActualEntity>? listActual,
    DateTime? date,
  }) {
    return ActualState(
      message: message,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedTypeCategory: selectedTypeCategory ?? this.selectedTypeCategory,
      listPeriod: listPeriod ?? this.listPeriod,
      listCategory: listCategory ?? this.listCategory,
      listTypeCategory: listTypeCategory ?? this.listTypeCategory,
      listActual: listActual ?? this.listActual,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [
    message,
    selectedPeriod,
    selectedCategory,
    selectedTypeCategory,
    listPeriod,
    listCategory,
    listActual,
    date,
  ];
}
