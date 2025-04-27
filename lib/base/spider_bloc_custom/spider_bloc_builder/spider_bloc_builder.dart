import 'package:flutter/material.dart';
import 'package:state_using_stream/base/spider_bloc_custom/spider_bloc_base/spider_bloc_base.dart';
import 'package:state_using_stream/base/spider_provider/spider_inheritance/spider_inheritance.dart';

class SpiderBlocBuilder<B extends SpiderBlocBase<S>, S> extends StatefulWidget {
  const SpiderBlocBuilder({super.key, required this.builder, this.buildWhen});
  final Widget Function(BuildContext context, S state) builder;
  final bool Function(S previous, S current)? buildWhen;

  @override
  State<SpiderBlocBuilder<B, S>> createState() =>
      _SpiderBlocBuilderState<B, S>();
}

class _SpiderBlocBuilderState<B extends SpiderBlocBase<S>, S>
    extends State<SpiderBlocBuilder<B, S>> {
  S? _previousState;
  Widget? _previousWidget;

  @override
  void initState() {
    super.initState();
    _previousState = SpiderInheritance.read<B>(context).state;
  }

  @override
  Widget build(BuildContext context) {
    final B bloc = SpiderInheritance.of<B>(context);
    return StreamBuilder<S>(
        stream: bloc.stateStream,
        builder: (context, snapshot) {
          if (snapshot.data != null && widget.buildWhen != null) {
            final needUpdate = widget.buildWhen!(
                _previousState ?? bloc.state, snapshot.data ?? bloc.state);
            if (needUpdate) {
              _previousWidget =
                  widget.builder(context, snapshot.data ?? bloc.state);
            }
          } else {
            _previousWidget =
                widget.builder(context, snapshot.data ?? bloc.state);
            widget.builder(context, bloc.state);
          }
          return _previousWidget ?? widget.builder(context, bloc.state);
        });
  }
}
