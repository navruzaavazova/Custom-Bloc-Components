import 'dart:async';

abstract class CubitCustom<S> {
  final StreamController<S> _stateController2 = StreamController<S>();
  S state;
  Stream<S> get stateStream => _stateController2.stream;

  CubitCustom({required this.state}) {
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
