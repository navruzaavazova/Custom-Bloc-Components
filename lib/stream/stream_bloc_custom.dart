import 'dart:async';

abstract class StreamBlocCustom<E, S> {
  final StreamController<E> _eventController1 = StreamController<E>();
  final StreamController<S> _stateController2 = StreamController<S>();
  S state;
  Stream<S> get stateStream => _stateController2.stream;

  StreamBlocCustom({required this.state}) {
    emit(state);
    _eventController1.stream.listen(listenEvent);
  }

  void addEvent(E event) {
    _eventController1.sink.add(event);
  }

  void emit(S value) {
    state = value;
    _stateController2.add(value);
  }

  void listenEvent(E event);

  void closure() {
    _eventController1.close();
    _stateController2.close();
  }
}
