import 'dart:async';

import 'package:flutter/material.dart';
import 'package:state_using_stream/spider_bloc_custom/spider_bloc_base/spider_bloc_base.dart';
import 'package:state_using_stream/spider_provider/spider_inheritance/spider_inheritance.dart';

class SpiderBlocListener<B extends SpiderBlocBase<S>, S>
    extends StatefulWidget {
  const SpiderBlocListener(
      {super.key,
      this.listenWhen,
      required this.listener,
      required this.child});
  final void Function(BuildContext context, S state) listener;
  final bool Function(S previous, S current)? listenWhen;
  final Widget child;

  @override
  State<SpiderBlocListener<B, S>> createState() =>
      _SpiderBlocListenerState<B, S>();
}

class _SpiderBlocListenerState<B extends SpiderBlocBase<S>, S>
    extends State<SpiderBlocListener<B, S>> {
  StreamSubscription<S>? _subscription;
  late S _previousState;
  late final B _bloc;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
     _bloc = SpiderInheritance.of<B>(context);
    _previousState = _bloc.state;
    _subscribe();
  }

  void _subscribe() {
    _subscription = _bloc.stateStream.listen((state) {
      if (widget.listenWhen?.call(_previousState, state) ?? true) {
        widget.listener(context, state);
      }
      _previousState = state;
    });
  }

  @override
  void dispose() {
     _subscription?.cancel();
    _subscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
