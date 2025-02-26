import 'package:mobx/mobx.dart';

// flutter packages pub run build_runner watch -> Executar no terminal
part 'memory_store.g.dart';

class MemoryStore = _MemoryStore with _$MemoryStore;

abstract class _MemoryStore with Store {
  @observable
  String? _expression;

  @computed
  String get expression => _expression ?? '0';

  @action
  updateExpression({required String expression}) {
    _expression = expression;
  }

  @observable
  double? _result;

  @computed
  double get result => _result ?? 0;

  @action
  updateResult({required double result}) {
    _result = result;
  }
}
