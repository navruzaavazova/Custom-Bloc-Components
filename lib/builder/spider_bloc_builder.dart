import 'package:flutter/material.dart';
import 'package:state_using_stream/provider/inheritance/spider_inheritance.dart';
import 'package:state_using_stream/stream/stream_bloc_custom.dart';

class SpiderBlocBuilder<B extends StreamBlocCustom, S> extends StatefulWidget {
  const SpiderBlocBuilder({super.key, required this.builder, this.buildWhen});
  final Widget Function(BuildContext context, S state) builder;
  final bool Function(S previous, S current)? buildWhen;

  @override
  State<SpiderBlocBuilder<B, S>> createState() =>
      _SpiderBlocBuilderState<B, S>();
}

class _SpiderBlocBuilderState<B extends StreamBlocCustom, S>
    extends State<SpiderBlocBuilder<B, S>> {
  S? _previousState;
  @override
  Widget build(BuildContext context) {
    final B bloc = SpiderInheritance.of<B>(context);
    return StreamBuilder(
        stream: bloc.stateStream,
        builder: (context, snapshot) {
          final currentData = snapshot.data;
          if (currentData == null) {
            return const CircularProgressIndicator();
          } else if (widget.buildWhen == null ||
              widget.buildWhen!(_previousState as S, currentData)) {
            _previousState = currentData;
            return widget.builder(context, currentData);
          } else {
            return const SizedBox();
          }
        });
  }
}
