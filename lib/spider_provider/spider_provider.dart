import 'package:flutter/material.dart';
import 'package:state_using_stream/spider_bloc_custom/spider_bloc_base/spider_bloc_base.dart';
import 'package:state_using_stream/spider_provider/spider_inheritance/spider_inheritance.dart';

class SpiderProvider<T> extends StatefulWidget {
  const SpiderProvider(
      {super.key, required this.create, required this.child});
  final T Function() create;
  final Widget child;

  @override
  State<SpiderProvider<T>> createState() => _SpiderProvider<T>();
}

class _SpiderProvider<T> extends State<SpiderProvider<T>> {
  late final T _spider;
  @override
  void initState() {
    super.initState();
     _spider = widget.create();
  }
  @override
  void dispose() {
    if (_spider is SpiderBlocBase) {
      (_spider as SpiderBlocBase).close();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SpiderInheritance<T>(spider: _spider, child: widget.child);
  }
}
