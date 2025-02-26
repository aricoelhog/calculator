import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MemoryEntity extends Equatable {
  late int? resultId;
  final String expression;
  final double result;
  final String? code;
  final int? date;

  MemoryEntity({
    required this.expression,
    required this.result,
    this.resultId,
    this.code,
    this.date,
  });

  @override
  List<Object?> get props => [resultId];
}
