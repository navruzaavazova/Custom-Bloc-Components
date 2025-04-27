import 'dart:async';

class TimeLimit<T> extends StreamTransformerBase<T, T> {
  final Duration duration;
  const TimeLimit(this.duration);
  @override
  Stream<T> bind(Stream<dynamic> stream) {
    late StreamController<T> controller;
    Timer? timer;
    T? lastMention;

    controller = StreamController<T>(
      onListen: () {
        stream.listen((event) {
          lastMention = event;
          timer = Timer(duration, () {
            timer?.cancel();
            if (lastMention != null) {
              controller.add(lastMention as T);
            }
          });
        }, onDone: () {
          timer?.cancel();
          controller.close();
        }, onError: controller.addError);
      },
    );

    return controller.stream;
  }
}
