import 'package:calculator/data/data_objects.dart';
import 'package:calculator/data/domain/entities/memory_entity.dart';

// ignore: must_be_immutable
class HistoryModel extends MemoryEntity {
  HistoryModel({code, required expression, required result, date})
      : super(
          code: code,
          expression: expression,
          result: result,
          date: date,
        );

  factory HistoryModel.fromMap(Map<String, Object?> map) {
    print(map[column_date]);
    return HistoryModel(
      code: map[column_code],
      expression: map[column_expression],
      result: map[column_result],
      date: map[column_date],
    );
  }
}
