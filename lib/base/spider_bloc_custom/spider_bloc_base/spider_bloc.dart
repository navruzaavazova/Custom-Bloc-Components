import 'dart:async';

import 'package:state_using_stream/base/spider_bloc_custom/spider_bloc_base/spider_bloc_base.dart';
import 'package:state_using_stream/base/spider_bloc_custom/spider_bloc_base/spider_bloc_emitter.dart';
import 'package:state_using_stream/base/spider_bloc_custom/spider_bloc_transformer/initial_transformer.dart';

abstract class SpiderBloc<E, S> extends SpiderBlocBase<S> {
  final StreamController<E> _eventController = StreamController<E>.broadcast();
  final Map<Type, EventHandler<dynamic, S>> _handlers = {};
  final _eventTransformer = initialTransformer();

  SpiderBloc(super.initialState) {
    _eventController.stream.listen(_listenEvent);
  }

  void on<T extends E>(EventHandler<T, S> handler,
      {EventTransformer<E>? transformer}) {
    final subscription = (transformer ?? _eventTransformer)(
        _eventController.stream,
        (event) {
      return Stream.value(event);
    });
    subscription.listen((event) {
      _handlers[T]!(
        event,
        Emitter<S>(this),
      );
    });

    _handlers[T] = (event, emit) => handler(event as T, emit);
  }

  void add(E event) {
    if (!_eventController.isClosed) {
      _eventController.add(event);
    }
  }

  Future<void> _listenEvent(E event) async {
    final handler = _handlers[event.runtimeType];
    if (handler != null) {
      await handler(event, Emitter<S>(this));
    }
  }

  @override
  Future<void> close() async {
    await _eventController.close();
  }
}
