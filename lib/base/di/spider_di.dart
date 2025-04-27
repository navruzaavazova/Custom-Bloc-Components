class SpiderDi {
  const SpiderDi._();
  static const SpiderDi _instance = SpiderDi._();

  static SpiderDi get instance => _instance;

  static const Map<Type, dynamic> _singletons = <Type, dynamic>{};
  static const Map<Type, Function> _lazySingletons = <Type, Function>{};

  static void registerSingleton<T>(
    T instance) {
    _singletons[T] = instance;
  }

  static void registerFactory<T>(
    T Function() factory) {
    _lazySingletons[T] = factory;
  }

  static registerLazySingleton<T>(
    T Function() lazy, {
    String? instanceName,
  }) {
    _lazySingletons[T] = lazy;
  }

  static T get<T>() {
    if (_singletons.containsKey(T)) {
      return _singletons[T];
    } else if (_lazySingletons.containsKey(T)) {
      _singletons[T] = _lazySingletons[T]!();
      return _singletons[T];
    } else {
      throw Exception('Not found $T');
    }
  }
}
