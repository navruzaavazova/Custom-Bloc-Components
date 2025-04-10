import 'package:flutter/material.dart';

class SpiderInheritance<T> extends InheritedWidget {
  const SpiderInheritance(
      {super.key, required this.spider, required super.child});
  final T spider;

  static T of<T>(BuildContext context) {
    final SpiderInheritance? provider =
        context.dependOnInheritedWidgetOfExactType<SpiderInheritance<T>>();
    assert(provider != null, 'No Spider Inheritance found');
    return provider!.spider;
  }

  @override
  bool updateShouldNotify(covariant SpiderInheritance<T> oldWidget) {
    return false;
  }
}
