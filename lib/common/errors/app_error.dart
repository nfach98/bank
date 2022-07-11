import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final String? title;
  final String message;

  /// this status for specific error with specific http status
  /// like 409 for conflict data in the server that happened in category create and update
  final int? status;

  const AppError(this.message, {this.title, this.status});

  @override
  List<Object?> get props => [message, title, status];
}
