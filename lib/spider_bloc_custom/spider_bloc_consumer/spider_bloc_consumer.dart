import 'package:flutter/material.dart';
import 'package:state_using_stream/spider_bloc_custom/spider_bloc_base/spider_bloc_base.dart';
import 'package:state_using_stream/spider_bloc_custom/spider_bloc_builder/spider_bloc_builder.dart';
import 'package:state_using_stream/spider_bloc_custom/spider_bloc_listener/spider_bloc_listener.dart';

class SpiderBlocConsumer<B extends SpiderBlocBase<S>, S>
    extends StatefulWidget {
  const SpiderBlocConsumer(
      {super.key,
      required this.builder,
      this.buildWhen,
      required this.listener,
      this.listenWhen});
  final Widget Function(BuildContext context, S state) builder;
  final bool Function(S previous, S current)? buildWhen;
  final void Function(BuildContext context, S state) listener;
  final bool Function(S previous, S current)? listenWhen;

  @override
  State<SpiderBlocConsumer<B, S>> createState() =>
      _SpiderBlocConsumerState<B, S>();
}

class _SpiderBlocConsumerState<B extends SpiderBlocBase<S>, S>
    extends State<SpiderBlocConsumer<B, S>> {


  @override
  Widget build(BuildContext context) {
    return SpiderBlocListener<B, S>(
      listener: widget.listener,
      listenWhen: widget.listenWhen,
      child: SpiderBlocBuilder<B, S>(builder: widget.builder, buildWhen: widget.buildWhen,),
    );
  }
}
