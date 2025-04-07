import 'package:flutter/material.dart';

class SpiderInheritance<T> extends InheritedWidget {
  const SpiderInheritance({super.key, required this.spider, required super.child});
  final T spider;

  static T of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SpiderInheritance>()!.spider;
  }

  @override
  bool updateShouldNotify(covariant SpiderInheritance<T> oldWidget) {
  return oldWidget.spider != spider;
}
}
