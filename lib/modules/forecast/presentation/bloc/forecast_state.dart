part of 'forecast_bloc.dart';

class ForecastState extends Equatable {
  final String? message;
  final String? selectedPeriod;
  final String? selectedCategory;
  final String? selectedTypeCategory;
  final List<PeriodEntity>? listPeriod;
  final List<CategoryEntity>? listCategory;
  final List<String>? listTypeCategory;
  final List<ForecastEntity>? listForecast;
  final DateTime? date;

  const ForecastState({
    this.message,
    this.selectedPeriod,
    this.selectedCategory,
    this.selectedTypeCategory,
    this.listPeriod,
    this.listCategory,
    this.listTypeCategory,
    this.listForecast,
    this.date,
  });

  ForecastState copyWith({
    String? message,
    String? selectedPeriod,
    String? selectedCategory,
    String? selectedTypeCategory,
    List<PeriodEntity>? listPeriod,
    List<CategoryEntity>? listCategory,
    List<String>? listTypeCategory,
    List<ForecastEntity>? listForecast,
    DateTime? date,
  }) {
    return ForecastState(
      message: message,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedTypeCategory: selectedTypeCategory ?? this.selectedTypeCategory,
      listPeriod: listPeriod ?? this.listPeriod,
      listCategory: listCategory ?? this.listCategory,
      listTypeCategory: listTypeCategory ?? this.listTypeCategory,
      listForecast: listForecast ?? this.listForecast,
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
    listForecast,
    date,
  ];
}
