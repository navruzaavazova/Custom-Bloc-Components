import 'dart:async';

abstract class SpiderCubit<S> {
  final StreamController<S> _stateController2 = StreamController<S>();
  S state;
  Stream<S> get stateStream => _stateController2.stream;

  SpiderCubit({required this.state}) {
    emit(state);
  }

  void emit(S value) {
    state = value;
    _stateController2.add(value);
  }

  void closure() {
    _stateController2.close();
  }
}
