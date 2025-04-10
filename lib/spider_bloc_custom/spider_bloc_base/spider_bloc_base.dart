import 'dart:async';

abstract class SpiderBlocBase<S> {
  StreamController<S> _stateController2 = StreamController<S>();
  S state;
  Stream<S> get stateStream => _stateController2.stream;

  SpiderBlocBase(this.state): _stateController2 = StreamController<S>.broadcast() {
    _stateController2.add(state);
  }

  void emit(S value) {
    state = value;
    _stateController2.add(value);
  }

  void close() {
    _stateController2.close();
  }
}
