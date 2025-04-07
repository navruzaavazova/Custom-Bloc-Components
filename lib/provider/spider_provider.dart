import 'package:flutter/material.dart';
import 'package:state_using_stream/provider/inheritance/spider_inheritance.dart';

class SpiderProvider<T> extends StatefulWidget {
  const SpiderProvider(
      {super.key, required this.create, required this.child});
  final T Function(BuildContext context) create;
  final Widget child;

  @override
  State<SpiderProvider> createState() => _SpiderProvider();
}

class _SpiderProvider<T> extends State<SpiderProvider<T>> {
  late T _spider;
  @override
  void initState() {
    super.initState();
     _spider = widget.create(context);
  }


  @override
  Widget build(BuildContext context) {
    return SpiderInheritance<T>(spider: _spider, child: widget.child);
  }
}
