import 'dart:async';

import 'package:state_using_stream/spider_bloc_custom/spider_bloc_base/spider_bloc_base.dart';

abstract class SpiderBloc<E, S> extends SpiderBlocBase<S> {
  final StreamController<E> _eventController1 = StreamController<E>();

  SpiderBloc(super.state) {
    _eventController1.stream.listen(listenEvent);
  }

  void addEvent(E event) {
    _eventController1.sink.add(event);
  }
  void listenEvent(E event);

  @override
  void close() {
    _eventController1.close();
  }
}
