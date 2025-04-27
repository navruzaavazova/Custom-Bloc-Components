import 'dart:async';

import 'package:state_using_stream/base/spider_bloc_custom/spider_bloc_base/spider_bloc_base.dart';


typedef EventHandler<E, S> = FutureOr<void> Function(E event, Emitter<S> emit);

class Emitter<S> {
  final SpiderBlocBase<S> _bloc;
  Emitter(this._bloc);

  void call(S state) => _bloc.emit(state);
}